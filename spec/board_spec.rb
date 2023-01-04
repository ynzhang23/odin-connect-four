# frozen-string-literal: true

require './lib/board'
require './lib/player'

describe Board do
  subject(:board) { described_class.new }

  describe '#valid_column?' do
    context 'When the user enters a valid number' do
      it 'Returns true' do
        column = 7
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
        column = 8
        result = board.valid_column?(column)
        expect(result).to eql(false)
      end
    end
  end

  describe '#full_column?' do
    context 'When the column is not full' do
      subject(:full_board) { described_class.new }
      before do
        full_board.columns[1] = Array.new(5)
      end

      it 'Returns false' do
        column = 1
        result = full_board.full_column?(column)
        expect(result).to eql(false)
      end
    end

    context 'When the column is full' do
      subject(:full_board) { described_class.new }
      before do
        full_board.columns[1] = Array.new(6)
      end

      it 'Returns true' do
        column = 1
        result = full_board.full_column?(column)
        expect(result).to eql(true)
      end
    end
  end

  describe '#gets_move' do
    valid_error_msg = 'Invalid column'
    full_error_msg = 'Column full'

    context 'When move is allowed' do
      before do
        allow(board).to receive(:gets).and_return('1')
        allow(board).to receive(:puts).with('Please select a column')
      end

      it 'Does not return error message' do
        expect(board).to_not receive(:puts).with(valid_error_msg)
        expect(board).to_not receive(:puts).with(full_error_msg)
        board.gets_move
      end
    end

    context 'When first move column is not valid column, second move is allowed' do
      before do
        valid_input = '1'
        invalid_input = 'a'
        allow(board).to receive(:gets).and_return(invalid_input, valid_input)
        allow(board).to receive(:puts).with('Please select a column')
      end

      it 'Returns error message (valid)' do
        expect(board).to receive(:puts).with(valid_error_msg).once
        board.gets_move
      end
    end

    context 'When first move column is full, second move is allowed' do
      subject(:full_board) { described_class.new }
      before do
        full_board.columns[2] = Array.new(6)
        valid_input = '1'
        full_input = '2'
        allow(full_board).to receive(:gets).and_return(full_input, valid_input)
        allow(full_board).to receive(:puts).with('Please select a column')
      end

      it 'Returns error message (full)' do
        expect(full_board).to receive(:puts).with(full_error_msg).once
        full_board.gets_move
      end
    end

    context 'When first move column is full, second move is not valid column, third move is allowed' do
      subject(:full_board) { described_class.new }
      before do
        full_board.columns[2] = Array.new(6)

        invalid_input = 'a'
        valid_input = '1'
        full_input = '2'
        allow(full_board).to receive(:gets).and_return(invalid_input, full_input, valid_input)

        allow(full_board).to receive(:puts).with('Please select a column')
      end

      it 'Returns error message (full) (invalid)' do
        expect(full_board).to receive(:puts).with(full_error_msg)
        expect(full_board).to receive(:puts).with(valid_error_msg)
        full_board.gets_move
      end
    end
  end

  describe '#update_board' do
    subject(:player) { Player.new('john', '☻') }
    before do
      allow(board).to receive(:gets_move).and_return(1)
    end

    it 'Push the player name into the column array' do
      board.update_board(player)
      expect(board.columns[1][-1]).to eql(player.symbol)
    end
  end
end
