type status =
  | Enabled
  | Disabled

@react.component
let make = (~path: string) => {
  let (state, setState) = React.useState(() => Enabled)
  <>
    <Nav url={path} />
    <h1>{"Toggle"->React.string}</h1>
      <button onClick={e => setState(s => s === Enabled ? Disabled : Enabled)}>
      {
        switch state {
          | Enabled => React.string("Enabled")
          | Disabled => React.string("Disabled")
        }
      }
      </button>
  </>
}

