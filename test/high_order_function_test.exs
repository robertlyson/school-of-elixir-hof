defmodule HighOrderFunctionTest do
  use ExUnit.Case
  use ExUnitProperties
  doctest HighOrderFunction

  property "calling repeat with t = 2 parameter is the same as calling map over enum twice" do
    f = fn x -> x + 1 end

    check all i <- StreamData.list_of(StreamData.integer(), length: 3) do
      assert (Enum.map(i, f) |> Enum.map(f)) === HighOrderFunction.repeat(i, f, 2)
    end
  end
  
  property "fibonacci implemented with repeat function produces same output as standard one" do 
    check all i <- integer(1..10) do
      assert fib(i) === fibonacci(i)
    end
  end

  def fibonacci(n) do
    List.first(HighOrderFunction.repeat([0, 1], &fibonacci/2, n))
  end

  defp fibonacci(a, b) do
    [b, a + b]
  end

  def fib(0) do 0 end
  def fib(1) do 1 end
  def fib(n) do fib(n-1) + fib(n-2) end

end