FROM ubuntu

MAINTAINER Aksel Gresvig

RUN apt-get update && \
	apt-get -y install curl && \
    	curl -sL https://deb.nodesource.com/setup | sudo bash - && \
        apt-get -y install python build-essential nodejs


# Provides cached layer for node_modules
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /src && cp -a /tmp/node_modules /src/

# Define working directory
WORKDIR /src
ADD . /src

# Expose port
EXPOSE  8080

# Run app using nodemon
CMD ["node", "/src/run-monitor-server.js"]
CMD ["node", "/src/run-web-server.js"]
