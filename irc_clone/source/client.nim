import os, threadpool, asyncdispatch, asyncnet
import protocol

proc connect(socket: AsyncSocket, server_addr, username: string) {.async.} =
  echo("Connecting to ", server_addr, "...")
  await socket.connect(server_addr, 7687.Port)
  echo("Connection established.")
  await socket.send(createMessage(username, "Hello server."))

  while true:
    let line = await socket.recvLine()
    echo("Line: ", line)
    let parsed = parseMessage(line)
    echo(parsed.username, ": ", parsed.message)


if paramCount() < 2:
  quit("Please specify the server address, e.g. ./client localhost")


let server_addr = paramStr(1)
let username = paramStr(2)
var my_socket = newAsyncSocket()
asyncCheck(connect(my_socket, server_addr, username))
#asyncCheck(my_socket.send(createMessage(username, "connected.")))


var message_flow_var: FlowVar[auto] = spawn stdin.readLine()
while true:
  if message_flow_var.isReady():
    let message = createMessage(username, ^message_flow_var)
    asyncCheck(my_socket.send(message))
    message_flow_var = spawn stdin.readline()

  asyncdispatch.poll()