FROM java:7-jre

MAINTAINER Daniel Zohar <daniel@memrise.com>

ENV SNOWPLOW_SOURCE_ZIP snowplow_kinesis_r67_bohemian_waxwing.zip
ENV JAR_FILE snowplow-stream-collector-0.5.0

RUN set -e && \
    apt-get update -y && \
    apt-get install -y make \
    build-essential \
    python-setuptools \
    python2.7-dev

RUN wget https://bintray.com/artifact/download/snowplow/snowplow-generic/${SNOWPLOW_SOURCE_ZIP} \
    && unzip ${SNOWPLOW_SOURCE_ZIP} \
    && rm ${SNOWPLOW_SOURCE_ZIP} \
    && mv ${JAR_FILE} keep_${JAR_FILE} \
    && rm -f snowplow* \
    && mv keep_${JAR_FILE} snowplow-stream-collector.jar \
    && mkdir /etc/snowplow/

RUN easy_install envtpl

COPY config/collector.conf.tpl /etc/snowplow/collector.conf.tpl

EXPOSE 80

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
