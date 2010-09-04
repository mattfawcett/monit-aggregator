Monit Aggregator
================

Monit Aggregator is a Sinatra app that aggregates your monit web interfaces into 1 place. Used on runslikeclockwork.com server monitoring

1. Clone the repo `git clone git://github.com/mattfawcett/monit-aggregator.git`
2. Install the neccessary packages with `bundle install` (you will need bundler installed `gem install bundler`)
3. Edit the monit_installations.yml file to include the details of your Monit installations (it currently doesn't support HTTPS)
4. Now run the app `ruby app.rb`