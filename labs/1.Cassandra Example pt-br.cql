
# Selecione a consulta e use ctrl+enter para enviar ao terminal

# abrir interface de consulta
cqlsh

# Descrevendo keyspaces (bancos de dados) 
DESC KEYSPACES;


DESC KEYSPACE system;

# criando keyspace
CREATE KEYSPACE test_matheus WITH REPLICATION = { 'class' : 'SimpleStrategy' , 'replication_factor' : 1 };

# usando keyspace
USE  test_matheus;

#criando primeira tabela 
CREATE TABLE store (
  id uuid,
  name text,
  cnpj text,
  category text,
  num_lojas int,
  PRIMARY KEY ((id), cnpj)  
);
# usando um uuid como rowkey/partition key. CNPJ não vai influenciar em como dados serão particionados, mas seráá utilizado para ordernar (clustering keys)
# WITH CLUSTERING ORDER BY (cnpj DESC) 
# mais sobre os tipos de dados: https://cassandra.apache.org/doc/latest/cql/types.html

# listando tabelas
DESCRIBE tables;

# inserindo dados na tabela store
INSERT INTO store  ( id,                                    name,                 cnpj,                 category, num_lojas)
            VALUES ( 6787b130-a769-1784-a657-0823456c9a66, 'Lojinha do Cicrano', '00.000.000/0001-00', 'cozinha',  3);

# consultando lojas
SELECT * FROM store;

# inserindo dados na tabela store
INSERT INTO store  ( id,                                   name,             cnpj,                category,            num_lojas)
            VALUES ( 95eaeac0-d1f2-11ea-87d0-0242ac130003, 'Magazine Mota', '00.000.000/0002-00', 'cama, mesa e banho', 145);

# consultando lojas
SELECT * FROM store;

# drop tabela
DROP table store;


#criando segunda tabela 
CREATE TABLE produto (
  id uuid,
  barcode text,
  name text,
  price float,
  category text,
  store_id text,
  PRIMARY KEY ((id), barcode)
  );

