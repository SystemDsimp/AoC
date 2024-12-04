defmodule XmasFinder do
  def read_grid(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end

  def count_xmas(grid) do
    horizontal_count = count_horizontal(grid)
    vertical_count = count_vertical(grid)
    diagonal = count_horizontal(iterate_diagonally(grid))
    reversed_grid = Enum.map(grid, &Enum.reverse/1)
    diagonal_reversed = count_horizontal(iterate_diagonally(reversed_grid))

    horizontal_count + vertical_count + diagonal + diagonal_reversed
  end

  defp count_horizontal(grid) do
    grid
    |> Enum.map(fn row ->
      row
      |> Enum.chunk_every(4, 1, :discard)
      |> Enum.count(fn chunk ->
        chunk == ["X", "M", "A", "S"] || chunk == ["S", "A", "M", "X"]
      end)
    end)
    |> Enum.sum()
  end

  defp count_vertical(grid) do
    # Transpose the grid to turn columns into rows
    grid
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    # Reuse horizontal count on transposed grid
    |> count_horizontal()
  end

  def iterate_diagonally(grid) do
    size = length(grid)

    # Main diagonal and above
    upper =
      for offset <- 0..(size - 1) do
        for i <- 0..(size - 1 - offset) do
          grid
          |> Enum.at(i)
          |> Enum.at(i + offset)
        end
      end

    lower =
      for offset <- 1..(size - 1) do
        for i <- 0..(size - 1 - offset) do
          grid
          |> Enum.at(i + offset)
          |> Enum.at(i)
        end
      end

    upper ++ lower
  end
end

grid = XmasFinder.read_grid("input.txt")
count = XmasFinder.count_xmas(grid)

IO.puts(count)
# IO.inspect(diag)
