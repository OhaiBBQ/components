require_relative '../../../lib/components'

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
          {{#media}}
            {{media_image foobar}}
            wow
          {{/media}}
      EOF
    }

    class MockView
      def render(template, locals)
        <<-EOF
        #{locals[:content]}
        #{locals[:media_image]}
        EOF
      end
    end

    it 'works' do
      Components.register(registered_components)
      
      context = Components::Context.new(view: MockView.new)

      compiled = context.render_html(template)

      expect(compiled).to include("wow")
      expect(compiled).to include("foobar")
    end
  end
end 
