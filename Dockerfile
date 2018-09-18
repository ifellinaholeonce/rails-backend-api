FROM ruby:2.5.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /shopify-internship
WORKDIR /shopify-internship
COPY Gemfile /shopify-internship/Gemfile
COPY Gemfile.lock /shopify-internship/Gemfile.lock
RUN bundle install
COPY . /shopify-internship
ENV RAILS_ENV production
CMD ["bundle", "exec", "rails", "server", "-p", "8080", "-b", "0.0.0.0"]