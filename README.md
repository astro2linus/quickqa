QuickQA
=======

Prerequisites
-------------
- Please install RVM first and then install ruby 2.0.0

	`user$ \curl -sSL https://get.rvm.io | bash -s stable`

	`rvm install 2.0.0`
- gem install bundler

	`gem install bundler`

- Install Postgres
	
	Visit http://postgresapp.com/ and follow the instructions

Get the project from Stash
------------------------------

	git clone https://<your username>@stash.englishtown.com/scm/test/mobile.git
	

Install QuickQA
---------------
- Install gems

	`bundle install`

- Setup database

	`cp config/database.example.yml config/database.yml` 
	then update it with your database information

	`bundle exec rake db:setup`

- Start QuickQA

	`foreman start`

