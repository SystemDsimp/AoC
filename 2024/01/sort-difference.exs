defmodule Sorter do
  def process_file(file_path) do
    {list1, list2} =
      File.stream!(file_path)
      |> Enum.reduce({[], []}, fn line, {list1, list2} ->
        # Split the line by whitespace
        [first, second] = String.split(line)
        # Append to the respective lists
        {[String.to_integer(first) | list1], [String.to_integer(second) | list2]}
      end)
    # Reverse and sort the lists
    {Enum.sort(Enum.reverse(list1)), Enum.sort(Enum.reverse(list2))}
  end

  def absolute_difference(lists) do
      {list1, list2} = lists
      Enum.zip(list1, list2)
      |> Enum.map(fn {a, b} -> abs(a - b) end)
  end
end

result =
  Sorter.process_file("input.txt")
  |> Sorter.absolute_difference()
  |> Enum.sum()

IO.inspect(result, label: "result: ")
