
# Docker Setup for Data Processing and Jupyter Notebooks

This repository contains the Docker setup for running Luigi pipelines, PySpark, machine learning/deep learning code, and Jupyter notebooks, along with a PostgreSQL database.

## Services

- **dataenv**: The main data processing environment. Starts with a long-running process to act as an always-active shell.
- **jupyter**: Jupyter notebook server.
- **db**: PostgreSQL database.

## Usage

1. **Build and run the containers**:

   ```sh
   docker-compose up --build
   ```

2. **Access the dataenv container**:

   ```sh
   docker exec -it dataenv /bin/bash
   ```

3. **Access the Jupyter Notebook**:

   Navigate to [http://localhost:8888](http://localhost:8888) in your web browser. Use the token provided in the Jupyter logs.

4. **Set up the cron job to update containers at 3 AM daily**:

   a. Create the configuration file `config/project_path.conf` with the following content:

      ```sh
      PROJECT_PATH=/path/to/your-project
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

## Notes

- The `dataenv` container starts with a long-running process, allowing you to interact with it as an always-active shell.
- Ensure you have sufficient resources on your computer to run all the containers.
- Logs for the update script can be found in `logs/update_containers.log`.