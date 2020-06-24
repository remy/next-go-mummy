const fs = require('fs');
const { basename } = require('path');

const encode = (a) => {
  a = a.toString();
  const res = [];
  for (let i = 0; i < a.length; i++) {
    res.push(a.charCodeAt(i));
  }
  return Uint8Array.from(res);
};

const calculateXORChecksum = (array, display = false) => {
  const byte = new DataView(Uint8Array.of(0).buffer);
  for (let i = 0; i < array.length; i++) {
    byte.setUint8(0, byte.getUint8(0) ^ array[i]);
  }

  return byte.getUint8(0);
};

const tapHeader = (
  code,
  { filename = 'BASIC', autostart = 0, type = 0, p2 = null } = {}
) => {
  const header = new Uint8Array(21);
  const dataView = new DataView(header.buffer);

  let p1 = autostart;
  if (type === 0 && p2 === null) {
    p2 = code.length;
  }
  if (type === 3) {
    if (p2 === null) p2 = 32768;
    p1 = autostart || 0;
  }

  dataView.setUint16(0, 19, true); // header length
  dataView.setUint8(2, 0); // flag byte
  dataView.setUint8(3, type); // [Program, Number array, Character array, Code file]
  header.set(encode(filename.padEnd(10, ' ').slice(0, 10)), 4);
  dataView.setUint16(14, code.length, true);
  dataView.setUint16(16, p1, true);
  dataView.setUint16(18, p2, true);
  const checksum = calculateXORChecksum(header.slice(2, 20), true);
  dataView.setUint8(20, checksum);

  return header;
};

// const param2 = [0, 12 << 12, 0xfa00, 12 << 12];

function tapper(filenames, { type = 0, autostart = 0 } = {}) {
  const blocks = filenames.map((filename) => {
    return checkForHeader(fs.readFileSync(filename));
  });

  const length = blocks.reduce((acc, curr) => {
    return acc + 21 + curr.length + 4;
  }, 0);

  const tap = new Uint8Array(length);
  const dataView = new DataView(tap.buffer);
  let offset = 0;

  blocks.forEach((block, i) => {
    const filename = basename(filenames[i]);

    let type = i === 0 ? 0 : 3;
    let autostart = 10;
    let p2 = null;

    if (filename.toLowerCase().endsWith('.scr')) {
      autostart = 0x4000;
      type = 3;
    } else if (filename.toLowerCase().endsWith('.bas')) {
      type = 0;
      autostart = 10;
    } else {
      autostart = 0xc000; //param2[i];
      p2 = 0x8000;
    }

    const header = tapHeader(block, {
      filename,
      autostart,
      type,
      p2,
    });

    tap.set(header, offset);
    offset += header.length;
    dataView.setUint16(offset, block.length + 2, true);
    offset += 2;
    dataView.setUint8(offset, 0xff);
    offset += 1;
    tap.set(block, offset);
    const checksum = calculateXORChecksum(
      tap.slice(offset - 1, offset + block.length)
    );
    offset += block.length;
    dataView.setUint8(offset, checksum, true);
    offset += 1;
  });

  return tap;
}

function checkForHeader(code) {
  const sig = code.slice(0, 8);
  if (new TextDecoder().decode(sig) === 'PLUS3DOS') {
    return code.slice(128);
  }
  return code;
}

const tap = tapper(process.argv.slice(2)); //?

fs.writeFileSync('result.tap', tap);
