module SudokuSolver
  class Board
    attr_reader :puzzle_matrix
    BLANK_VALUE = 0

    def self.blank_value?(val)
      val == BLANK_VALUE
    end

    def initialize(puzzle_matrix)
      @puzzle_matrix = puzzle_matrix.collect(&:clone)
    end

    def self.valid_values_for_position(puzzle_matrix, row, col)
      new(puzzle_matrix).valid_values_for_position(row, col)
    end

    def solved?
      without_blanks(puzzle_matrix.flatten).length == 81 && valid?
    end

    def valid_values_for_position(row, col)
      (1..9).select do |candidate|
        puzzle_matrix[row][col] = candidate
        valid?
      end
    end

    def valid?
      valid_rows? && valid_columns? && valid_three_by_threes?
    end

    def valid_rows?
      puzzle_matrix.all? { |row| valid_number_set?(row) }
    end

    def valid_columns?
      (0..8).all? do |col|
        column = puzzle_matrix.collect do |row|
          row[col]
        end
        valid_number_set?(column)
      end
    end

    def valid_number_set?(nums)
      without_blanks(nums).uniq.length == without_blanks(nums).length
    end

    def without_blanks(nums)
      nums.reject { |n| self.class.blank_value?(n) }
    end

    def valid_three_by_threes?
      [0, 3, 6].all? do |row|
        [0, 3, 6].all? do |col|
          sub = build_sub_matrix(row, col)
          valid_number_set?(sub.flatten)
        end
      end
    end

    def build_sub_matrix(start_row, start_col)
      (0..2).collect do |row|
        (0..2).collect do |col|
          puzzle_matrix[start_row + row][start_col + col]
        end
      end
    end
  end
end