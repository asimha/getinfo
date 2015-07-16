FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
ADD . /Documents/hackership/hackership-bdd
WORKDIR /Documents/hackership/hackership-bdd
ADD Gemfile /Documents/hackership/hackership-bdd/Gemfile
RUN bundle install
ADD . /Documents/hackership/hackership-bdd