let root = ReactDOM.Client.createRoot(
  ReactDOM.querySelector("#root")->Belt.Option.getExn,
)

ReactDOM.Client.Root.render(
  root,
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)
