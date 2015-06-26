# influxdb-latest

Image that builds InfluxDB from source.

Based on [tutumcloud/influxdb](https://github.com/tutumcloud/influxdb) and InfluxDB's [contributing guide](https://github.com/influxdb/influxdb/blob/master/CONTRIBUTING.md) guide. This README was adapted from tutumcloud/influxdb's.

Building the image
--------------------------

To create the image `alvaromorales/influxdb-latest`:

    docker build -t alvaromorales/influxdb-latest .

Running the image
--------------------------

Bind external ports `8083` and `8086` to the container.

    docker run -d -p 8083:8083 -p 8086:8086 alvaromorales/influxdb-latest

Configuring your InfluxDB
-------------------------
Access `localhost:8083` to configure InfluxDB. Enter the port to map to `8086`. The default credential is `root:root` -- please change it as soon as possible.

Alternatively, you can use REST API to talk to InfluxDB on port `8086`

Initially create Database
-------------------------
Use `-e PRE_CREATE_DB="db1;db2;db3"` to create databases named "db1", "db2", and "db3". Separate database names with `;`. For example:

```docker run -d -p 8083:8083 -p 8084:8084 -e PRE_CREATE_DB="db1;db2;db3" tutum/influxdb:latest```
