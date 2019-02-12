FROM ruby:2.5.3-alpine3.9

RUN bundle config --global frozen1

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 4567

CMD ["bundle", "exec", "ruby", "helloworld.rb", "-e", "production"]
