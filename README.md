Small library for rendering rails partials in to bodies of text 

# Usage

### Create the component templates
##### app/views/shared/_media.html.erb
```erb
<div class="media-image">
  <%= image_tag media_image, data: { align: media_align } %>
  <%= content %>
</div>
```

##### app/views/shared/_post_header.html.erb
```erb
<h1><%= post.title %></h1>
```

### Register the component
#### components.rb
```ruby
Components.register([{
  name: :media,
  locals: [
    {name: :media_image},
    {name: :media_align, default: 'right'}
  ]
},
{
  name: :post_header
}])
```

### Render the component
#### display_media.rb
Instances of component start and end tags will be rendered in to their respective position. Any content inside the tag is yielded as a `content` local to the partial.

```ruby
body = <<-BODY
{{#post_header}} {{/post_header}}
{{#media media_image="foo.jpg"}}
  OMG
{{/media}}
BODY

puts Components::Context.new(assigns: { post: Post.find(1) }).render_html(body)
```
#### display_media.rb outputs:
```html
<h1>This was a post title</h1>
<div class="media-image">
  <img src="foo.jpg" data-align="right">
  foo
  OMG
</div>
```
