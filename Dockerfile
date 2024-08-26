# Use an official Ubuntu as a parent image
FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Copy the application files
COPY wisecow.sh /app/wisecow.sh
RUN chmod +x /app/wisecow.sh

# Set the working directory
WORKDIR /app

# Define the command to run the application
CMD ["./wisecow.sh"]
