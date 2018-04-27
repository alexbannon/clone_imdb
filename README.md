# README

## ABOUT
This application responds to one route with data scraped from imdb. The format of the route is as follows:

/birthday/:month/:day?offset=

where :month is the month and :day is the day of the birthday of the actors/actresses you are looking up. The JSON responds with 50 actors and actresses and ?offset allows you to start 50+ names further in the list.

Alternatively, you can run a rake task `rake fetch_celebrities` that will take a very long time and scrape the entire imdb pages to fill in your db. Next task would probably be to put that into a cron job that runs once a week at night. I have no idea how long it takes, as I have no desire to hit imdb pages hundreds of thousands of times, but the good news is it speeds up remarkably after the first run since data is saved to postgres. Once all the data is saved, you can hit the db directly with the route '/db/birthday/:month/:day'


## SETUP
To set up the app, you will need to install

rails: http://guides.rubyonrails.org/getting_started.html
postgres: https://www.codementor.io/engineerapart/getting-started-with-postgresql-on-mac-osx-are8jcopb

then run gem install, rake db:setup, rake db:migrate. If you are feeling up to it, you can also run the rake task as mentioned above.
