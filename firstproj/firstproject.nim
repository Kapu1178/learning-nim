proc exampleProc(num: int|float): int =
  num + 1

proc exampleProc2(num: int|float): int =
  var result = num + 1
  discard num

echo(exampleProc(2))
echo(exampleProc2(2))