require_relative '../../helpers/spec_helper'

describe Components::Context do
  describe '#render_html' do
    let(:registered_components) { 
      [{
        name: :media,
        locals: [
          {name: :media_image}
        ]
      }] 
    }

    let(:template) {
      <<-EOF
          {{#media foo="bar"}}
            {{media_image foobar}}
            wow
          {{/media}}
      EOF
    }


    it 'works' do
      Components.register(registered_components)
      
      mock_view = MockView.new
      context = Components::Context.new(view: mock_view)

      context.render_html(template)
      
      expect(mock_view.last_render_call[:locals][:media_image]).to eq("foobar")
      expect(mock_view.last_render_call[:locals][:content]).to include("wow")
    end
  end
end 
