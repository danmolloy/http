require 'socket'

server = TCPServer.open(2001)

loop do
  client = server.accept
  request = client.gets.split(" ")
  if request[0] == "GET"
    filename = request[1]
    if File.exists?(filename)
      page = File.open(filename, "r")
      contents = page.read
      page.close
    else
      contents = "Not Found"
    end
  else
    contents = "This server only accepts GET requests"
  end
  client.print(contents)
  client.puts(Time.now.ctime)
  client.puts "Closing the connection."
  client.close
end
