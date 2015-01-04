require_relative '../../helpers/spec_helper'

describe Components::Component do
  let(:component_name) { "section" }
  let(:mock_view) { MockView.new }
  let(:component) { Components::Component.new('section', mock_view, { locals: [Components::Local.new(:name)] }) }
  let(:matcher) { Components::Matcher.new(component_name) }

  subject { component.render_instances(component_text) }

  let(:component_text) { "{{#section name=\"foo\"}} my section {{/section}}"}

  it 'parses the body' do
    subject
    
    expect(mock_view.last_render_call[:locals][:content]).to include('my section')
  end

  context 'when the component has locals' do
    let(:component_text) { "{{#section name=\"foo\" type=\"bar\"}} my section {{/section}}"}

    it 'parses the locals' do
      subject
      
      expect(mock_view.last_render_call[:locals][:name]).to eq('foo')
    end
  end
end
