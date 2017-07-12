# Blog
Project created using Rails 5.1.2 (Ruby 2.3.4), PostgreSQL and RSpec for HE:labs recruitment process.

#### Setup
To run the application, execute the following step:
```shell
bundle install
```

Then, make a copy of the `application.yml.example` file located in the `config` folder and rename the new file to `application.yml` and insert your PostgreSQL data (no quotes needed):
```shell
DATABASE_NAME: blog-helabs
DATABASE_USERNAME: your-postgres-username
DATABASE_PASSWORD: your-postgres-password
```

After this, execute the following steps:
```shell
rake db:create
rake db:migrate
```
Finally, run the application:
```shell
rails s
```
