# OAuth 2 OmniAuth strategy for Redmine

Allows client applications to access Redmine resources. For now, you will need
to apply [this patch](https://www.redmine.org/issues/24808).

## Usage

Add the Gem to your Gemfile. Exact usage depends on your environment, here are
some examples:

### Rails, plain OmniAuth

In an initializer, do

~~~ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :redmine_oauth2,
    ENV['REDMINE_APP_ID'],
    ENV['REDMINE_APP_SECRET'],
    client_options: { site: 'https://redmine.yourcompany.com' },
    scope: 'view_issues'
end
~~~

### Rails, with Devise

~~~ruby
Devise.setup do |config|
  config.omniauth :redmine_oauth2,
    ENV['REDMINE_APP_ID'],
    ENV['REDMINE_APP_SECRET'],
    client_options: { site: 'https://redmine.yourcompany.com' },
    scope: 'view_issues'
end
~~~



## License

Copyright (c) 2020 by Jens Kraemer, Planio GmbH

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
