import asyncdispatch, asyncnet
import protocol

type Client = ref object
  socket: AsyncSocket
  net_addr: string
  id: int
  connected: bool
  alias: string

type Server = ref object
  socket: AsyncSocket
  clients: seq[Client]

proc newServer(): Server = Server(socket: newAsyncSocket(), clients: @[])

proc `$`(client: Client): string =
  $client.id & "(" & client.netAddr & ")"

proc messageClients(server: Server, source_client: Client, message: string) {.async.} =
  for client_iter in server.clients:
    if client_iter.id != source_client.id and client_iter.connected:
      await client_iter.socket.send(message & "\c\l")
  
proc messageClients(server: Server, message: string) {.async.} =
  let message_real = createMessage("SYSTEM", message)
  for client_iter in server.clients:
    if client_iter.connected:
      echo("Tried to send: ", message_real)
      await client_iter.socket.send(message_real) #I dont know why "\c\l" breaks here but it does. Someone please tell me.

proc processMessages(server: Server, client: Client) {.async.} =
  while true:
    let line = await client.socket.recvLine()
    if line.len == 0:
      echo(client, " disconnected.")
      client.connected = false
      client.socket.close()
      return

    echo(client, " sent: ", line)
    asyncCheck(messageClients(server, client, line))


proc loop(server: Server, port = 7687) {.async.} =
  server.socket.bindAddr(port.Port)
  server.socket.listen()
  
  while true:
      let (net_addr, client_socket) = await server.socket.acceptAddr()
      echo("Accepted connection from ", net_addr)
      let new_client = Client(
          socket: client_socket,
          net_addr: net_addr,
          id: server.clients.len,
          connected: true
      )
      server.clients.add(new_client)

      let incoming_message = await new_client.socket.recvLine()
      new_client.alias = parseMessage(incoming_message).username
      let connection_message: string = new_client.alias & " connected"
      echo(connection_message, " from ", new_client.net_addr)
      asyncCheck(messageClients(server, connection_message & "."))

      asyncCheck(processMessages(server, new_client))

var server = newServer()
waitFor loop(server)
