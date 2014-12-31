Small library for inlining rails partials in to bodies of text 

# Usage

### Create the partial
##### app/views/shared/_media.html.erb
```erb
<div class="media-image">
  <%= image_tag media_image %>
  <%= dynamic_context %>
  <%= content %>
</div>
```

### Register the component
#### components.rb
```ruby
Components.register([{
  name: :media,
  locals: [:media_image]
}])
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

Components::Context.new(assigns: { dynamic_context: 'foo' }).render_html(body)
```
#### display_media.rb outputs:
```html
<div class="media-image">
  <img src="foo.jpg">
  foo
  OMG
</div>
```
