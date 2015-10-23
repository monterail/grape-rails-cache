# HTTP and server side cache integration for Grape and Rails [![Gem Version](https://badge.fury.io/rb/grape-rails-cache.png)](http://badge.fury.io/rb/grape-rails-cache)

## Features

- HTTP Headers cache, ETag, Cache-Control, If-None-Match
- Server side cache for response body


## Installation

Add this line to your rails application's Gemfile:

```ruby
gem 'grape-rails-cache'
```

And then execute:

```bash
$ bundle
```

## Usage

```ruby
module MyApi < Grape::API
  format :json

  include Grape::Rails::Cache

  resources :posts do
    desc "Return a post"
    get ":id" do
      post = Post.find(params[:id])
      cache(key: "api:posts:#{post.id}", etag: post.updated_at, expires_in: 2.hours, if: -> { !params[:onair] }) do
        post # post.extend(PostRepresenter) etc, any code that renders response
      end
    end
  end
end
```

You can use blocks and symbols as values for `cache` params they will be evaluated in context of `Grape::Endpoint` (see [Uber gem](https://github.com/apotonick/uber#dynamic-options))

```ruby
cache(key: -> { "#{request.path}?#{declared_params.except(:client_d).to_json}" }
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
