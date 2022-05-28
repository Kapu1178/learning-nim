type 
  datum = ref object of RootObj
    name: string

  atom = ref object of datum
    loc_x, loc_y: int

proc istype(x: ref object, y: type): bool =
  if x of y:
    return true
  else:
    return false

let mydatum = datum(name:"test")

let myatom = atom(name:"test2",loc_x:1,loc_y:2)

echo(istype(myatom, datum))
echo(istype(mydatum, atom))
