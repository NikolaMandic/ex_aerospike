defmodule ExAerospike do
  use GenServer

  defstruct conn: 0,
            namespace: 'test',
            set: 'myset',
            key: "mykey",
            record: ["mybin": "myvalue"],
            bin: "mybin",
            value: "value",
            records: []

  def connect(ip \\ '127.0.0.1', port \\ 6000) do
    {:ok, connectId} = :aerospike.connect(ip, port)
    %ExAerospike{conn: connectId}
  end

  def close(client) do
    :aerospike.shutdown(client.conn)
  end

  def namespace(client, namespace) do
    %{client|namespace: namespace}
  end

  def set(client, set) do
    %{client|set: set}
  end
  
  def write(client, key, records) do
    :aerospike.put(client.conn, client.namespace, client.set, key, records, 0)
  end

  def write(client, key, column, val) do
    :aerospike.put(client.conn, client.namespace, client.set, key, [{column, val}], 0)
  end

  def get(client, key, column) do
    rr = :aerospike.get(client.conn, client.namespace, client.set, key, [column], 0)
    case rr do
      {:citrusleaf_error, _} ->
        rr
      _ ->
        [{_, v}] = rr
        v
    end
  end

  def get(client, key) do
    :aerospike.getAll(client.conn, client.namespace, client.set, key, 0)
  end

  def delete(client, key) do
    :aerospike.delete(client.conn, client.namespace, client.set, key, 0)
  end
end
