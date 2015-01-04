class Components::Component
  attr_reader :name, :registered_locals, :template

  def initialize(name, view, options = {})
    @name = name
    @view = view
    @template = "shared/#{name}"
    @registered_locals = options.fetch(:locals)
  end

  def render_instances(text)
    patterns.find_instances(text) do |instance|
      locals = build_locals(instance)

      @view.render(template, locals.merge({ content: instance.body }))
    end
  end
  
  private
  
  def build_locals(instance)
    registered_locals.inject({}) do |memo, local|
      memo[local.name] = local.extract_from(instance)
      
      memo
    end
  end

  def patterns
    @patterns ||= Components::Patterns.new(name)
  end

  def self.factory(attributes, view)
    locals = attributes.fetch(:locals, [])

    new(
      attributes.fetch(:name),
      view,
      locals: locals.map { |local| Components::Local.factory(local) } 
    )
  end
end

