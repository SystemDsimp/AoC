defmodule SafeLevels do
  def split_to_int(line) do
    String.split(line)
    |> Enum.map(&String.to_integer/1)
  end

  def check_safe(levels) do
    differences =
      Enum.zip(levels, tl(levels))
      |> Enum.map(fn {a, b} -> b - a end)

    valid_differences = Enum.all?(differences, fn diff -> abs(diff) in 1..3 end)

    consistent_direction =
      Enum.all?(differences, &(&1 > 0)) or Enum.all?(differences, &(&1 < 0))

    valid_differences and consistent_direction
  end
end

reports =
  File.stream!("input.txt")
  |> Enum.map(&SafeLevels.split_to_int/1)

safe_count =
  reports
  |> Enum.filter(&SafeLevels.check_safe/1)
  |> Enum.count()

IO.puts("Number of safe reports: #{safe_count}")
