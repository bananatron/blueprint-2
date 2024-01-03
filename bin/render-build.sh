#!/usr/bin/env bash
# exit on error
set -o errexit

# gem install ddtrace
bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
# npm install
# npm run build
echo 'Build complete!'

# Disable IRB autocompletion
echo "IRB.conf[:USE_AUTOCOMPLETE] = false" >> ~/.irbrc