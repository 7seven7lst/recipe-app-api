FROM python:3.7-alpine
MAINTAINER Coding Ninja Satoshi Seven

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
# make directory /app on docker image
RUN mkdir /app
# default root folder
WORKDIR /app
COPY ./app /app

# create user for running the application, and switch to that user,
# instead of root
RUN  adduser -D user
USER user
