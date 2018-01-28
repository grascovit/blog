[ ![Codeship Status for grascovit/blog](https://app.codeship.com/projects/bce2d560-e5c3-0135-175d-1ab5e756a092/status?branch=master)](https://app.codeship.com/projects/268972)
[![codecov](https://codecov.io/gh/grascovit/blog/branch/master/graph/badge.svg)](https://codecov.io/gh/grascovit/blog)

# Blog
Project created using Rails 5.1.4 (Ruby 2.4.2), PostgreSQL and RSpec.

#### Setup
To run the application, execute the following step:
```shell
bundle install
```

Then, run `bundle exec figaro install`, copy the content from `config/application.yml.example` file to `config/application.yml` and fill the required data.

After this, execute the following steps:
```shell
rails db:create
rails db:migrate
```
Finally, run the application:
```shell
rails s
```
