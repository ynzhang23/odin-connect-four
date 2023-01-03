# string-frozen-literal: true

require './lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#valid_column?' do
    context 'When the user enters a valid number' do
      it 'Returns true' do
        column = '7'
        result = board.valid_column?(column)
        expect(result).to eql(true)
      end
    end

    context 'When the user enters a non-integer' do
      it 'Returns false' do
        column = 'a'
        result = board.valid_column?(column)
        expect(result).to eql(false)
      end
    end

    context 'When the user enters a invalid number' do
      it 'Returns false' do
        column = '8'
        result = board.valid_column?(column)
        expect(result).to eql(false)
      end
    end
  end

  describe '#full_column?' do
    context 'When the column is not full' do
      subject(:full_board) { described_class.new }
      before do
        full_board.columns['1'] = Array.new(5)
      end

      it 'Returns false' do
        column = '1'
        result = full_board.full_column?(column)
        expect(result).to eql(false)
      end
    end

    context 'When the column is full' do
      subject(:full_board) { described_class.new }
      before do
        full_board.columns['1'] = Array.new(6)
      end

      it 'Returns true' do
        column = '1'
        result = full_board.full_column?(column)
        expect(result).to eql(true)
      end
    end
  end
end
