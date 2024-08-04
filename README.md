# Docker Setup for Data Processing and Jupyter Notebooks

This repository contains the Docker setup for running Luigi pipelines, PySpark, machine learning/deep learning code, and Jupyter notebooks, along with a PostgreSQL database.

## Services

- **dataenv**: The main data processing environment.
- **jupyter**: Jupyter notebook server.
- **db**: PostgreSQL database.
- **airflow**: Apache Airflow for pipeline orchestration.

## Usage

1. **Build and run the containers**:

   ```sh
   docker-compose up --build
   ```

2. **Access the Jupyter Notebook**:

   Navigate to `http://<your-ec2-public-dns>:8888` in your web browser. Use the token provided in the Jupyter logs.

3. **Access Airflow**:

   Navigate to `http://<your-ec2-public-dns>:8080` in your web browser.

## Notes

- The `dataenv` container starts with a bash shell. You can manually start Jupyter notebooks or other commands as needed.
- Ensure you have sufficient resources on your EC2 instance to run all the containers.
