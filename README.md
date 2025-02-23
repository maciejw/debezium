# Debezium tests

## Prerequisites

Download [jmx exporter](https://github.com/prometheus/jmx_exporter/releases/download/1.1.0/jmx_prometheus_javaagent-1.1.0.jar) to `./jmx_prometheus_javaagent-1.1.0.jar`
Create `./sql-credential.properties`

```properties
Source.username=...
Source.password=...
Target1.username=...
Target1.password=...
Target2.username=...
Target2.password=...
```

Run MS Sql Server and expose it as `host.docker.internal:1433` or change connection properties in `./Connectors`

Setup databases

```sql
use [Source]

exec [sp_cdc_enable_db]


CREATE TABLE [dbo].[Table_1](
	[Id] [int] NOT NULL,
	[Column1] [nvarchar](50) NULL,
	[Column2] [datetime] NULL,
    CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED
    (
        [Id] ASC
    ) ON [PRIMARY]
) ON [PRIMARY]

exec [sp_cdc_enable_table] @source_schema = 'dbo', @source_name = 'Table_1', @role_name = null

use [Target1]


CREATE TABLE [dbo].[Table_1](
	[Id] [int] NOT NULL,
	[Column1] [nvarchar](50) NULL,
	[Column2] [datetime] NULL,
    CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED
    (
        [Id] ASC
    ) ON [PRIMARY]
) ON [PRIMARY]


use [Target2]


CREATE TABLE [dbo].[Table_1](
	[Id] [int] NOT NULL,
	[Column1] [nvarchar](50) NULL,
	[Column2] [datetime] NULL,
    CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED
    (
        [Id] ASC
    ) ON [PRIMARY]
) ON [PRIMARY]


use [Source]


insert into [dbo].[Table_1] values
(1, 'www', GETDATE())
,(2, 'www', GETDATE())
,(3, 'www', GETDATE())
,(4, 'www', GETDATE())


update [dbo].[Table_1] set [Column1] = 'xxx' where [Id] in (1, 2)

delete from [dbo].[Table_1] where [Id] = 2
delete from [dbo].[Table_1] where [Id] = 4

```

## Running

Start the services

```shell
docker compose --profile monitoring up -d
```

After starting the services, you can upload connectors

```cmd
./upload-connectors.cmd
```

## Monitoring

Prometheus: [http://localhost:9090](http://localhost:9090)

Debezium connector status [http://localhost:8083/connectors/?expand=info&expand=status](http://localhost:8083/connectors/?expand=info&expand=status)

## Troubleshooting

```shell
docker run --rm -it --network debeziumnet nicolaka/netshoot
```
