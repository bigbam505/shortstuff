# shortstuff [![Build Status](https://secure.travis-ci.org/drapergeek/shortstuff.png?branch=master)](http://travis-ci.org/drapergeek/shortstuff) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/drapergeek/shortstuff)
============================
shortstuff is a small rails app that acts as a URL shortener. It is designed for use inside a closed network where an admin can control the DNS server so you can make your own url service. It does not offer any authentication (this is by design) and URLs are never expired. There is a very simple JSON api for creating new URLs. I may release a CLI gem that interfaces with this via some kind of ENV configuration.


## Development Setup

Get the code.

    git clone git@github.com:drapergeek/shortstuff.git

Set up the project's dependencies.

    cd project
    bundle --binstubs

This will automatically add a heroku remote for staging.

Running tests:

    rspec spec


Use [Foreman](http://goo.gl/oy4uw) to run the app locally.

    foreman start

It uses your `.env` file and `Procfile` to run processes just like Heroku's
[Cedar](https://devcenter.heroku.com/articles/cedar/) stack.
