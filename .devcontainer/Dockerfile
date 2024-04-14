# Use an official Python runtime as a parent image
FROM mcr.microsoft.com/devcontainers/python:3.10-bullseye

# Add metadata to the image to describe that the container is used for development
LABEL com.microsoft.created-by=vscode

# Add github.com to known hosts to avoid prompt
RUN mkdir -p ~/.ssh && chmod 700 ~/.ssh && touch ~/.ssh/known_hosts && chmod 600 ~/.ssh/known_hosts && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
