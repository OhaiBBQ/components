require_relative '../../helpers/spec_helper'

describe Components::Local do
  let(:local) { Components::Local.new('section') }
  
  describe '#extract_from' do
    let(:instance) { OpenStruct.new(body: '{{section foo}}bar', inline_locals: '') }

    subject { local.extract_from(instance) }
    
    it 'strips locals' do
      expect {
        subject
      }.to change { instance.body }.to('bar')
    end
    
    it 'parses the locals' do
      expect(subject).to eq('foo')
    end
    
    context 'with inline locals' do
      let(:instance) {  OpenStruct.new(body: '', inline_locals: 'section="foo" title="bar"') }

      it 'strips relevant locals & ignores irrelevant locals' do
        expect {
          subject
        }.to change { instance.inline_locals }.to('title="bar"')
      end

      it 'parses the value' do
        expect(subject).to eq('foo')
      end
    end
  end
end
