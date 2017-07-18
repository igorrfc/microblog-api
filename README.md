# Microblog API

Microblog API is a sample project to manage all the main resources of a blog. Such as users(and their authentication), posts, followers, followees, etc...



# Features:
You can check a list of features and resources on the API documentation [here](https://microblog-api-stg.herokuapp.com/docs).

### Dependencies

* Ruby 2.3.4
* Rails 5.0.1

### Instalation

```sh
$ cd microblog_api
$ bundle install
```

### Running

First, create your database.yml from scratch or use our sample:
```sh
$ cp config/database.yml.sample config/database.yml
```

Before run your app, you must to create and apply the app's migrations:
```sh
$ cd microblog_api
$ bundle install
```

Now, you can start the server:
```sh
$ rails s
```
