defmodule Kvs.KvsTest do
  use ExUnit.Case
  alias Kvs.Kvs

  test "insert new key" do
    key = random_string(10)
    value = random_string(10)
    Kvs.insert(String.to_atom(key), value)

    assert Kvs.select(String.to_atom(key)) == value
  end

  test "insert key exists" do
    key = random_string(10)
    value1 = random_string(10)
    value2 = random_string(10)
    Kvs.insert(String.to_atom(key), value1)
    Kvs.insert(String.to_atom(key), value2)

    assert Kvs.select(String.to_atom(key)) == value1
  end

  test "select key does not exist" do
    assert Kvs.select(String.to_atom(random_string(10))) == nil
  end

  test "update key exists" do
    key = random_string(10)
    value1 = random_string(10)
    value2 = random_string(10)
    Kvs.insert(String.to_atom(key), value1)
    Kvs.update(String.to_atom(key), value2)

    assert Kvs.select(String.to_atom(key)) ==value2
  end

  test "update key does not exist" do
    key = random_string(10)
    Kvs.update(String.to_atom(key), random_string(10))

    assert Kvs.select(String.to_atom(key)) == nil
  end

  test "delete key exists" do
    key = random_string(10)
    Kvs.insert(String.to_atom(key), random_string(10))
    Kvs.delete(String.to_atom(key))

    assert Kvs.select(String.to_atom(key)) == nil
  end

  test "delete key does not exist" do
    key = random_string(10)
    Kvs.delete(String.to_atom(key))

    assert Kvs.select(String.to_atom(key)) == nil
  end

  defp random_string(length) do
    lower = Enum.to_list(?a..?z)
    upper = Enum.to_list(?A..?Z)
    digit = Enum.to_list(?0..?9)
    seed = Enum.concat(lower, upper) |> Enum.concat(digit)

    for _ <- 1..length, into: "", do: <<Enum.random(seed)>>
  end
end
