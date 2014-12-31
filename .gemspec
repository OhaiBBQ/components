Gem::Specification.new do |s|
  s.name        = 'components'
  s.version     = '0.0.0'
  s.date        = '2014-12-29'
  s.summary     = 'handlebars-esque rails template processor'
  s.authors     = ['Dan Hansen']
  s.email       = 'ohaibbq@gmail.com'
  s.homepage    = 'http://github.com/ohaibbq/components'
  s.license     = 'MIT'
  
  s.files       = %w(
    lib/components.rb 
    lib/components/component.rb 
    lib/components/context.rb 
    lib/components/local.rb
    lib/components/matcher.rb
    lib/components/view.rb
  )
  
  s.add_runtime_dependency 'rails', '>= 4'
end
