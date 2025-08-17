# Sistema de Oficina Mecânica - Banco de Dados

## Estrutura do Projeto

O banco de dados foi modelado a partir do **Esquema Entidade-Relacionamento (EER)**, contemplando os seguintes elementos:

- **Cliente**: informações de clientes (nome, telefone, endereço).  
- **Veículo**: cada cliente pode ter um ou mais veículos cadastrados.  
- **Equipe**: grupo de mecânicos responsável por ordens de serviço.  
- **Mecânico**: cada mecânico pertence a uma equipe e possui uma especialidade.  
- **Ordem de Serviço (OS)**: documento que descreve os serviços e peças aplicados a um veículo.  
- **Serviço**: vinculado à tabela de mão de obra, armazena quantidade e valores aplicados.  
- **Tabela de Mão de Obra**: catálogo de serviços disponíveis com preços unitários.  
- **Peça**: catálogo de peças utilizadas na oficina.  
- **Peça_OS**: relação entre as peças utilizadas e uma ordem de serviço.  

## Tecnologias Utilizadas

- **MySQL** (criação do banco de dados e execução de queries)
- **Workbench** para modelagem e testes
- **GitHub** para versionamento e documentação

## Estrutura do Script

O arquivo contém:

1. **Criação do banco de dados e tabelas**  
   - Definição de chaves primárias e estrangeiras  
   - Respeito aos relacionamentos do modelo EER  

2. **Inserção de dados fictícios**  
   - Clientes, veículos, equipes, mecânicos, ordens de serviço, serviços e peças  

3. **Consultas SQL (queries)**  
   Exemplos que exploram:  
   - Recuperações simples (`SELECT`)  
   - Filtros (`WHERE`)  
   - Atributos derivados (cálculo do valor total da OS)  
   - Ordenações (`ORDER BY`)  
   - Agrupamentos com condições (`HAVING`)  
   - Junções entre tabelas (`JOIN`)  
