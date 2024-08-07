```markdown
# Docker Setup for Data Processing and Jupyter Notebooks

This repository contains the Docker setup for running Luigi pipelines, PySpark, machine learning/deep learning code, and Jupyter notebooks, along with a PostgreSQL database.

## Services

- **dataenv**: The main data processing environment. Starts with a long-running process to act as an always-active shell.
- **jupyter**: Jupyter notebook server.
- **db**: PostgreSQL database.

## Usage

1. **Set up environment variables**:

   Create a `.env` file in the root of your project with the following content:

   ```env
   POSTGRES_USER=your_postgres_user
   POSTGRES_PASSWORD=your_postgres_password
   POSTGRES_DB=your_database_name
   DD_API_KEY=your_datadog_api_key
   DD_SITE=datadoghq.com
   ```

2. **Create GitHub Secrets**:

   Ensure the following secrets are created in your GitHub repository:

   - `DOCKER_USERNAME`
   - `DOCKER_PASSWORD`

3. **Set up the self-hosted runner (optional)**:

   Follow the [GitHub documentation](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners) to set up a self-hosted runner.

   If you prefer to use GitHub-hosted runners, make the following changes to your workflow YAML:

   ```yaml
   jobs:
     setup:
       runs-on: ubuntu-latest
       ...
     build_dataenv:
       runs-on: ubuntu-latest
       ...
     build_jupyter:
       runs-on: ubuntu-latest
       ...
     build_db:
       runs-on: ubuntu-latest
       ...
   ```

4. **Build and run the containers**:

   ```sh
   docker-compose up --build
   ```

5. **Access the dataenv container**:

   ```sh
   docker exec -it dataenv /bin/bash
   ```

6. **Access the Jupyter Notebook**:

   Navigate to [http://localhost:8888](http://localhost:8888) in your web browser. Use the token provided in the Jupyter logs.

7. **Set up the cron job to update containers hourly**:

   a. Create the configuration file `config/project_path.conf` with the following content:

      ```sh
      PROJECT_PATH=/Users/danielcufino/Desktop/projects/docker_setup
      IMAGES_LIST=dockerhub_username/dataenv:latest,dockerhub_username/jupyter:latest,dockerhub_username/db:latest
      ```

   b. Run the setup script to install the cron job:

      ```sh
      ./scripts/setup_cron.sh
      ```

   c. For macOS users, you might need to manually restart the cron service:

      ```sh
      sudo launchctl unload /System/Library/LaunchDaemons/com.apple.periodic-daily.plist
      sudo launchctl load /System/Library/LaunchDaemons/com.apple.periodic-daily.plist
      ```

   The cron job will run every hour to update the containers.

## Database Setup

- The database is initialized with the schema defined in `db/init.sql`.
- The data is persisted using the `postgres_data` volume, ensuring it remains intact across container restarts and rebuilds.

## Monitoring

- Logs for the update script can be found in `logs/update_containers.log`.
- Logs for the cron job execution can be found in `logs/cron.log`.

## Notes

- The `dataenv` container starts with a long-running process, allowing you to interact with it as an always-active shell.
- Ensure you have sufficient resources on your computer to run all the containers.
- Ensure the `.env` file contains your Datadog API key and site information for monitoring.
```