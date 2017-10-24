FROM ruby:2.4.2-onbuild
CMD bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
EXPOSE 3000