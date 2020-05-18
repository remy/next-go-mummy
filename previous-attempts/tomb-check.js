const h = 4;
const w = 5 + 1;
const length = h * (w - 1);
const tombs = Array.from({ length }, () => 0b1111); // ? $.length
// const grid = Array.from({ length: (h + 1) * (w + 1) }); // ? $.length

let last = 3;

function sort([a, b]) {
  if (a < b) return [a, b];

  return [b, a];
}

function test(i) {
  let res = i - last;
  let axis = 'X';

  const g = res < 0 ? last : i;
  if (res === 1 || res === -1) {
    // X movement
    const h = (1 + g / w) | 0;
    const i = g - h;
    res = [i - (w - 1), i];
  } else {
    axis = 'Y';
    // Y movement
    const i = g - w - ((g / w) | 0);
    res = [i, i + 1];
  }
  last = i;

  // res = sort(res);

  // must happen after sort
  if (axis === 'X') {
    tombs[res[0]] &= 0b1101;
    tombs[res[1]] &= 0b0111;
  } else {
    tombs[res[0]] &= 0b1011;
    tombs[res[1]] &= 0b1110;
  }

  return { axis, res };
}

// [
//   0,
//   1,

// ].forEach(test);

test(2); // ?
test(1); // ?
test(7); // ?
Object.entries(tombs.filter((_, i) => i >= 0 && i < length)); // ?

const i = 17;
const x = 16 + (i % 5) * 48; // ?
const y = 32 + ((i / 5) | 0) * 40; // ?
