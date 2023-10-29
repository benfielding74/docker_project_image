# Use an official Apache web server image
FROM httpd:2.4

# Install packages
RUN apt-get update && apt-get install -y default-jdk vim less python3 python3-pip python3.11-venv

# Expose ports for HTTP/HTTPS
EXPOSE 80/tcp

# Copy Python script
COPY server_info.py /app

# copy HTML to the root of workdir
COPY index.html /usr/local/apache2/htdocs/index.html

# Copy the Java program and compile it
WORKDIR /app
COPY HelloWorld.java /app
RUN javac /app/HelloWorld.java

# Upgrade pip in a virtual environment and install Flask
RUN python3 -m venv /venv
RUN /venv/bin/pip install --upgrade pip
RUN /venv/bin/pip install flask

# Command to run the web server & script
CMD /usr/local/apache2/bin/httpd -DFOREGROUND & /venv/bin/python /tmp/server_info.py