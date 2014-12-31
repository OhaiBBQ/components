class Components::Component
  attr_reader :name, :locals, :template

  def initialize(name, options = {})
    @name = name
    @template = "shared/#{name}"
    @locals = options.fetch(:locals)
    @matcher = Components::Matcher.new(name)
  end

  def process(text, &block)
    @matcher.process(text) do |match|
      block.call(build_locals(match).merge({ content: match }))
    end
  end
  
  private
  
  def build_locals(match)
    locals.inject({}) do |memo, local|
      memo[local.name] = local.extract_match(match)
      
      memo
    end
  end

  def self.factory(attributes)
    locals = attributes.fetch(:locals, [])

    new(
      attributes.fetch(:name),
      locals: locals.map { |local| Components::Local.factory(local) } 
    )
  end
end

