#!/usr/bin/env deno run --allow-env --allow-run --allow-read

import { join } from "https://deno.land/std@0.104.0/path/mod.ts";
import * as log from "https://deno.land/std@0.104.0/log/mod.ts";
import {
  copy,
  readerFromStreamReader,
} from "https://deno.land/std@0.104.0/io/mod.ts";

const __dirname = new URL(".", import.meta.url).pathname;

var binaryPath;
var binary;

if (Deno.build.os === "windows") {
  binary = "hugo-win-amd64.exe";
  binaryPath = join(__dirname, "bin", "hugo-win-amd64.exe").slice(1);
} else if (Deno.build.os === "darwin") {
  binary = "hugo-darwin-amd64";
  binaryPath = join(__dirname, "bin", "hugo-darwin-amd64");
} else if (Deno.build.os === "linux") {
  binary = "hugo-linux-amd64";
  binaryPath = join(__dirname, "bin", "hugo-linux-amd64");
} else {
  log.critical("⚠ Unsupported platform: " + Deno.build.os);
}

if (!binaryPath) {
  Deno.exit(0);
}

// Download binary
// log.info('Download hugo ...');
// const res = await fetch(
//   "https://github.com/stephendltg/mysite/releases/download/v0.0.1/" + binary,
//   { redirect: "follow" },
// );
// const file = await Deno.open("./bin/" + binary, {
//   create: true,
//   write: true,
// });
// const reader = readerFromStreamReader(res.body!.getReader());
// await copy(reader, file);
// file.close();

// create hugo
const hugo = Deno.run({
  cmd: [binaryPath, ...Deno.args],
  stdout: "inherit",
  stderr: "piped",
});

// await its completion
const { code } = await hugo.status();
const rawError = await hugo.stderrOutput();

if (code === 0) {
  log.info("Hugo run ...", Deno.args);
} else {
  const errorString = new TextDecoder().decode(rawError);
  log.warning(errorString);
}

Deno.exit(code);
