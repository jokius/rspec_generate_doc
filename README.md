Rspec generate doc
===

This gem help you to generate simple documentation api from Rspec tests.

Installation
============

Add this line to your application's Gemfile:

```ruby
gem 'rspec_generate_doc'
```

And then execute:

    $ bundle

Usage
=====

**Configure**
``` ruby
# spec/rails_helper.rb
...
require 'rspec_generate_doc'
..
RspecGenerateDoc.configure do |config|
  config.docs_dir = 'path/to/docs/dir' # default: "#{Rails.root}/docs"
  config.locale = :ru # default: I18n.default_locale
end
```

Example use

``` ruby
# spec/controllers/user_controller_spec.rb
...
let(:params) do
  {
    id: { description: 'user id', required: true },
    email: { description: 'user email', required: false }
  }
end
...
```
*keys description:*
id | email - parameter in result
description - description parameter. Default parent key name
required - is parameter required? Default false

**result**

After tests completed file *_user_controller.md* will be created in docs folder.  In format to Slate

Copyright
=========

Copyright (c) 2016 Igor Kutyavin aka Jokius

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
