open Global

module Link = {
  @react.component @module("preact-router")
  external make: (~href: string, ~children: React.element) => React.element = "Link"
}

@react.component
let make = (~routes: array<route>, ~url: string) => {
  routes->Js.log
  <>
    <nav>
      <ul>
        {routes
        ->Js.Array2.map(({name, path}) => {
          <li key={path} className={path === url ? "active" : ""}>
            <Link href={path}> {name->React.string} </Link>
          </li>
        })
        ->React.array}
      </ul>
    </nav>
  </>
}

