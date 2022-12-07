module TestComponent = {
  @module("./test.jsx") @react.component
  external make: (~test: string) => React.element = "default"
}

module Utils = {
  @module("./utils.js") external lines: string => int = "lines"
  @module("./utils.js") external len: 'a => int = "len"
}
