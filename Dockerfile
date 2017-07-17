FROM ubuntu:xenial
RUN apt-get update && apt-get install -y \
	sqlite3 \
	libdbd-sqlite3-perl \
	libplack-perl \
	libjson-perl
COPY . /webapp
CMD bash
