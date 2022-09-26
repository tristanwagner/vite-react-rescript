@react.component
let make = (~href: string, ~children: option<React.element>=?) => {
  <a href={href} onClick=(e => {
    e->ReactEvent.Mouse.preventDefault
    RescriptReactRouter.push(href)
  })>
  {switch children {
    | Some(element) => element
    | None => <></>
  }}
  </a>
}
