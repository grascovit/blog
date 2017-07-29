[ ![Codeship Status for rascovit/blog-helabs](https://app.codeship.com/projects/1ccb1a70-5690-0135-36a0-7646c47fdefc/status?branch=master)](https://app.codeship.com/projects/235915)
[![codecov](https://codecov.io/bb/rascovit/blog-helabs/branch/master/graph/badge.svg?token=JmhF6HEGQT)](https://codecov.io/bb/rascovit/blog-helabs)

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
AWS_ACCESS_KEY_ID: AKIAJMAVBU74SHBEIP2A
AWS_SECRET_ACCESS_KEY: HsDWL1d04tSdS6cTF6A9lftb+CbNfntnkw97NRL0
AWS_REGION: sa-east-1
S3_BUCKET_NAME: blog-helabs-production
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
