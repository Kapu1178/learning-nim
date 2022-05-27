import std/strformat

var mylist = newSeq[string] (3)
mylist[0] = "Foo"
mylist[1] = "Bar"
mylist[2] = "Baz"

mylist.add("Lorem")

proc printList(list : seq) =
    var val = $list[0]
    defer: echo(val)

    if list.len == 0:
        return
    for item in 1 .. list.len-1:
        val &= fmt", {list[item]}"

printList(mylist)