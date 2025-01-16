ARG TAG=v0.51.x
FROM metabase/metabase:$TAG

ARG DRIVER_VERSION=1.51.0
ADD https://github.com/enqueue/metabase-clickhouse-driver/releases/download/$DRIVER_VERSION/clickhouse.metabase-driver.jar /plugins/
RUN chmod 744 /plugins/clickhouse.metabase-driver.jar
