open Global

@react.component
let make = (~routes: array<route>, ~url: string) => {
  <>
    <nav>
      <ul>
      {routes
      ->Array.map(({name, path}) => {
        <li key={path} className={
          switch path {
            | "/" => path === url ? "active" : ""
            | _ => path->String.startsWith(url) ? "active" : ""
          }
        }>
        <Link href={path}> {name->React.string} </Link>
        </li>
      })
      ->React.array}
      </ul>
    </nav>
  </>
}

