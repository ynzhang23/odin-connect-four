# string-frozen-literal: true

require './lib/player'

describe 'Player' do
  subject(:player) { described_class.new }

  describe '#get_name' do
    before do
      allow(:Player).to receive(:gets).and_return('James')
    end

    it 'Gets the player name' do
      player.get_name
      expect(player.name).to eql('James')
    end
  end
end