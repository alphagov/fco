#!/bin/bash -x

touch config/api_keys.yml

bundle install --path "${HOME}/bundles/${JOB_NAME}" --without darwin
bundle exec rake stats

# DELETE STATIC SYMLINKS AND RECONNECT...
for d in images javascripts templates stylesheets; do
  rm -f public/$d
  ln -s ../../../Static/workspace/public/$d public/
done

export DISPLAY=:99
bundle exec rake test
RESULT=$?
exit $RESULT
