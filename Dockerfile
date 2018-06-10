FROM ruby:2.5.1-stretch

RUN  groupadd --gid 1000 ruby \
  && useradd --uid 1000 --gid ruby --shell /bin/bash --create-home ruby \
  # throw errors if Gemfile has been modified since Gemfile.lock
  && bundle config --global frozen 1 \
  && mkdir -p /usr/src/app \
  && chown -R ruby /usr/src/app

WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install --without development test

COPY . /usr/src/app
RUN  chown -R ruby .

USER ruby
EXPOSE 3000

ENTRYPOINT ["/usr/src/app/docker-entrypoint.sh"]
CMD ["rails", "server", "puma"]