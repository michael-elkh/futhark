// Test that a variable shape annotation may not be a non-integer.
// --
// error:

fun [int] main(real n, [int,!n] a) =
  map(+2, a)
