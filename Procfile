web: bundle exec rails server -p $PORT
worker: bundle exec rake jobs:work
worker: java -jar vendor/lib/cucumber-sandwich.jar -f tmp/tmp_report -o public/cucumber_reports