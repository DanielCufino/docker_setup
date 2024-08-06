FROM jupyter/scipy-notebook:latest

USER root

# Set the working directory
WORKDIR /home/jovyan/work

# Copy requirements.txt and install dependencies
COPY requirements.txt /tmp/
RUN pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt

USER $NB_UID

# Copy the rest of the application code
COPY . .

# Default command to start Jupyter notebook
CMD ["start-notebook.sh", "--NotebookApp.token=''"]
