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
end
