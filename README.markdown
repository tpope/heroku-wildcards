# Heroku wildcards

Run a command across multiple apps by including `*` in the app name.

    $ heroku ps --app=myapp-*
    # myapp-staging
    === web: `bundle exec rails server thin -p $PORT`
    web.1: up 2013/03/02 19:40:05 (~ 1h ago)

    # myapp-production
    === web: `bundle exec rails server thin -p $PORT`
    web.1: up 2013/03/02 11:53:30 (~ 9h ago)
    web.2: up 2013/03/02 11:56:05 (~ 9h ago)

You can also match against the Git remote name:

    $ heroku info -r*

## Installation

    heroku plugins:install https://github.com/tpope/heroku-wildcards.git

## License

Copyright © Tim Pope.  MIT License.  See LICENSE for details.
