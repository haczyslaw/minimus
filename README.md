== Minimus Alpha Version

It's small example how to make a simple microframework in Ruby.
I decide to include also a small blog engine, based on yml files & memcached.
It's not yet ready for production.

Quick start:

bundle install

Testing:

rake test

Start server like in another Rack based application:

thin start -p 3000 -R config.ru

Enjoy!
