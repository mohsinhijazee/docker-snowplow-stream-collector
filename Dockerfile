FROM java:7-jre

MAINTAINER Daniel Zohar <daniel@memrise.com

ENV SNOWPLOW_SOURCE_ZIP snowplow_kinesis_r65_scarlet_rosefinch.zip
ENV JAR_FILE snowplow-stream-collector-0.4.0

RUN wget https://bintray.com/artifact/download/snowplow/snowplow-generic/${SNOWPLOW_SOURCE_ZIP} \
    && unzip ${SNOWPLOW_SOURCE_ZIP} \
    && rm ${SNOWPLOW_SOURCE_ZIP} \
    && mv ${JAR_FILE} keep_${JAR_FILE} \
    && rm -f snowplow* \
    && mv keep_${JAR_FILE} snowplow-stream-collector.jar \
    && mkdir /etc/snowplow/

COPY config/collector.conf /etc/snowplow/collector.conf

EXPOSE 80

ENTRYPOINT ["/usr/bin/java", "-jar", "snowplow-stream-collector.jar", "--config", "/etc/snowplow/collector.conf"]
