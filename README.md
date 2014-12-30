Small library for inlining rails partials in to bodies of text 

# Usage

### Create the partial
##### app/views/shared/_media.html.erb
```erb
<div class="media-image">
  <img src="<%= media_image %>">
  <%= content %>
</div>
```

### Register the component
#### components.rb
```ruby
Components.register(:media) do
  accepts_local :media_image
end
```

### Render the component
#### display_media.rb
```ruby
body = <<-BODY
{{#media}}
  {{media_image foo.jpg}}
  OMG
{{/media}}
BODY

Components::Renderer.new.render_html(body)
```
#### display_media.rb outputs:
```html
<div class="media-image">
  <img src="foo.jpg">
  OMG
</div>
```
