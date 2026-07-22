#!/usr/bin/env node
// Test: ¿Node/JS corre en esta máquina?
console.log("OK: JS ejecuta");
console.log("version :", process.version);
console.log("exe     :", process.execPath);
console.log("platform:", process.platform, process.arch);
console.log("cwd     :", process.cwd());

if (1 + 1 !== 2) {
  console.error("assert  : fail");
  process.exit(1);
}
console.log("assert  : pass");
console.log("RESULT  : SUCCESS");
