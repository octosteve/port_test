defmodule PortTest do
  def start_port do
    Port.open({:spawn, "bash --noediting -i"}, [:stderr_to_stdout, :binary, :exit_status])
  end

  def send_command(port, recipient, cmd) do
    send(port, {recipient, {:command, "#{cmd}\n"}})
  end

  def loop(port) do
    IO.puts "Waiting for inputs or something"
    receive do
      {^port, {:data, data}} ->
        IO.puts data
        loop(port)
    end
  end
end
