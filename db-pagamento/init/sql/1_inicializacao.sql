/* Criando Base */

-- Criar o database, se não existir
CREATE DATABASE IF NOT EXISTS fiap;

USE fiap;

CREATE USER 'user_fiap'@'%' IDENTIFIED BY 'pass_fiap';
GRANT SELECT, INSERT, UPDATE, DELETE ON fiap.* TO 'user_fiap'@'%';
FLUSH PRIVILEGES;

-- Tabela Cliente
CREATE TABLE Cliente (
    cpf CHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    ativo TINYINT(1) DEFAULT 1
);

-- Tabela Status
CREATE TABLE Status (
    id_status INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(200)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    cpf CHAR(11),
    id_status_atual INT,
    valor_total DECIMAL(10,2),
    data_pedido DATE,
	qrcode LONGTEXT,
    FOREIGN KEY (cpf) REFERENCES Cliente(cpf),
    FOREIGN KEY (id_status_atual) REFERENCES Status(id_status)
);

-- Tabela Preparo
CREATE TABLE Preparo (
    id_preparo INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_status INT NOT NULL,
    data_status DATETIME NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_status) REFERENCES Status(id_status)
);

-- Tabela Categoria
CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- Tabela Produto
CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL,
    descricao VARCHAR(200),
    preco DECIMAL(10,2) NOT NULL,
    imagens VARCHAR(500),
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

-- Tabela Pedido_Produto
CREATE TABLE Pedido_Produto (
    id_pedido_produto INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT,
    observacao VARCHAR(200),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

-- Tabela Ingrediente
CREATE TABLE Ingrediente (
    id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(200),
    unidade_medida VARCHAR(20) NOT NULL,
    preco_unitario DECIMAL(10,2),
    quantidade_em_estoque DECIMAL(10,2),
    estoque_minimo DECIMAL(10,2)
);

-- Tabela Produto_Ingrediente
CREATE TABLE Produto_Ingrediente (
    id_produto_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    id_ingrediente INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente(id_ingrediente),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

-- Tabela Forma_pagamento
CREATE TABLE Forma_pagamento (
    id_forma_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(200),
    ativo TINYINT(1) DEFAULT 1
);

-- Tabela Status_Pagamento
CREATE TABLE Status_Pagamento (
    id_status_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    data_pagamento DATETIME,
    id_forma_pagamento INT,
    valor_pago DECIMAL(10,2),
    id_status_pagamento INT,
    tentativa INT,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_forma_pagamento) REFERENCES Forma_pagamento(id_forma_pagamento),
    FOREIGN KEY (id_status_pagamento) REFERENCES Status_Pagamento(id_status_pagamento)
);

/* Inserindo os dados iniciais */

-- Inserts Categoria
INSERT INTO Categoria (nome) VALUES
('Lanche'),
('Acompanhamento'),
('Bebida'),
('Sobremesa');


INSERT INTO Ingrediente (nome, descricao, unidade_medida, preco_unitario, quantidade_em_estoque, estoque_minimo) VALUES
('Pão de hambúrguer', 'Pão tipo brioche', 'un', 1.00, 100, 10),
('Carne bovina', 'Hambúrguer artesanal 150g', 'un', 5.00, 50, 10),
('Queijo cheddar', 'Fatia de queijo cheddar', 'un', 0.80, 200, 20),
('Alface', 'Folhas frescas', 'g', 0.01, 1000, 100),
('Tomate', 'Fatias de tomate fresco', 'g', 0.02, 800, 100),
('Bacon', 'Tiras crocantes', 'un', 1.50, 100, 10),
('Batata frita', 'Palito fina', 'g', 0.02, 2000, 200),
('Refrigerante', 'Lata 350ml', 'un', 3.00, 100, 10),
('Sorvete', 'Bola de sorvete', 'un', 2.00, 50, 10),
('Chocolate', 'Cobertura de chocolate', 'g', 0.03, 500, 50);


INSERT INTO Produto (nome, id_categoria, descricao, preco, imagens) VALUES
('X-Burguer', 1, 'Hambúrguer com queijo', 12.00, ''),
('X-Salada', 1, 'Hambúrguer com salada', 13.00, ''),
('X-Bacon', 1, 'Hambúrguer com bacon', 14.00, ''),
('X-Tudo', 1, 'Hambúrguer completo', 16.00, ''),
('Cheddar Melt', 1, 'Hambúrguer com cheddar derretido', 15.00, ''),
('Duplo Burguer', 1, 'Dois hambúrgueres com queijo', 18.00, ''),
('Chicken Burguer', 1, 'Sanduíche de frango', 13.00, ''),
('Veggie Burguer', 1, 'Hambúrguer vegetariano', 12.00, ''),
('Smash Burguer', 1, 'Hambúrguer prensado', 14.00, ''),
('Burguer Especial', 1, 'Hambúrguer da casa', 17.00, '');


INSERT INTO Produto (nome, id_categoria, descricao, preco, imagens) VALUES
('Batata frita', 2, 'Porção individual', 7.00, ''),
('Onion Rings', 2, 'Anéis de cebola empanados', 8.00, ''),
('Nuggets', 2, 'Porção de frango empanado', 9.00, ''),
('Cheddar Fries', 2, 'Batata frita com cheddar', 10.00, ''),
('Batata Rústica', 2, 'Batata com casca e ervas', 9.00, ''),
('Batata Recheada', 2, 'Batata com queijo e bacon', 11.00, ''),
('Mandioca Frita', 2, 'Porção crocante', 8.00, ''),
('Mini Coxinha', 2, 'Porção de coxinhas', 10.00, ''),
('Kibe', 2, 'Porção de mini kibes', 9.00, ''),
('Pastelzinho', 2, 'Porção variada de pastéis', 10.00, '');


INSERT INTO Produto (nome, id_categoria, descricao, preco, imagens) VALUES
('Coca-Cola', 3, 'Lata 350ml', 5.00, ''),
('Guaraná', 3, 'Lata 350ml', 5.00, ''),
('Suco de Laranja', 3, 'Natural 300ml', 6.00, ''),
('Suco de Uva', 3, 'Integral 300ml', 6.00, ''),
('Água Mineral', 3, 'Sem gás 500ml', 3.00, ''),
('Água com Gás', 3, 'Com gás 500ml', 3.00, ''),
('Chá Gelado', 3, 'Limão ou Pêssego', 5.00, ''),
('Refrigerante Zero', 3, 'Lata 350ml', 5.00, ''),
('Energético', 3, 'Lata 250ml', 7.00, ''),
('Milkshake', 3, '300ml - Chocolate ou Morango', 8.00, '');


INSERT INTO Produto (nome, id_categoria, descricao, preco, imagens) VALUES
('Sorvete de Chocolate', 4, '2 bolas com cobertura', 8.00, ''),
('Brownie', 4, 'Brownie com sorvete', 10.00, ''),
('Petit Gâteau', 4, 'Bolo com recheio quente e sorvete', 12.00, ''),
('Torta de Limão', 4, 'Fatia da torta gelada', 7.00, ''),
('Mousse de Maracujá', 4, 'Doce cremoso', 6.00, ''),
('Pudim', 4, 'Tradicional com calda', 6.00, ''),
('Açaí 300ml', 4, 'Açaí com granola e banana', 9.00, ''),
('Brigadeiro', 4, '3 unidades', 5.00, ''),
('Churros', 4, 'Recheado com doce de leite', 8.00, ''),
('Torta de Morango', 4, 'Fatia com cobertura de morango', 7.00, '');

INSERT INTO Produto_Ingrediente (id_ingrediente, id_produto, quantidade) VALUES
(1, 1, 1), (2, 1, 1), (3, 1, 1),
(1, 2, 1), (2, 2, 1), (3, 2, 1), (4, 2, 10), (5, 2, 10),
(1, 3, 1), (2, 3, 1), (3, 3, 1), (6, 3, 2),
(1, 4, 1), (2, 4, 1), (3, 4, 1), (4, 4, 10), (5, 4, 10),
(1, 5, 1), (2, 5, 1), (3, 5, 1),
(1, 6, 1), (2, 6, 1), (3, 6, 1), (4, 6, 10), (5, 6, 10), (6, 6, 2),
(1, 7, 1), (2, 7, 1), (3, 7, 1),
(1, 8, 1), (2, 8, 1), (3, 8, 1), (4, 8, 10), (5, 8, 10),
(1, 9, 1), (2, 9, 1), (3, 9, 1), (6, 9, 2),
(1, 10, 1), (2, 10, 1), (3, 10, 1), (4, 10, 10), (5, 10, 10),

(7, 11, 150), (7, 12, 150), (7, 13, 150), (7, 14, 150), (7, 15, 150),
(7, 16, 150), (7, 17, 150), (7, 18, 150), (7, 19, 150), (7, 20, 150),

(8, 21, 1), (8, 22, 1), (8, 23, 1), (8, 24, 1), (8, 25, 1),
(8, 26, 1), (8, 27, 1), (8, 28, 1), (8, 29, 1), (8, 30, 1),

(9, 31, 2), (10, 31, 30),
(9, 32, 2), (10, 32, 30),
(9, 33, 2), (10, 33, 30),
(9, 34, 2), (10, 34, 30),
(9, 35, 2), (10, 35, 30),
(9, 36, 2), (10, 36, 30),
(9, 37, 2), (10, 37, 30),
(9, 38, 2), (10, 38, 30),
(9, 39, 2), (10, 39, 30),
(9, 40, 2), (10, 40, 30);


INSERT INTO Status_Pagamento (nome)
 VALUES
('Pendente'),
('Aprovado'),
('Recusado'),
('Estornado');


INSERT INTO Status (nome, descricao) 
VALUES
('Aguardando Pagamento', 'Aguardando Pagamento'),
('Recebido', 'Pedido recebido na cozinha'),
('Em preparação', 'Iniciada a preparação do pedido'),
('Pronto', 'Pedido pronto para entrega'),
('Finalizado', 'Pedido retirado ou entregue'),
('Cancelado', 'Pedido cancelado pelo cliente ou restaurante');

INSERT INTO Forma_pagamento (nome, descricao, ativo) 
VALUES('Mercado Pago', 'Pagamento via carteira digital Mercado Pago', 1);