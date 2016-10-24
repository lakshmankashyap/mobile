FROM node

WORKDIR /usr/src/app
ADD https://github.com/twhtanghk/mobile/archive/master.tar.gz /tmp
RUN tar --strip-components=1 -xzf /tmp/master.tar.gz && \
	rm /tmp/master.tar.gz && \
	apt-get update && \
	apt-get clean && \
	npm install
EXPOSE 1337
CMD node app.js --prod
