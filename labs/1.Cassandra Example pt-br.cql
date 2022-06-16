-- Selecione a consulta e use ctrl+enter para enviar ao terminal

-- abrir interface de consulta
cqlsh

-- Documentação dos comandos administrativos https://docs.datastax.com/en/cql-oss/3.3/cql/cql_reference/cqlshCommandsTOC.html

-- Documentacão CQL: https://docs.datastax.com/en/cql-oss/3.3/cql/cql_reference/cqlCommandsTOC.html

-- Descrevendo keyspaces (bancos de dados) 
DESC KEYSPACES;

DESC KEYSPACE system;

-- criando keyspace
CREATE KEYSPACE stores WITH REPLICATION = { 'class' : 'SimpleStrategy' , 'replication_factor' : 3 };

-- Configurações do keyspace são inúmeras
-- Não fazer flush do memtable (memoria) to commit log (persistência não volátil).
-- Mais sobre DURABLE_WRITES https://www.oreilly.com/library/view/learning-apache-cassandra/9781787127296/1b85246c-2713-44ae-a9c2-7971f4915555.xhtml
CREATE KEYSPACE products WITH REPLICATION = { 'class' : 'SimpleStrategy' , 'replication_factor' : 3 } AND DURABLE_WRITES=false;


-- usando keyspace
USE  stores;


-- Create table KeyspaceName.TableName(
-- ColumnName DataType,
-- ColumnName DataType,
-- ColumnName DataType
-- ...
-- Primary key(ColumnName)
-- ) with PropertyName=PropertyValue;

-- criando primeira tabela 
-- Column family e table são a mesma coisa (!)
CREATE TABLE store (
  id uuid,
  name text,
  cnpj text,
  category text,
  num_lojas int,
  PRIMARY KEY ((id), cnpj)  
);
-- usando um uuid como rowkey/partition key. CNPJ não vai influenciar em como dados serão particionados, mas seráá utilizado para ordernar (clustering keys)
-- WITH CLUSTERING ORDER BY (cnpj DESC) 
-- mais sobre os tipos de dados: https://cassandra.apache.org/doc/latest/cql/types.html

-- listando tabelas
DESCRIBE tables;

-- inserindo dados na tabela store
INSERT INTO store  ( id,                                    name,                 cnpj,                 category, num_lojas)
            VALUES ( 6787b130-a769-1784-a657-0823456c9a66, 'Lojinha do Cicrano', '00.000.000/0001-00', 'cozinha',  3);

-- consultando lojas
SELECT * FROM store;

-- inserindo dados na tabela store
INSERT INTO store  ( id,                                   name,             cnpj,                category,            num_lojas)
            VALUES ( 95eaeac0-d1f2-11ea-87d0-0242ac130003, 'Magazine Mota', '00.000.000/0002-00', 'cama, mesa e banho', 145);

-- consultando lojas
SELECT * FROM store;

-- drop tabela
DROP table store;

USE  products;

--criando segunda tabela 
CREATE TABLE produto (
  id uuid,
  barcode text,
  name text,
  price float,
  category text,
  store_id text,
  PRIMARY KEY ((id), barcode, store_id)
  );


-- erro  falta clustering key
INSERT INTO produto  ( id,                                   barcode,             name,                category,            price)
            VALUES ( 95eaeac0-d1f2-11ea-87d0-0242ac130003, '23452342342342342', 'ACME Full HD 43"',  'tv', 145);

-- ok faltar um campo
INSERT INTO produto  ( id,                                   barcode,             name,                store_id,            price)
            VALUES ( 95eaeac0-d1f2-11ea-87d0-0242ac130003, '345634563456', 'carregador cel.',  '95eaeac0-d1f2-11ea-87d0-0242ac130003', 145);

SELECT * FROM produto;


-- ok faltar um campo
INSERT INTO produto  ( id,                                   barcode,             name,                store_id,            price)
            VALUES ( 95eaeac0-d1f2-11ea-87d0-0242ac130003, '96541651651650', 'bateria cel.',  '95eaeac0-d1f2-11ea-87d0-0242ac130003', 145);

-- ok faltar um campo
INSERT INTO produto  ( id,                                   barcode,             name,                store_id,            price)
            VALUES ( 95eaeac0-d1f2-11ea-87d0-0242ac130003, '7849465132654', 'carregador cel.',  '95eaeac0-d1f2-11ea-87d0-0242ac130003', 145);

--criando outras tabelas/familias
CREATE TABLE tv_specs (
  id uuid,
  peso_kg float,
  tam_tela float,
  PRIMARY KEY ((id), peso_kg, tam_tela)
  );

CREATE TABLE tv_funcoes (
  id uuid,
  webflix boolean,
  primo_video boolean,
  PRIMARY KEY ((id), peso_kg, tam_tela)
  );
