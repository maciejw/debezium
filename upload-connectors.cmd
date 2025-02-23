@REM curl.exe -X PUT http://localhost:8083/connectors/jdbc-sink-connector-Target1/stop
@REM curl.exe -X DELETE http://localhost:8083/connectors/jdbc-sink-connector-Target1/offsets
@REM curl.exe -X PUT http://localhost:8083/connectors/jdbc-sink-connector-Target1/restart

@REM curl.exe -X PUT http://localhost:8083/connectors/jdbc-sink-connector-Target2/stop
@REM curl.exe -X DELETE http://localhost:8083/connectors/jdbc-sink-connector-Target2/offsets
@REM curl.exe -X PUT http://localhost:8083/connectors/jdbc-sink-connector-Target2/restart


curl.exe -X DELETE http://localhost:8083/connectors/mssql-source-connector
curl.exe -X POST -H "Content-Type: application/json" --data @Connectors\mssql-source.json http://localhost:8083/connectors

curl.exe -X DELETE http://localhost:8083/connectors/jdbc-sink-connector-Target1
curl.exe -X POST -H "Content-Type: application/json" --data @Connectors\jdbc-sink-Target1.json http://localhost:8083/connectors

curl.exe -X DELETE http://localhost:8083/connectors/jdbc-sink-connector-Target2
curl.exe -X POST -H "Content-Type: application/json" --data @Connectors\jdbc-sink-Target2.json http://localhost:8083/connectors
