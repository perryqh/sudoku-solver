require 'spec_helper'

RSpec.describe SudokuSolver::Board do
  include_context 'board inputs'
  subject { described_class.new(puzzle) }
  let(:puzzle) { unsolved_puzzle_1 }
  describe 'valid?' do
    context 'is valid' do
      its(:valid?) { is_expected.to be_truthy }
      its(:valid_rows?) { is_expected.to be_truthy }
      its(:valid_columns?) { is_expected.to be_truthy }
      its(:valid_three_by_threes?) { is_expected.to be_truthy }
    end

    context 'invalid row' do
      let(:puzzle) do
        puzzle       = unsolved_puzzle_1
        puzzle[8][0] = 9
        puzzle
      end
      its(:valid?) { is_expected.to be_falsey }
      its(:valid_rows?) { is_expected.to be_falsey }
      its(:valid_columns?) { is_expected.to be_truthy }
      its(:valid_three_by_threes?) { is_expected.to be_truthy }
    end

    context 'invalid column' do
      let(:puzzle) do
        puzzle       = unsolved_puzzle_1
        puzzle[2][0] = 7
        puzzle
      end
      its(:valid?) { is_expected.to be_falsey }
      its(:valid_rows?) { is_expected.to be_truthy }
      its(:valid_columns?) { is_expected.to be_falsey }
      its(:valid_three_by_threes?) { is_expected.to be_truthy }
    end

    context 'invalid three_by_three' do
      let(:puzzle) do
        puzzle       = unsolved_puzzle_1
        puzzle[0][3] = 9
        puzzle
      end
      its(:valid?) { is_expected.to be_falsey }
      its(:valid_rows?) { is_expected.to be_truthy }
      its(:valid_columns?) { is_expected.to be_truthy }
      its(:valid_three_by_threes?) { is_expected.to be_falsey }
    end
  end

  describe 'solved?' do
    context 'is solved' do
      let(:puzzle) { sovled_puzzle_3 }
      its(:solved?) { is_expected.to be_truthy }
    end

    context 'valid but not solved' do
      its(:solved?) { is_expected.to be_falsey }
    end
  end

  describe 'valid_values_for_position' do
    it 'finds valid values for 0 8' do
      expect(subject.valid_values_for_position(0, 8)).to eq([2, 4, 8])
    end

    it 'finds valid values for 1 1' do
      expect(subject.valid_values_for_position(1, 1)).to eq([2, 4, 7])
    end
  end
end