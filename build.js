require("esbuild")
  .build({
    entryPoints: ["./src/index.ts"],
    bundle: true,
    outfile: "./dist/server.js",
    platform: "node",
  })
  .catch(() => process.exit(1));
