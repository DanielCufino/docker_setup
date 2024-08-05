FROM jupyter/scipy-notebook:latest

USER root

# Set the working directory
WORKDIR /home/jovyan/work

# Copy requirements.txt into the container
COPY requirements.txt /tmp/

# Install AWS CLI and additional Python packages
RUN pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt

USER $NB_UID

# Copy the rest of the application code
COPY . .

# Default command to start Jupyter notebook
CMD ["start-notebook.sh", "--NotebookApp.token=''"]