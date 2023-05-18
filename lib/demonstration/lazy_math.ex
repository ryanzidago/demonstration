defmodule Demonstration.LazyMath do
  @moduledoc """
  https://www.germanvelasco.com/blog/build-your-own-lazy-operation-evaluator-in-elixir
  """
  defstruct initial: 0, ops: []

  def new(initial), do: %__MODULE__{initial: initial}

  def add(%{ops: ops} = math, number) do
    %__MODULE__{math | ops: [{:add, number} | ops]}
  end

  def subtract(%{ops: ops} = math, number) do
    %__MODULE__{math | ops: [{:subtract, number} | ops]}
  end

  def multiply(%{ops: ops} = math, number) do
    %__MODULE__{math | ops: [{:multiply, number} | ops]}
  end

  def divide(%{ops: ops} = math, number) do
    %__MODULE__{math | ops: [{:divide, number} | ops]}
  end

  def evaluate(%__MODULE__{initial: initial, ops: ops}) do
    ops
    |> Enum.reverse()
    |> Enum.reduce(initial, fn
      {:add, n}, acc -> acc + n
      {:subtract, n}, acc -> acc - n
      {:multiply, n}, acc -> acc * n
      {:div, n}, acc -> div(acc, n)
    end)
  end
end
