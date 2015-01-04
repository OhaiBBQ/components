module Components
  autoload :Context, 'components/context.rb'
  autoload :Component, 'components/component.rb'
  autoload :Local, 'components/local.rb'
  autoload :Matcher, 'components/matcher.rb'
  autoload :Patterns, 'components/patterns.rb'
  autoload :View, 'components/view.rb'

  def self.register(components)
    components = Array(components)
    
    components.each do |component|
      self.registered_components[component[:name]] = component
    end
  end

  def self.registered_components
    @registered_components ||= {}
  end
end
