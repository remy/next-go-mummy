const h = 4;
const w = 5 + 1;
const length = h * (w - 1);
const tombs = Array.from({ length }, () => 0b1111); // ? $.length

let last = 0xff;

function sort([a, b]) {
  if (a < b) return [a, b];

  return [b, a];
}

function test(i) {
  let k = i - last;
  let axis = 'X';

  const g = k < 0 ? last : i;
  if (k === 1 || k === -1) {
    // X movement
    const h = (1 + g / w) | 0;
    const i = g - h;
    k = [i - (w - 1), i];
  } else {
    axis = 'Y';
    // Y movement
    const i = g - w - ((g / w) | 0);
    k = [i, i + 1];
  }
  last = i;

  // res = sort(res);

  // must happen after sort
  if (axis === 'X') {
    tombs[k[0]] &= 0b1101;
    tombs[k[1]] &= 0b0111;
  } else {
    tombs[k[0]] &= 0b1011;
    tombs[k[1]] &= 0b1110;
  }

  return { axis, res: k };
}

test(2); // ?
test(1); // ?
// test(7); // ?
Object.entries(tombs.filter((_, i) => i >= 0 && i < length)); // ?

const i = 17;
const x = 16 + (i % 5) * 48; // ?
const y = 32 + ((i / 5) | 0) * 40; // ?
