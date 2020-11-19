# README

* Prerequisites
Ruby version `2.6.3`. Steps to install Ruby can be found [here](https://www.ruby-lang.org/en/documentation/installation/)
Rails version `6.0.3.4`. Installation steps can be found [here](https://guides.rubyonrails.org/v5.0/getting_started.html)

* Setup and Use
After cloning down the project, cd into the project and run `bundle install`.
Run `rails s` to start the server.
Use your favorite API testing tool or navigate to your browser and use this endpoint `localhost:3000/pharmacy/<lat,lon>`.
`<lat,lon>` should be separated with a comma.
For `lat` and `lon` replace the `"."` with `%3B`. Ex. `39%3B0036,-94%3B4634`.
