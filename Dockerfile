# Base image
FROM ubuntu:20.04

# Set environment variable to non-interactive mode to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages and dependencies for ttyd
RUN apt-get update && apt-get install -y \
    bash \
    build-essential \
    cmake \
    git \
    libjson-c-dev \
    libwebsockets-dev \
    apache2-utils \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Clone and build ttyd from source
RUN git clone https://github.com/tsl0922/ttyd.git /tmp/ttyd \
    && cd /tmp/ttyd \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install \
    && rm -rf /tmp/ttyd

# Create app directory
WORKDIR /app

# Copy script and assets
COPY shift_sched.sh /app/shift_sched.sh

# Make script executable
RUN chmod +x /app/shift_sched.sh

# Expose port for ttyd
EXPOSE 8080

# Run the script using ttyd
CMD ["ttyd", "--writable", "-p", "8080", "bash", "./shift_sched.sh"]

