### ExAerospike [![Hex.pm](https://img.shields.io/hexpm/v/exredis.svg)](https://hex.pm/packages/ex_aerospike)

---

A simple wrapper for Aerospike's Erlang driver

---

### Installation

---

Add the following tuple to your dependencies list
```elixir
{:ex_aerospike, ">= 0.0.1"}
```

---

### Usage

__Connecting to an Aerospike database__
```elixir
client = ExAerospike.connect('127.0.0.1', 6000)
```

__Disconnecting__
```elixir
client |> ExAerospike.close
```

__Changing the namespace__
```elixir
client |> ExAerospike.namespace('myNamespace')
```

__Changing the set__
```elixir
client |> ExAerospike.set('mySetName')
```

__Fetching a bin from a key__
```elixir
client |> ExAerospike.get('key', 'binName')
```

__Fetching all values from a key__
```elixir
client |> ExAerospike.get('key')
```

__Writing a record__
```elixir
client |> ExAerospike.write('key', 'bin', 'value')
# or
client |> ExAerospike.write('key', ['bin': 'value'])
# for multiple bins
client |> ExAerospike.write('key', ['bin': 'value', 'anotherBin': 'another value'])
```

__Deleting a record__
```elixir
client |> ExAerospike.delete('key')
```
