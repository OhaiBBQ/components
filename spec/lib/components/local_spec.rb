require_relative '../../../lib/components'

describe Components::Local do
  describe '#extract_match' do
    let(:text) { '{{section foo}}bar' }
    
    subject { Components::Local.new('section').extract_match(text) }
    
    it 'strips locals' do
      expect {
        subject
      }.to change { text }.to('bar')
    end
    
    it 'parses the locals' do
      expect(subject).to eq('foo')
    end
  end
end
