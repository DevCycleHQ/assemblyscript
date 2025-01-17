export default function runner(exports, runs, allocs) {
  const alloc = exports["heap_alloc"];
  const free  = exports["heap_free"];
  const reset = exports["heap_reset"];
  const fill  = exports["memory_fill"];

  const ptrs = [];

  function randomAlloc(maxSize) {
    if (!maxSize) maxSize = 8192;
    var size = ((Math.random() * maxSize) >>> 0) + 1;
    size = (size + 3) & ~3;
    var ptr = alloc(size, 0);
    if (!ptr) throw Error();
    if ((ptr & 15) != 0) throw Error("invalid alignment: " + (ptr & 15) + " on " + ptr);
    if (ptrs.indexOf(ptr) >= 0) throw Error("duplicate pointer");
    if (fill) fill(ptr, ptr % 16, size);
    ptrs.push(ptr);
    return ptr;
  }

  function preciseFree(ptr) {
    var idx = ptrs.indexOf(ptr);
    if (idx < 0) throw Error("unknown pointer");
    ptr = ptrs[idx];
    ptrs.splice(idx, 1);
    if (typeof ptr !== "number") throw Error();
    free(ptr);
  }

  function randomFree() {
    var idx = (Math.random() * ptrs.length) >>> 0;
    var ptr = ptrs[idx];
    if (typeof ptr !== "number") throw Error();
    ptrs.splice(idx, 1);
    free(ptr);
  }

  // remember the smallest possible memory address
  var base = alloc(64, 0);
  console.log("base: " + base);
  try {
    reset();
  } catch (e) {
    free(base);
  }
  var currentMem = exports.memory.buffer.byteLength;
  console.log("mem initial: " + currentMem);

  function testMemChanged() {
    var actualMem = exports.memory.buffer.byteLength;
    if (actualMem > currentMem) {
      console.log("mem changed: " + currentMem + " -> " + actualMem);
      currentMem = actualMem;
    }
  }

  try {
    for (var j = 0; j < runs; ++j) {
      console.log("run " + (j + 1) + " (" + allocs + " allocations) ...");
      for (var i = 0; i < allocs; ++i) {
        var ptr = randomAlloc();
        testMemChanged();

        // immediately free every 4th
        if (!(i % 4)) preciseFree(ptr);

        // occasionally free random blocks
        else if (ptrs.length && Math.random() < 0.33) randomFree();

        // ^ sums up to clearing about half the blocks half-way
      }
      // free the rest, randomly
      while (ptrs.length) randomFree();

      try {
        reset();
        let ptr = alloc(64, 0);
        if (ptr !== base) throw Error("expected " + base + " but got " + ptr);
        reset();
      } catch (e) {
        // should now be possible to reuse the entire memory
        // just try a large portion of the memory here, for example because of
        // SL+1 for allocations in TLSF
        let size = ((exports.memory.buffer.byteLength - base) * 9 / 10) >>> 0;
        let ptr = alloc(size, 0);
        // if (fill) fill(ptr, 0xac, size);
        if (ptr !== base) throw Error("expected " + base + " but got " + ptr);
        free(ptr);
      }
      testMemChanged();
    }
  } finally {
    // mem(exports.memory, 0, 0x800);
  }
}

/* function mem(memory, offset, count) {
  if (!offset) offset = 0;
  if (!count) count = 1024;
  var mem = new Uint8Array(memory.buffer, offset);
  // var stackTop = new Uint32Array(memory.buffer, 4, 1)[0];
  var hex = [];
  for (var i = 0; i < count; ++i) {
    var o = (offset + i).toString(16);
    while (o.length < 4) o = "0" + o;
    if ((i & 15) === 0) {
      hex.push("\n" + o + ":");
    }
    var h = mem[i].toString(16);
    if (h.length < 2) h = "0" + h;
    hex.push(h);
  }
  console.log(hex.join(" ") + " ...");
} */

if (typeof module === "object" && typeof exports === "object") module.exports = runner;
