# Heroku wildcards

> Charlie: You're not letting the wild card do his thing.  
> Dennis: Is there any reason behind what you're doing?  
> Charlie: Wild card.
>
> — *It's Always Sunny in Philadelphia*.

Run a command across multiple apps by including `*` in the app name.

    $ heroku ps --app=myapp-*
    # myapp-staging
    === web: `bundle exec rails server thin -p $PORT`
    web.1: up 2013/03/02 19:40:05 (~ 1h ago)

    # myapp-production
    === web: `bundle exec rails server thin -p $PORT`
    web.1: up 2013/03/02 11:53:30 (~ 9h ago)
    web.2: up 2013/03/02 11:56:05 (~ 9h ago)

You can also use commas for more precise specification:

    $ heroku maintenance:on -a thing1,thing2

Or match against the Git remote name:

    $ heroku config:set -r* BUILDPACK_URL=https://github.com/tpope/heroku-buildpack-ruby-tpope

Try it with the [Heroku binstubs](https://github.com/tpope/heroku-binstubs)
plugin:

    $ heroku binstubs:create 'myapp-*' --as each-env

## Installation

    heroku plugins:install https://github.com/tpope/heroku-wildcards.git

## Bonus feature

    $ heroku --app myapp run console
     !    `--app` is not a heroku command.
     !    Perhaps you meant `--help` or `apps`.
     !    See `heroku help` for a list of available commands.

Don't you just hate that?  Well, since I was already monkeying with the
dispatcher, I went ahead and fixed it.

## License

Copyright © Tim Pope.  MIT License.  See LICENSE for details.
