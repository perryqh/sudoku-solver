module SudokuSolver
  class Game
    attr_reader :puzzle

    def initialize(puzzle)
      @puzzle = puzzle
    end

    def self.solve(puzzle)
      new(puzzle).solve
    end

    def solve
      solve_it(puzzle)
    end

    def possible_values(puzzle_matrix, row, col)
      Board.valid_values_for_position(puzzle_matrix, row, col)
    end

    def solve_it(puzzle_matrix)
      (0..8).each do |row|
        (0..8).each do |col|
          next if !Board.blank_value?(puzzle_matrix[row][col])

          possibles = possible_values(puzzle_matrix, row, col)
          return if possibles.empty?

          possibles.each do |candidate|
            puzzle_matrix[row][col] = candidate
            return puzzle_matrix if solve_it(puzzle_matrix)
            puzzle_matrix[row][col] = Board::BLANK_VALUE
          end
          return #nothing worked
        end
      end
      puzzle_matrix # success
    end
  end
end