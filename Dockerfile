FROM ruby:2.5.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /shopify-internship
WORKDIR /shopify-internship
COPY Gemfile /shopify-internship/Gemfile
COPY Gemfile.lock /shopify-internship/Gemfile.lock
RUN bundle install
COPY . /shopify-internship
CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]