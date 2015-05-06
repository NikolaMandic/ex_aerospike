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

  def close(conn) do
    a = conn
    :aerospike.shutdown(a.conn)
  end

  def namespace(conn, namespace) do
    %{conn|namespace: namespace}
  end

  def set(conn, set) do
    %{conn|set: set}
  end
  
  def write(conn, key, records) do
    a = conn
    writeResult = :aerospike.put(a.conn,
                                 a.namespace,
                                 a.set,
                                 key,
                                 records,
                                 0)
  end

  def write(conn, key, column, val) do
    a = conn
    writeResult = :aerospike.put(a.conn, a.namespace, a.set, key, [{column, val}], 0)
  end

  def get(conn, key, column) do
    a = conn 
    rr = :aerospike.get(a.conn, a.namespace, a.set, key, [column], 0)
    case rr do
      {:citrusleaf_error, _} ->
        rr
      _ ->
        [{_, v}] = rr
        v
    end
  end

  def get(conn, key) do
    a = conn
    rr = :aerospike.getAll(a.conn, a.namespace, a.set, key, 0)
    rr
  end

  def delete(conn, key) do
    writeResult = :aerospike.delete(conn.conn, conn.namespace, conn.set, key, 0)
  end
end
