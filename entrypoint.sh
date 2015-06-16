#!/usr/bin/env bash
envtpl < /etc/snowplow/collector.conf.tpl > /etc/snowplow/collector.conf
/usr/bin/java -jar snowplow-stream-collector.jar --config /etc/snowplow/collector.conf > /var/log/snowplow-collector.log 2>&1
