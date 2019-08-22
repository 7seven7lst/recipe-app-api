FROM python:3.7-alpine
MAINTAINER Coding Ninja Satoshi Seven

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps
# make directory /app on docker image
RUN mkdir /app
# default root folder
WORKDIR /app
COPY ./app /app

# create user for running the application, and switch to that user,
# instead of root
RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN adduser -D user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
USER user
