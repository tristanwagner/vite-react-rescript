@react.component
let make = (~id: option<string>=?) =>
  <>
    <span>
    {switch id {
      | Some(id) => id->React.string
      | None => "No id provided"->React.string
    }}
    </span>
  </>
