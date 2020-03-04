FROM neo4j:3.5.15-enterprise

MAINTAINER Jose A Alvarado "jose.alvarado-guzman@neo4j.com"

LABEL name="Neo4j Graph Data Science" \
      version=1.0

ARG PASSWORD=DS_Training
ARG GDS=neo4j-graph-data-science-0.9.1-standalone.zip
ARG GDS_URL=https://s3-eu-west-1.amazonaws.com/com.neo4j.graphalgorithms.dist/graph-data-science/${GDS}
ARG APOC_URL=https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/3.5.0.9/apoc-3.5.0.9-all.jar

ENV NEO4J_ACCEPT_LICENSE_AGREEMENT=yes
ENV NEO4J_AUTH=neo4j/DS_Training
ENV NEO4JLABS_PLUGINS='["apoc"]'

RUN apt-get update \
    && apt-get install -y curl unzip \
    && cd plugins \
    && curl -O ${GDS_URL} \
    && unzip ${GDS} \
    && rm ${GDS} \
    && apt-get -y purge --auto-remove curl unzip \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*

COPY neo4j.conf conf/
