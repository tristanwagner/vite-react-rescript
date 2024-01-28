let fizzbuzz = (i) =>
  switch (mod(i, 3), mod(i, 5)){
    | (0, 0) => "FizzBuzz"
    | (0, _) => "Fizz"
    | (_, 0) => "Buzz"
    | _ => string_of_int(i)
  }

let results = []

for i in 1 to 20 {
  results->Array.push(fizzbuzz(i))->ignore
}

@react.component
let make = () => {
 <>
  {
    results->Array.mapWithIndex((res, index) => <p key={string_of_int(index)}>{res->React.string}</p>)->React.array
  }
 </>
}
