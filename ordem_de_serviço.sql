CREATE DATABASE Ordem_servico;

CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    Telefone VARCHAR(45),
    Endereco VARCHAR(100)
);

CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    Placa VARCHAR(10) UNIQUE NOT NULL,
    Modelo VARCHAR(45),
    Ano INT,
    Marca VARCHAR(45),
    Cliente_idCliente INT,
    constraint fk_cliente_idcliente FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Equipe (
    idEquipe INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL
);

CREATE TABLE Mecanico (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    Endereco VARCHAR(100),
    Especialidade VARCHAR(45),
    Equipe_idEquipe INT,
    constraint fk_equipe_idequipe FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe(idEquipe)
);

CREATE TABLE Ordem_de_Servico (
    idOrdem INT AUTO_INCREMENT PRIMARY KEY,
    Data_Emissao DATE,
    Data_Conclusao DATE,
    Status VARCHAR(45),
    Valor_Total DECIMAL(10,2),
    Equipe_idEquipe INT,
    Veiculo_idVeiculo INT,
    constraint fk_equipe_id FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe(idEquipe),
    constraint fk_veiculo_idveiculo FOREIGN KEY (Veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo)
);

CREATE TABLE Tabela_Mao_de_Obra (
    idTabela INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(100),
    Preco_Unitario DECIMAL(10,2)
);

CREATE TABLE Servico (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    Quantidade INT,
    Total DECIMAL(10,2),
    Ordem_idOrdem INT,
    Tabela_idTabela INT,
    constraint fk_ordem_idservico FOREIGN KEY (Ordem_idOrdem) REFERENCES Ordem_de_Servico(idOrdem),
    constraint fk_tabela_mobra FOREIGN KEY (Tabela_idTabela) REFERENCES Tabela_Mao_de_Obra(idTabela)
);

CREATE TABLE Peca (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45),
    Preco_Unitario DECIMAL(10,2)
);

CREATE TABLE Peca_OS (
    idPecaOS INT AUTO_INCREMENT PRIMARY KEY,
    Quantidade INT,
    Total DECIMAL(10,2),
    Peca_idPeca INT,
    Ordem_idOrdem INT,
    constraint fk_peca_idpeca FOREIGN KEY (Peca_idPeca) REFERENCES Peca(idPeca),
    constraint fk_ordem_idordem FOREIGN KEY (Ordem_idOrdem) REFERENCES Ordem_de_Servico(idOrdem)
);


-- Adição de dados

INSERT INTO Cliente (Nome, Telefone, Endereco) VALUES
		('João Silva', '21999999999', 'Rua A, 123'),
		('Maria Souza', '21988888888', 'Rua B, 456'),
		('Carlos Pereira', '21977777777', 'Rua C, 789');

INSERT INTO Veiculo (Placa, Modelo, Ano, Marca, Cliente_idCliente) VALUES
		('ABC1234', 'Civic', 2020, 'Honda', 1),
		('XYZ9876', 'Corolla', 2019, 'Toyota', 2),
		('DEF5678', 'Onix', 2021, 'Chevrolet', 3);

INSERT INTO Equipe (Nome) VALUES
		('Equipe A'),
		('Equipe B');

INSERT INTO Mecanico (Nome, Endereco, Especialidade, Equipe_idEquipe) VALUES
		('Lucas Rodrigues', 'Rua Cravos, 111', 'Motor', 1),
		('Maria das Graças Silva', 'Avenida Ayrton Senna, 222', 'Freios', 1),
		('Thamyres Motta', 'Rua São João, 333', 'Suspensão', 2);

INSERT INTO Ordem_de_Servico (Data_Emissao, Data_Conclusao, Status, Valor_Total, Equipe_idEquipe, Veiculo_idVeiculo) VALUES
		('2025-08-01', '2025-08-05', 'Concluída', 1500.00, 1, 1),
		('2025-08-02', NULL, 'Em andamento', 0.00, 2, 2);

INSERT INTO Tabela_Mao_de_Obra (Descricao, Preco_Unitario) VALUES
		('Troca de óleo', 150.00),
		('Revisão de freios', 300.00),
		('Alinhamento', 200.00);

INSERT INTO Servico (Quantidade, Total, Ordem_idOrdem, Tabela_idTabela) VALUES
		(1, 150.00, 1, 1),
		(1, 300.00, 1, 2),
		(1, 200.00, 2, 3);

INSERT INTO Peca (Nome, Preco_Unitario) VALUES
		('Filtro de óleo', 50.00),
		('Pastilha de freio', 200.00);

INSERT INTO Peca_OS (Quantidade, Total, Peca_idPeca, Ordem_idOrdem) VALUES
		(1, 50.00, 1, 1),
		(2, 400.00, 2, 1);

-- Queries

SELECT Nome, Telefone FROM Cliente;

SELECT * FROM Veiculo WHERE Marca = 'Honda';

SELECT o.idOrdem, 
       SUM(s.Total) + SUM(p.Total) AS Valor_Final
FROM Ordem_de_Servico o
LEFT JOIN Servico s ON o.idOrdem = s.Ordem_idOrdem
LEFT JOIN Peca_OS p ON o.idOrdem = p.Ordem_idOrdem
GROUP BY o.idOrdem;

SELECT * FROM Ordem_de_Servico ORDER BY Data_Emissao DESC;

SELECT o.idOrdem, SUM(s.Total + IFNULL(p.Total,0)) AS Valor_Total
FROM Ordem_de_Servico o
LEFT JOIN Servico s ON o.idOrdem = s.Ordem_idOrdem
LEFT JOIN Peca_OS p ON o.idOrdem = p.Ordem_idOrdem
GROUP BY o.idOrdem
HAVING Valor_Total > 1000;

SELECT c.Nome AS Cliente, v.Placa, o.Status, o.Valor_Total
FROM Ordem_de_Servico o
JOIN Veiculo v ON o.Veiculo_idVeiculo = v.idVeiculo
JOIN Cliente c ON v.Cliente_idCliente = c.idCliente;

SELECT e.Nome AS Equipe, m.Nome AS Mecanico, o.idOrdem, o.Status
FROM Ordem_de_Servico o
JOIN Equipe e ON o.Equipe_idEquipe = e.idEquipe
JOIN Mecanico m ON e.idEquipe = m.Equipe_idEquipe
WHERE o.Status = 'Concluída';
