# Use the official Ruby image with the specified version
FROM ruby:3.1.2

# Set environment variables
ENV LANG C.UTF-8
ENV RAILS_ENV production

# Install essential packages
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs

# Create and set the working directory
WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock /app/
RUN gem install bundler:2.3.7
RUN bundle config set deployment 'true' && \
    bundle config set without 'development test'
RUN bundle install

# Copy the rest of the application code
COPY . /app

# Expose port 3000
EXPOSE 3000

# Start the Rails application
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
