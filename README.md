# Grape Surrogate Cache

A gem for easily caching responses using the [Surrogate-Control cache header](https://www.w3.org/TR/edge-arch/) with [Grape](https://github.com/ruby-grape/grape) and [Rails](https://github.com/rails/rails).

Based on [Grape Rails Cache](https://github.com/monterail/grape-rails-cache).

## Installation

Add this line to your rails application's Gemfile:

```ruby
gem 'grape-rails-cache', github: "unsplash/grape-rails-cache"
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
      cache(key: "api:posts:#{post.id}", expires_in: 2.hours, stale_for: 24.hours) do
        post # post.extend(PostRepresenter) etc, any code that renders response
      end
    end
  end
end
```
