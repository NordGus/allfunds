FROM node:20.11 as node
FROM ruby:3.3

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin
COPY --from=node /opt /opt

RUN apt update -y && apt upgrade -y && apt install nano -y

WORKDIR /var/app

COPY . .

RUN bundle install

RUN cd frontend/server-api && npm install && cd ../allfunds && npm install && cd ../../

WORKDIR /var/app