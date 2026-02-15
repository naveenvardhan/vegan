# Stage 1: Builder
FROM ruby:3.1.2-slim as builder

# Install build dependencies
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
    git \
    && npm install -g yarn \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy Gemfiles
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle lock --add-platform x86_64-linux && \
    bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3

# Copy application code
COPY . .

# Install Node.js dependencies if package.json exists
RUN if [ -f package.json ]; then yarn install --production --frozen-lockfile; fi

# Precompile assets
RUN bundle exec rails assets:precompile

# Stage 2: Runtime
FROM ruby:3.1.2-slim

# Install only runtime dependencies
RUN apt-get update -qq && \
    apt-get install -y \
    libpq5 \
    nodejs \
    postgresql-client \
    imagemagick \
    libvips \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy gems from builder stage
COPY --from=builder /usr/local/bundle /usr/local/bundle

# Copy application code from builder stage
COPY --from=builder /app .

# Create directories for storage and tmp files
RUN mkdir -p tmp/pids tmp/sockets log storage public/assets && \
    chmod -R 755 tmp log storage public

# Expose port 3000
EXPOSE 3000

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:3000/ || exit 1

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
