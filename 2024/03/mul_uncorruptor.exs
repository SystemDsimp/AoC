defmodule Uncorruptor do
  def extract_muls(line) do
    regex = ~r/mul\((\d{1,3}),(\d{1,3})\)/

    Regex.scan(regex, line)
    |> Enum.map(fn [full, a, b] -> {full, String.to_integer(a), String.to_integer(b)} end)
  end
end

found_muls =
  File.stream!("input.txt")
  |> Enum.map(&Uncorruptor.extract_muls/1)

result =
  List.flatten(found_muls)
  |> Enum.reduce(0, fn {_full, a, b}, acc -> acc = acc + a * b end)
  |> IO.inspect()
