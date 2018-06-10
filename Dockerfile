FROM ruby:2.5.1-slim-stretch

RUN  apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
     build-essential \
     libpq-dev \
  && groupadd --gid 1000 ruby \
  && useradd --uid 1000 --gid ruby --shell /bin/bash --create-home ruby \
  && echo "ruby ALL=NOPASSWD: ALL" >> /etc/sudoers \
  # throw errors if Gemfile has been modified since Gemfile.lock
  && bundle config --global frozen 1 \
  && bundle config --global path vendor/bundle \
  && mkdir -p /usr/src/app \
  && chown -R ruby /usr/src/app \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install --deployment --without development test \
  && apt-get purge -y --auto-remove build-essential

COPY . /usr/src/app
RUN  chown -R ruby .

USER ruby
EXPOSE 3000

COPY docker-entrypoint.sh /usr/local/bin
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["rails", "server", "puma"]