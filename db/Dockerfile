# Use the official PostgreSQL image from the Docker Hub
FROM postgres:latest

# Copy initialization scripts if you have any, such as init.sql, to the Docker entry point directory
COPY init.sql /docker-entrypoint-initdb.d/

# Optionally, you can also copy custom configuration files
# COPY custom-postgresql.conf /etc/postgresql/postgresql.conf

# Ensure the permissions are correct for the copied files
RUN chmod -R 755 /docker-entrypoint-initdb.d/

# Set environment variables if necessary
# ENV POSTGRES_USER=your_user
# ENV POSTGRES_PASSWORD=your_password
# ENV POSTGRES_DB=your_db

# Expose the PostgreSQL port
EXPOSE 5432

# The default command is already set in the base image, so no need to redefine it