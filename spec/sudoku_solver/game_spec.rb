require 'spec_helper'

RSpec.describe SudokuSolver::Game do
  include_context 'board inputs'
  describe '#solve' do
    specify { expect(described_class.solve(unsolved_puzzle_3)).to eq(sovled_puzzle_3) }
    specify { expect(described_class.solve(unsolved_puzzle_4)).to eq(solved_puzzle_4) }
  end
end