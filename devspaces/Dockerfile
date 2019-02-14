FROM couchdb:2

LABEL description="Devspaces implementation for medic app"

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && npm install -g grunt-cli && \
    npm install -g yarn@1.7.0 && \
    apt-get clean

COPY build_medic.sh /usr/bin/build_medic.sh
RUN chmod +x /usr/bin/build_medic.sh
ENV COUCHDB_USER admin
ENV COUCHDB_PASSWORD pass
ENV NODENAME 127.0.0.1
ENV COUCH_URL http://admin:pass@127.0.0.1:5984/medic
ENV COUCH_NODE_NAME couchdb@127.0.0.1
WORKDIR /data
EXPOSE 5988



