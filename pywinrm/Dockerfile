# Use an official Python image as the base
FROM python:3.10-slim

# Set the working directory
WORKDIR /app



# Install required packages
RUN pip install --no-cache-dir pywinrm

# If you have additional Python packages, you can specify them in requirements.txt
# Alternatively, you can install them directly in the RUN command
# RUN pip install --no-cache-dir -r requirements.txt

# Copy your application code (if any)
COPY . .

# Specify the command to run your application (if applicable)
# CMD ["python", "your_script.py"]
