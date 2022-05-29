import os, threadpool
import protocol

echo("Client application initializing...")

if paramCount() == 0:
  quit("Please specify the server address, e.g. ./client localhost")

let server_addr = paramStr(1)
echo("Connecting to ", $server_addr, "...")

while true:
  let message = spawn stdin.readLine()
  echo("Sending \"", ^message, "\"")