@val external math: 'a = "Math"

let teststr = "hello\nworld\n1337\n"

%%raw("console.log('Hi js 🤓')")

let really = %raw("[1, 2, 3]")

@react.component
let make = (~id: option<string>=?) =>
  <>
    <span>
    {switch id {
      | Some(id) => id->React.string
      | None => "No id provided"->React.string
    }}
    </span>
    <Bounds.TestComponent test={"hello from rescript " ++ Js.Float.toString(math["PI"])}/>
    <p>{ (teststr ++ "| char count =>" ++ string_of_int(teststr->Bounds.Utils.len))->React.string }</p>
    <p>{ (teststr ++ "| lines count =>" ++ string_of_int(teststr->Bounds.Utils.lines))->React.string }</p>
    <p>{ (really ++ "| yes, really " ++string_of_int(really->Bounds.Utils.len))->React.string }</p>
  </>
