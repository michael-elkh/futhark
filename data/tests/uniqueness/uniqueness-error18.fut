// Check that unique components of a return tuple do not alias each
// other.
// --
// error:

fun {*[int], *[int]} main(int n) =
  let a = copy(iota(n)) in
  {a, a}
