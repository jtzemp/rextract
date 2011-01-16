# rextract

A web scraping framework using the [Dirt](https://github.com/mthorley/dirt) pattern.

The idea is that you

    gem install rextract
    rextract new-scraping-project

and it'll create a new scraping project for you and create a template of browsers and parsers so you can quickly create scraping projects

## Concepts

### Browsers

Browsers inherit from Rextract::Browser which is essentially Mechanize with some helpers. You use Mechanize's methods to get, post and do all the fancy browsing and create some methods to return the body content you want for given pages. Anything more complicated than a couple of xpaths or css selectors you should stick in a Parser.

### Parsers

Parsers inherit from Rextract::Parser. You define methods with the prefix 'parse_' and they will all get called automagically and their data will return as a hash of results. When you create a new Parser object, pass in the body content into the .new() method, then call #parse on the object.

## Contributing to rextract
 
* Contributions are super much appreciated!
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 JT Zemp.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
