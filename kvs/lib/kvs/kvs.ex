defmodule Kvs.Kvs do
  use GenServer, restart: :transient

  def start_link(store) do
    GenServer.start_link(__MODULE__, store, name: __MODULE__)
  end

  def insert(key, value) do
    GenServer.cast(__MODULE__, {:insert, key, value})
  end

  def select(key) do
    GenServer.call(__MODULE__, {:select, key})
  end

  def update(key, value) do
    GenServer.cast(__MODULE__, {:update, key, value})
  end

  def delete(key) do
    GenServer.cast(__MODULE__, {:delete, key})
  end

  def init(store) do
    {:ok, store}
  end

  def handle_cast({:insert, key, value}, store) do
    if Map.has_key?(store, key) do
      {:noreply, store}
    else
      {:noreply, Map.put(store, key, value)}
    end
  end

  def handle_cast({:update, key, value}, store) do
    if Map.has_key?(store, key) do
      {:noreply, Map.put(store, key, value)}
    else
      {:noreply, store}
    end
  end

  def handle_cast({:delete, key}, state) do
    {:noreply, Map.delete(state, key)}
  end

  def handle_call({:select, key}, _from, store) do
    {:reply, Map.get(store, key), store}
  end

end
