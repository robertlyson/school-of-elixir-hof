defmodule HighOrderFunction do
  def repeat(a, _, 0), do: a
  def repeat(a, f, t) do
    repeat(Enum.map(a,f), f, t-1)
  end
end
