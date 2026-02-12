# Use Ruby 3.1.2 as base image
FROM ruby:3.1.2-slim

# Install essential packages and dependencies
RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    npm \
    postgresql-client \
    imagemagick \
    libvips \
    curl \
    && npm install -g yarn \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle lock --add-platform x86_64-linux && \
    bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3

# Copy application code
COPY . .

# Install Node.js dependencies if package.json exists
RUN if [ -f package.json ]; then yarn install --production --frozen-lockfile; fi

# Skip asset precompilation during build - will be done on first run
# This avoids issues with cssbundling-rails dependency on yarn

# Create directories for storage and tmp files
RUN mkdir -p tmp/pids tmp/sockets log storage public/assets && \
    chmod -R 755 tmp log storage public

# Create non-root user (commented out for production to avoid permission issues)
# RUN groupadd -r app && useradd -r -g app app && \
#     chown -R app:app /app

# Switch to non-root user (commented out for production)
# USER app

# Expose port 3000
EXPOSE 3000

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:3000/ || exit 1

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
