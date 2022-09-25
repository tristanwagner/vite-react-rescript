open Webapi.Dom

module Router = {
  @react.component @module("preact-router")
  external make: (~url: string, ~children: React.element) => React.element = "Router"
}

%%raw(`import './App.css'`)

@react.component
let make = () => {
  <>
    <Router url={window->Window.location->Location.pathname}>
    {
      RoutesModule.getRoutesComponents()
    }
    </Router>
  </>
}
