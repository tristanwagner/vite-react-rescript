module ReactTestingLibrary = {
  @module("@testing-library/react")
  external render: React.element => unit = "render"

  type renderResult
  @module("@testing-library/react")
  external screen: renderResult = "screen"

  @send external getByText: (renderResult, string) => Dom.htmlElement = "getByText"
}

module JsDom = {
  @send
  external toBeInTheDocument: Vitest.expected<Dom.htmlElement> => unit = "toBeInTheDocument"
}
