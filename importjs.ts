const importObject = {
  console: {
    log: function (arg: unknown[]) {
      console.log(arg);
    },
  },
};

const wasmCode = await Deno.readFile("./a.wasm");
const wasmModule = new WebAssembly.Module(wasmCode);
const wasmInstance = new WebAssembly.Instance(wasmModule, importObject);
const main = wasmInstance.exports.main as CallableFunction;
main(...Deno.args);
