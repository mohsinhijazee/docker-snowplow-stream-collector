# See Github for documentation - https://github.com/snowplow/snowplow/blob/5af56388e1144c5af17e65182683593d38fceb9d/2-collectors/scala-stream-collector/src/main/resources/config.hocon.sample
collector {
  interface = "0.0.0.0"
  port = 80
  production = true

  p3p {
    policyref = "/w3c/p3p.xml"
    CP = "NOI DSP COR NID PSA OUR IND COM NAV STA"
  }

  cookie {
    expiration = 0
  }

  sink {
    enabled = "kinesis"

    kinesis {
      thread-pool-size: {{ KINESIS_THREAD_POOL_SIZE }} 
      aws {
        access-key: "{{ AWS_ACCESS_KEY }}"
        secret-key: "{{ AWS_SECRET_KEY }}"
      }

      stream {
        size: {{ KINESIS_STREAM_SIZE }}
        region: "{{ AWS_REGION }}"
        name: "{{ SNOWPLOW_STREAM_NAME }}"
      }

      backoffPolicy: {
        minBackoff: 3000 # 3 seconds
        maxBackoff: 600000 # 5 minutes
      }

      buffer: {
        byte-limit: 4000000 # 4MB
        record-limit: 500 # 500 records
        time-limit: 60000 # 1 minute
      }
    }
  }
}

akka {
  loglevel = {{ LOG_LEVEL }} 
  loggers = ["akka.event.slf4j.Slf4jLogger"]
}

spray.can.server {
  remote-address-header = on

  uri-parsing-mode = relaxed
  raw-request-uri-header = on

  parsing {
    max-uri-length = 32768
  }
}
