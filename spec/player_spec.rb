# string-frozen-literal: true

require './lib/player'

describe Player do
  subject(:player) { described_class.new }

  describe '#gets_name' do
    before do
      allow(player).to receive(:gets).and_return('James')
      allow(player).to receive(:name_question)
    end

    it 'Gets the player name' do
      player.gets_name
      expect(player.name).to eql('James')
    end
  end

  describe '#update_symbol' do
    context 'When the player chooses option 1' do
      before do 
        allow(player).to receive(:gets_symbol).and_return('1')
      end

      it 'Modifies the player symbol to ☻' do
        player.update_symbol
        expect(player.symbol).to eql('☻')
      end
    end

    context 'When the player chooses option 2' do
      before do 
        allow(player).to receive(:gets_symbol).and_return('2')
      end

      it 'Modifies the player symbol to ☺' do
        player.update_symbol
        expect(player.symbol).to eql('☺')
      end
    end
  end

  describe '#valid_symbol?' do
    context 'When player enters a wrong input' do
      it 'Returns false' do
        choice = '3'
        result = player.valid_symbol?(choice)
        expect(result).to eql(false)
      end
    end

    context 'When player enters no input' do
      it 'Returns false' do
        choice = nil
        result = player.valid_symbol?(choice)
        expect(result).to eql(false)
      end
    end

    context 'When player enters the right input' do
      it 'Returns true' do
        choice = '2'
        result = player.valid_symbol?(choice)
        expect(result).to eql(true)
      end
    end
  end
end
