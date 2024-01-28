type person = Teacher | Director | Student(string)

let greeting = person =>
  switch person {
    | Teacher => "Hey teacher !"
    | Director => "Hello director !"
    | Student("Tristan") => "Is that you tristan ?"
    | Student(name) => "Oh hello there " ++ name ++ " !"
  }

@react.component
let make = () => {
  let persons = [Student("Jim"), Teacher, Director, Student("Tristan")]
 <>
    { persons->Array.mapWithIndex((person, index) => <p key={string_of_int(index)}>{greeting(person)->React.string}</p>)->React.array }
  </>
}
