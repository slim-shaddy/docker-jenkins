# Official Jenkins LTS image with Java 17
FROM jenkins/jenkins:lts-jdk17

# Switch to root to install tools
USER root

# Install required utilities + Docker CLI
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    git \
    docker.io \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Allow Jenkins to access Docker
RUN usermod -aG docker jenkins

# Jenkins home directory
ENV JENKINS_HOME=/var/jenkins_home

# Declare persistent volume (IMPORTANT)
VOLUME ["/var/jenkins_home"]

# Fix ownership
RUN chown -R jenkins:jenkins /var/jenkins_home

# Switch back to Jenkins user
USER jenkins

# Expose Jenkins ports
EXPOSE 8080 50000
