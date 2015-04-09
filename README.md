# Popularity

### Popularity searches social networks for urls and returns the metrics.

Current support includes: 

Network          |  Stats                           | Restriction
---------        | ------                           | ---------
Facebook         | `shares`, `comments`                                
Twitter          | `tweets`                               
Pinterest        | `pins`                               
GooglePlus       | `plusones`                                
Reddit           | `comments`, `score`
Reddit Comments  | `score`                          | only for reddit comment urls
Github           | `stars`                          | only for github repo urls     
Medium           | `recommends`                     | only for medium posts          
Soundcloud       | `plays`, `likes`, `comments`, `downloads` | only for soundcloud urls

```ruby

> search = Popularity.search("http://google.com")
> search.facebook.shares    #=> share count
> search.facebook.comments  #=> comment count
> search.twitter.tweets     #=> tweet count
> search.pinterests.pins    #=> pin count
> search.reddit.posts       #=> post count
> search.reddit.comments    #=> comment count across all posts
> search.reddit.score       #=> reddit score total across all posts
> search.total              #=> All of the above numbers added up

```

#### Combining multiple URLs 

Sometimes multiple URLs refer to the same thing. Maybe your URLs changed, but you don't want to lose out on counting those votes for the new location. Or you tweeted your blog address, but posted a link to soundcloud on reddit.

```ruby
> search = Popularity.search("http://jeffkeen.me/p/I-know-its-you/", "http://soundcloud.com/jeffkeen/i-know-its-you")
> search.facebook.shares    #=> share count across all urls
> search.facebook.comments  #=> comment count across all urls
> search.twitter.tweets     #=> tweet count across all urls
> search.pinterests.pins    #=> pin count across all urls
> search.reddit.posts       #=> post count across all urls
> search.reddit.comments    #=> comment count across all posts and urls
> search.reddit.score       #=> reddit score total across all posts and urls
> search.total              #=> All of the above numbers added up
```

JSON: 

```ruby
> search.to_json 
#=> spits out by network, by url, and total stats
```

##### Digging into the details

To see which results a url came back with: 
```ruby
search = Popularity.search("https://medium.com/@jeffkeen/call-me-sometime-64ed463c02f0")
search.sources #=> [:facebook, :reddit, :google_plus, :pinterest, :twitter, :medium]
```
```ruby
search.results #=> returns the individual network result classes, i.e. RedditPost, Medium, Soundcloud, Facebook
```

All of the searches done through Popularity.search are done asynchronously, but you don't need to worry about any of that because the method still blocks, so you can use it just like any other syncrhonous method.

To just query one network, interact with the class directly.

```ruby
p = Popularity::RedditComment.new("http://www.reddit.com/r/path/to/reddit/comment")
p.score #=> comment score
```


### Contributing to Popularity
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

### Copyright

Copyright (c) 2015 Jeff Keen. See LICENSE.txt for
further details.

