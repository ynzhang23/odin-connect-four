# string-frozen-literal: true

require './lib/player'

describe Player do
  subject(:player) { described_class.new }

  describe '#gets_name' do
    before do
      allow(player).to receive(:gets).and_return('James')
      allow(player).to receive(:puts)
    end

    it 'Gets the player name' do
      player.gets_name
      expect(player.name).to eql('James')
    end
  end
end