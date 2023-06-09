
CREATE TABLE USUARIO (
    Login varchar(90),
    Senha varchar(30),
    ID serial PRIMARY KEY,
    Nome varchar(50),
    Telefone bigint,
    FK_TIPO_USUARIO_ID int
);

CREATE TABLE USUARIO_INSTITUICAO (
    CNPJ varchar(18),
    Logo varchar(400),
    FK_USUARIO_ID int PRIMARY KEY,
    FK_ENDERECO_ID int,
    FK_TIPO_ASSINATURA_ID int,
    data_cadastro date,
    data_expiracao date
);

CREATE TABLE USUARIO_PESSOA_FISICA (
    DataNascimento date,
    FK_USUARIO_ID int PRIMARY KEY
);

CREATE TABLE CATEGORIAS_DE_MATERIAIS_RECICLADOS (
    ID serial PRIMARY KEY,
    descricao varchar(20)
);

CREATE TABLE TIPO_USUARIO (
    ID serial PRIMARY KEY,
    descricao varchar(20)
);

CREATE TABLE ENDERECO (
    CEP varchar(20),
    FK_TipoLogradouro_ID int,
    Logradouro varchar(50),
    FK_Estado_ID int,
    FK_Cidade_ID int,
    FK_Bairro_ID int,
    Numero int,
    ID serial PRIMARY KEY,
    Longitude bigint,
    Latitude bigint
);

CREATE TABLE CADASTRO_PONTO_COLETA (
    Nome varchar(30),
    ID serial PRIMARY KEY,
    Imagem varchar,
    FK_USUARIO_INSTITUICAO_FK_USUARIO_ID int,
    FK_ENDERECO_ID int,
    FK_USUARIO_ID int,
    data timestamp
);

CREATE TABLE COMENTARIOS (
    conteudo varchar(500),
    ID serial PRIMARY KEY,
    data timestamp,
    nota int,
    FK_USUARIO_PESSOA_FISICA_FK_USUARIO_ID int,
    FK_PONTO_COLETA_ID int
);

CREATE TABLE MATERIAL_RECICLAVEL (
    PesoEstimado varchar(30),
    ID serial PRIMARY KEY,
    Descricao varchar(300),
    FK_USUARIO_PESSOA_FISICA_FK_USUARIO_ID int,
    FK_USUARIO_INSTITUICAO_FK_USUARIO_ID int,
    latitude float,
    longitude float,
    FK_COLETADO_ID int
);




CREATE TABLE TIPO_ASSINATURA (
    ID serial PRIMARY KEY,
    nome varchar(20),
    descricao varchar(500),
    valor int
);

CREATE TABLE TipoLogradouro (
    ID serial NOT NULL PRIMARY KEY,
    TipoLogradouro varchar(30)
);

CREATE TABLE Estado (
    ID serial NOT NULL PRIMARY KEY,
    Estado varchar(2)
);

CREATE TABLE Cidade (
    ID serial NOT NULL PRIMARY KEY,
    Cidade varchar(30)
);

CREATE TABLE Bairro (
   ID serial NOT NULL PRIMARY KEY,
    Bairro varchar(30)
);

CREATE TABLE Recicla (
    fk_CATEGORIAS_DE_MATERIAIS_RECICLADOS_ID int,
    fk_PONTO_COLETA_ID int
);

CREATE TABLE Valida (
    fk_USUARIO_ID int,
    fk_CADASTRO_PONTO_COLETA_ID int,
    data timestamp,
    resposta boolean
);

CREATE TABLE Pertence (
    fk_CATEGORIAS_DE_MATERIAIS_RECICLADOS_ID int,
    fk_MATERIAL_RECICLAVEL_ID int
);

CREATE TABLE COLETADO (
    ID serial PRIMARY KEY,
    descricao varchar(30)
);


 
ALTER TABLE USUARIO ADD CONSTRAINT FK_USUARIO_2
    FOREIGN KEY (FK_TIPO_USUARIO_ID)
    REFERENCES TIPO_USUARIO (ID)
    ON DELETE CASCADE;
 
ALTER TABLE USUARIO_INSTITUICAO ADD CONSTRAINT FK_USUARIO_INSTITUICAO_2
    FOREIGN KEY (FK_USUARIO_ID)
    REFERENCES USUARIO (ID)
    ON DELETE CASCADE;
 
ALTER TABLE USUARIO_INSTITUICAO ADD CONSTRAINT FK_USUARIO_INSTITUICAO_3
    FOREIGN KEY (FK_ENDERECO_ID)
    REFERENCES ENDERECO (ID)
    ON DELETE CASCADE;
 
ALTER TABLE USUARIO_INSTITUICAO ADD CONSTRAINT FK_USUARIO_INSTITUICAO_4
    FOREIGN KEY (FK_TIPO_ASSINATURA_ID)
    REFERENCES TIPO_ASSINATURA (ID)
    ON DELETE SET NULL;
 
ALTER TABLE USUARIO_PESSOA_FISICA ADD CONSTRAINT FK_USUARIO_PESSOA_FISICA_2
    FOREIGN KEY (FK_USUARIO_ID)
    REFERENCES USUARIO (ID)
    ON DELETE CASCADE;
 
ALTER TABLE ENDERECO ADD CONSTRAINT FK_ENDERECO_2
    FOREIGN KEY (FK_TipoLogradouro_ID)
    REFERENCES TipoLogradouro (ID)
    ON DELETE NO ACTION;
 
ALTER TABLE ENDERECO ADD CONSTRAINT FK_ENDERECO_3
    FOREIGN KEY (FK_Estado_ID)
    REFERENCES Estado (ID)
    ON DELETE NO ACTION;
 
ALTER TABLE ENDERECO ADD CONSTRAINT FK_ENDERECO_4
    FOREIGN KEY (FK_Cidade_ID)
    REFERENCES Cidade (ID)
    ON DELETE NO ACTION;
 
ALTER TABLE ENDERECO ADD CONSTRAINT FK_ENDERECO_5
    FOREIGN KEY (FK_Bairro_ID)
    REFERENCES Bairro (ID)
    ON DELETE NO ACTION;
 
ALTER TABLE CADASTRO_PONTO_COLETA ADD CONSTRAINT FK_CADASTRO_PONTO_COLETA_2
    FOREIGN KEY (FK_USUARIO_INSTITUICAO_FK_USUARIO_ID)
    REFERENCES USUARIO_INSTITUICAO (FK_USUARIO_ID);
 
ALTER TABLE CADASTRO_PONTO_COLETA ADD CONSTRAINT FK_CADASTRO_PONTO_COLETA_3
    FOREIGN KEY (FK_ENDERECO_ID)
    REFERENCES ENDERECO (ID);
 
ALTER TABLE CADASTRO_PONTO_COLETA ADD CONSTRAINT FK_CADASTRO_PONTO_COLETA_4
    FOREIGN KEY (FK_USUARIO_ID)
    REFERENCES USUARIO (ID);
 
ALTER TABLE COMENTARIOS ADD CONSTRAINT FK_COMENTARIOS_2
    FOREIGN KEY (FK_USUARIO_PESSOA_FISICA_FK_USUARIO_ID)
    REFERENCES USUARIO_PESSOA_FISICA (FK_USUARIO_ID)
    ON DELETE CASCADE;
 
ALTER TABLE COMENTARIOS ADD CONSTRAINT FK_COMENTARIOS_3
    FOREIGN KEY (FK_PONTO_COLETA_ID)
    REFERENCES CADASTRO_PONTO_COLETA(ID);
 
ALTER TABLE MATERIAL_RECICLAVEL ADD CONSTRAINT FK_MATERIAL_RECICLAVEL_2
    FOREIGN KEY (FK_USUARIO_PESSOA_FISICA_FK_USUARIO_ID)
    REFERENCES USUARIO_PESSOA_FISICA (FK_USUARIO_ID)
    ON DELETE CASCADE;
 
ALTER TABLE MATERIAL_RECICLAVEL ADD CONSTRAINT FK_MATERIAL_RECICLAVEL_3
    FOREIGN KEY (FK_USUARIO_INSTITUICAO_FK_USUARIO_ID)
    REFERENCES USUARIO_INSTITUICAO (FK_USUARIO_ID)
    ON DELETE CASCADE;
 
ALTER TABLE Recicla ADD CONSTRAINT FK_Recicla_1
    FOREIGN KEY (fk_CATEGORIAS_DE_MATERIAIS_RECICLADOS_ID)
    REFERENCES CATEGORIAS_DE_MATERIAIS_RECICLADOS (ID)
    ON DELETE RESTRICT;
 
ALTER TABLE Recicla ADD CONSTRAINT FK_Recicla_2
    FOREIGN KEY (fk_PONTO_COLETA_ID)
    REFERENCES CADASTRO_PONTO_COLETA(ID);
 
ALTER TABLE Valida ADD CONSTRAINT FK_Valida_1
    FOREIGN KEY (fk_USUARIO_ID)
    REFERENCES USUARIO (ID)
    ON DELETE SET NULL;
 
ALTER TABLE Pertence ADD CONSTRAINT FK_Pertence_1
    FOREIGN KEY (fk_CATEGORIAS_DE_MATERIAIS_RECICLADOS_ID)
    REFERENCES CATEGORIAS_DE_MATERIAIS_RECICLADOS (ID)
    ON DELETE RESTRICT;
 
ALTER TABLE Pertence ADD CONSTRAINT FK_Pertence_2
    FOREIGN KEY (fk_MATERIAL_RECICLAVEL_ID)
    REFERENCES MATERIAL_RECICLAVEL (ID)
    ON DELETE SET NULL;

ALTER TABLE MATERIAL_RECICLAVEL ADD CONSTRAINT FK_MATERIAL_RECICLAVEL_5
    FOREIGN KEY (FK_COLETADO_ID)
    REFERENCES COLETADO (ID);






/* Inserção de dados */

INSERT INTO TIPO_USUARIO (descricao)
VALUES ('Administrador'),
	('Pessoa Física'),
	('Instituição');


INSERT INTO TIPO_ASSINATURA( NOME, DESCRICAO, VALOR)
	VALUES  ('GRATUITO', 'SEM BENEFÍCIOS', 0),
		('PLATINUM', 'RELATÓRIO GERAL SOBRE OS MATERIAIS MAIS PUBLICADOS. RELATÓRIO GERAL SOBRE OS BAIRROS COM MAIS MATERIAIS PUBLICADOS. RELATÓRIO GERAL SOBRE OS BAIRROS COM MAIS PONTOS DE COLETA. RELATÓRIO GERAL SOBRE OS TIPOS DE MATERIAIS RECICLADOS EM CADA BAIRRO. RELATÓRIO GERAL SOBRE OS LOCAIS COM MAIS USUÁRIOS. DESTAQUE EM NOSSA PÁGINA PRINCIPAL.', 119.9);

INSERT INTO Estado (Estado)
VALUES ('ES');

INSERT INTO TipoLogradouro (TipoLogradouro)
VALUES ('Rua'),
       ( 'Avenida'),
       ('Travessa'),
       ('Alameda');

INSERT INTO Cidade (Cidade)
VALUES ('Vitória'),
       ('Vila Velha'),
       ('Cariacica'),
       ('Serra');

INSERT INTO Bairro (Bairro)
VALUES ('Centro'),
       ('Jardim Camburi'),
       ('Praia do Canto'),
       ('Jardim da Penha'),
       ('Centro'),
       ('Itapuã'),
       ('Praia da Costa'),
       ('Glória'),
       ('Campo Grande'),
       ('Jardim América'),
       ('Nova Canaã'),
       ('Alzira Ramos'),
       ('Serra Sede'),
       ('Laranjeiras'),
       ('Jardim Limoeiro'),
       ('Bairro de Fátima');

INSERT INTO USUARIO (Login, Senha, Nome, Telefone, FK_TIPO_USUARIO_ID)
VALUES ('Reciclus_LTDA', 'senha123', 'Reciclus LTDA', 1234567890, 3),
       ('Port_Recicla', 'senha456', 'Port Recicla', 9876543210, 3),
       ('Zocata_Recicla', 'senha789', 'Zocata Recicla', 5555555555,3),
       ('GreenCycle', 'senha123', 'GreenCycle Ltda', 1234567890, 3),
       ('EcoRecycle', 'senha456', 'EcoRecycle S.A.', 9876543210, 3),
       ('EcoRevive', 'senha789', 'EcoRevive Reciclagem', 5555555555, 3),
       ('GreenTech', 'senha123', 'GreenTech Reciclagem', 1234567890, 3),
       ('EcoCycle', 'senha456', 'EcoCycle Sustentabilidade', 9876543210, 3),
('EcoRevolution', 'senha789', 'EcoRevolution Recicláveis', 5555555555,3),
('Salvando_o_verde', 'verde_237', 'Salvando_o_verde', 7777777777, 3),
('Joao_Silva', 'Joao13', 'João Silva', 1111111111, 3),
      ('Maria_Souza', 'Maria13', 'Maria Souza', 2222222222, 2),
      ('Pedro_Santos', 'Pedro13', 'Pedro Santos', 3333333333, 2),
      ('Ana_Oliveira', 'Ana13', 'Ana Oliveira', 4444444444, 2),
      ('Lucas_Pereira', 'Lucas13', 'Lucas Pereira', 5555555555, 2),
      ('Julia_Almeida', 'Julia13', 'Julia Almeida', 6666666666, 2),
      ('Carlos_Costa', 'Carlos13', 'Carlos Costa', 7777777777, 2),
      ('Mariana_Santos', 'Mariana13', 'Mariana Santos', 8888888888, 2),
      ('Fernando_Lima', 'Fernando13', 'Fernando Lima', 9999999999, 2),
      ('Isabela_Rocha', 'Isabela13', 'Isabela Rocha', 1010101010, 2),
      ('Ricardo_Alves', 'Ricardo13', 'Ricardo Alves', 1111111111, 2),
      ('Patricia_Mendes', 'Patricia13', 'Patrícia Mendes', 1212121212, 2),
      ('Gustavo_Nunes', 'Gustavo13', 'Gustavo Nunes', 1313131313, 2),
      ('Amanda_Costa', 'Amanda13', 'Amanda Costa', 1414141414, 2),
      ('Roberto_Oliveira', 'Roberto13', 'Roberto Oliveira', 1515151515, 2),
      ('Renata_Lima', 'Renata13', 'Renata Lima', 1616161616, 2),
      ('Jose_Santos', 'Jose13', 'José Santos', 1717171717, 2),
      ('Camila_Pereira', 'Camila13', 'Camila Pereira', 1818181818, 2),
      ('Rodrigo_Almeida', 'Rodrigo13', 'Rodrigo Almeida', 1919191919, 2),
      ('Leticia_Rocha', 'Leticia13', 'Letícia Rocha', 2020202020, 2),
      ('Rafael_Alves', 'Rafael13', 'Rafael Alves', 2121212121, 2),
      ('Larissa_Mendes', 'Larissa13', 'Larissa Mendes', 2222222222, 2),
      ('Guilherme_Nunes', 'Guilherme13', 'Guilherme Nunes', 2323232323, 2),
      ('Aline_Costa', 'Aline13', 'Aline Costa', 2424242424, 2),
      ('Roberto_Oliveira', 'Roberto13', 'Roberto Oliveira', 2525252525, 2),
      ('Renata_Lima', 'Renata13', 'Renata Lima', 2626262626, 2),
      ('Carlos_Santos', 'Carlos13', 'Carlos Santos', 2727272727, 2),
      ('Carolina_Pereira', 'Carolina13', 'Carolina Pereira', 2828282828, 2),
      ('Rodrigo_Almeida', 'Rodrigo13', 'Rodrigo Almeida', 2929292929, 2),
      ('Larissa_Rocha', 'Larissa13', 'Larissa Rocha', 3030303030, 2),
      ('Ricardo_Alves', 'Ricardo13', 'Ricardo Alves', 3131313131, 2),
      ('Patricia_Mendes', 'Patricia13', 'Patrícia Mendes', 3232323232, 2),
      ('Gustavo_Nunes', 'Gustavo13', 'Gustavo Nunes', 3333333333, 2),
      ('Amanda_Costa', 'Amanda13', 'Amanda Costa', 3434343434, 2),
      ('Roberto_Oliveira', 'Roberto13', 'Roberto Oliveira', 3535353535, 2),
      ('Renata_Lima', 'Renata13', 'Renata Lima', 3636363636, 2),
      ('Jose_Santos', 'Jose13', 'José Santos', 3737373737, 2),
      ('Camila_Pereira', 'Camila13', 'Camila Pereira', 3838383838, 2),
      ('Rodrigo_Almeida', 'Rodrigo13', 'Rodrigo Almeida', 3939393939, 2),
      ('Leticia_Rocha', 'Leticia13', 'Letícia Rocha', 4040404040, 2);

INSERT INTO USUARIO_PESSOA_FISICA (FK_USUARIO_ID, DataNascimento)
VALUES
  (11, '1980-01-01'),
  (12, '1981-02-02'),
  (13, '1982-03-03'),
  (14, '1983-04-04'),
  (15, '1984-05-05'),
  (16, '1985-06-06'),
  (17, '1986-07-07'),
  (18, '1987-08-08'),
  (19, '1988-09-09'),
  (20, '1989-10-10'),
  (21, '1990-11-11'),
  (22, '1991-12-12'),
  (23, '1992-01-13'),
  (24, '1993-02-14'),
  (25, '1994-03-15'),
  (26, '1995-04-16'),
  (27, '1996-05-17'),
  (28, '1997-06-18'),
  (29, '1998-07-19'),
  (30, '1999-08-20'),
  (31, '2000-09-21'),
  (32, '2001-10-22'),
  (33, '2001-11-23'),
  (34, '2001-12-24'),
  (35, '2001-01-25'),
  (36, '2001-02-26'),
  (37, '2001-03-27'),
  (38, '2001-04-28'),
  (39, '2001-05-29'),
  (40, '2001-06-30');

INSERT INTO ENDERECO (CEP, FK_TipoLogradouro_ID, Logradouro, FK_Estado_ID, FK_Cidade_ID, FK_Bairro_ID, Numero, Longitude, Latitude)
VALUES ('29010-001', 1, 'Rua Sete de Setembro', 1, 1, 1, 123, -40.123456, -20.987654),
       ('29020-002', 2, 'Avenida Vitória', 1, 1, 2, 456, -40.123456, -20.987654),
       ('29030-003', 3, 'Travessa Bela Vista', 1, 1, 3, 789, -40.123456, -20.987654),
       ('29040-004', 4, 'Alameda das Flores', 1, 1, 4, 987, -40.123456, -20.987654),
       ('29101-005', 1, 'Rua das Palmeiras', 1, 2, 5, 321, -40.123456, -20.987654),
       ('29102-006', 2, 'Avenida Beira-Mar', 1, 2, 6, 654, -40.123456, -20.987654),
       ('29103-007', 3, 'Travessa da Praia', 1, 2, 7, 987, -40.123456, -20.987654),
       ('29104-008', 4, 'Alameda dos Coqueiros', 1, 2, 8, 159, -40.123456, -20.987654),
       ('29105-009', 1, 'Rua do Sol', 1, 3, 9, 753, -40.123456, -20.987654),
       ('29106-010', 2, 'Avenida da Liberdade', 1, 3, 10, 852, -40.123456, -20.987654),
       ('29107-011', 3, 'Travessa das Flores', 1, 3, 11, 753, -40.123456, -20.987654),
       ('29108-012', 4, 'Alameda das Águias', 1, 3, 12, 951, -40.123456, -20.987654),
       ('29109-013', 1, 'Rua das Gaivotas', 1, 4, 13, 456, -40.123456, -20.987654),
       ('29110-014', 2, 'Avenida do Mar', 1, 4, 14, 789, -40.123456, -20.987654),
       ('29111-015', 3, 'Travessa dos Coqueiros', 1, 4, 15, 123, -40.123456, -20.987654),
       ('29112-016', 4, 'Alameda dos Pássaros', 1, 4, 16, 456, -40.123456, -20.987654),
       ('29015-017', 1, 'Rua dos Lírios', 1, 1, 1, 987, -40.123456, -20.987654),
       ('29025-018', 2, 'Avenida Central', 1, 1, 2, 753, -40.123456, -20.987654),
       ('29035-019', 3, 'Travessa das Acácias', 1, 1, 3, 321, -40.123456, -20.987654),
       ('29045-020', 4, 'Alameda das Violetas', 1, 1, 4, 654, -40.123456, -20.987654),
       ('29100-021', 1, 'Rua das Orquídeas', 1, 2, 5, 987, -40.123456, -20.987654),
       ('29120-022', 2, 'Avenida Central Sul', 1, 2, 6, 159, -40.123456, -20.987654),
       ('29130-023', 3, 'Travessa das Margaridas', 1, 2, 7, 753, -40.123456, -20.987654),
       ('29140-024', 4, 'Alameda das Tulipas', 1, 2, 8, 852, -40.123456, -20.987654),
       ('29150-025', 1, 'Rua das Margaridas', 1, 3, 9, 753, -40.123456, -20.987654),
       ('29160-026', 2, 'Avenida Central Norte', 1, 3, 10, 951, -40.123456, -20.987654),
       ('29170-027', 3, 'Travessa dos Girassóis', 1, 3, 11, 456, -40.123456, -20.987654),
       ('29180-028', 4, 'Alameda das Rosas', 1, 3, 12, 789, -40.123456, -20.987654),
       ('29190-029', 1, 'Rua das Hortênsias', 1, 4, 13, 123, -40.123456, -20.987654),
       ('29200-030', 2, 'Avenida do Lago', 1, 4, 14, 456, -40.123456, -20.987654),
       ('29210-031', 3, 'Travessa dos Cravos', 1, 4, 15, 789, -40.123456, -20.987654),
       ('29220-032', 4, 'Alameda das Camélias', 1, 4, 16, 987, -40.123456, -20.987654),
       ('29013-033', 1, 'Rua das Azaleias', 1, 1, 1, 321, -40.123456, -20.987654),
       ('29023-034', 2, 'Avenida Principal', 1, 1, 2, 654, -40.123456, -20.987654),
       ('29033-035', 3, 'Travessa das Rosas', 1, 1, 3, 987, -40.123456, -20.987654),
       ('29043-036', 4, 'Alameda das Margaridas', 1, 1, 4, 159, -40.123456, -20.987654),
       ('29110-037', 1, 'Rua dos Cravos', 1, 2, 5, 753, -40.123456, -20.987654),
       ('29120-038', 2, 'Avenida do Sol', 1, 2, 6, 852, -40.123456, -20.987654),
       ('29130-039', 3, 'Travessa das Violetas', 1, 2, 7, 753, -40.123456, -20.987654),
       ('29140-040', 4, 'Alameda das Margaridas', 1, 2, 8, 951, -40.123456, -20.987654);

INSERT INTO USUARIO_INSTITUICAO (CNPJ, Logo, FK_USUARIO_ID, FK_ENDERECO_ID, FK_TIPO_ASSINATURA_ID, data_cadastro,  data_expiracao)
VALUES 
  ('11111111111111', 'logo1.jpg', 1, 1, 2, '2023-06-09', '2023-07-09'),
  ('22222222222222', 'logo2.jpg', 2, 2, 1, '2023-07-08', '2023-08-08'),
  ('33333333333333', 'logo3.jpg', 3, 3, 1, '2023-08-04', '2023-09-04'),
  ('44444444444444', 'logo4.jpg', 4, 4, 1, '2023-09-06', '2023-10-06'),
  ('55555555555555', 'logo5.jpg', 5, 5, 1, '2023-08-07', '2023-09-07'),
  ('66666666666666', 'logo6.jpg', 6, 6, 2, '2023-09-03', '2023-10-03'),
  ('77777777777777', 'logo7.jpg', 7, 7, 1, '2023-10-09', '2023-11-09'),
  ('88888888888888', 'logo8.jpg', 8, 8, 2, '2023-11-15', '2023-12-15'),
  ('99999999999999', 'logo9.jpg', 9, 9, 1, '2023-12-17', '2024-01-17'),
  ('10101010101010', 'logo10.jpg', 10, 10, 2, '2023-10-16', '2023-11-16');


INSERT INTO CATEGORIAS_DE_MATERIAIS_RECICLADOS (descricao)
VALUES ('Plástico'),
       ('Papel'),
       ('Vidro'),
       ('Metal'),
       ('Tecido'),
       ('Borracha'),
       ('Madeira'),
       ('Eletrônicos');

INSERT INTO COLETADO (descricao)
	VALUES  ('disponível'),
		('indisponível'),
		('em transação');


INSERT INTO CADASTRO_PONTO_COLETA (FK_USUARIO_INSTITUICAO_FK_USUARIO_ID, FK_ENDERECO_ID, FK_USUARIO_ID, data, nome)
VALUES 
(1, 11, 15, '2019-03-10', 'Ponto Vermelho'),
       (2, 12, 16, '2018-07-20', 'Ponto Azul'),
       (3, 13, 17, '2017-11-05', 'Ponto Verde'),
       (4, 14, 18, '2019-01-15', 'Ponto Violeta'),
       (5, 15, 19, '2016-09-30', 'Ponto Anil'),
       (6, 16, 20, '2018-05-22', 'Ponto Marrom'),
       (7, 17, 21, '2019-08-08', 'Ponto Roxo'),
       (8, 18, 22, '2017-12-03', 'Ponto Branco'),
       (9, 19, 23, '2018-04-18', 'Ponto Preto'),
       (10, 20, 24, '2019-06-12', 'Ponto Laranja'),
       (1, 21, 25, '2016-10-25', 'Ponto Escarlate'),
       (2, 22, 26, '2019-02-14', 'Ponto Cinza'),
       (3, 23, 27, '2017-05-30', 'Ponto Amarelo'),
       (4, 24, 28, '2018-08-01', 'Ponto Ciano'),
       (5, 25, 29, '2016-12-20', 'Ponto Turquesa'),
       (6, 26, 30, '2019-10-05', 'Ponto Caramelo'),
       (4, 27, 31, '2018-02-27', 'Ponto de Fuga'),
       (10, 28, 32, '2017-06-10', 'Ponto Sem Criatividade'),
       (10, 29, 33, '2018-09-22', 'Ponto Tá Acabando'),
       (10, 30, 34, '2017-03-15', 'Ponto Acabou');




INSERT INTO Recicla (fk_CATEGORIAS_DE_MATERIAIS_RECICLADOS_ID, FK_PONTO_COLETA_ID)
VALUES (1, 1),
(2, 1),
(2, 2),
(3, 2),
(4, 2),
(8, 3),
(3, 4),
(5, 4),
(1, 4),
(5, 5),
(7, 6),
(2, 8),
(5, 8),
(3, 9),
(6, 9),
(8, 9),
(3, 10),
(1, 10),
(2, 11),
(3, 11),
(1, 12),
(4, 13),
(5, 13),
(7, 14),
(2, 14),
(5, 14),
(8, 15),
(4, 15),
(2, 15),
(1, 16),
(8, 16),
(2, 17),
(3, 18),
(7, 19),
(6, 20);

INSERT INTO VALIDA (FK_USUARIO_ID, fk_CADASTRO_PONTO_COLETA_ID,data, resposta) 
values(11,1,'2022-06-01 00:00:00', true),
(12, 1 ,'2022-07-15 12:30:45',true),
(13, 1, '2022-08-20 18:15:00',false),
(14, 2, '2022-09-10 09:45:20', true),
(15, 2, '2022-10-05 16:00:00',false),
(16, 1, '2022-11-11 08:20:10',true),
(17, 1, '2022-12-25 20:00:00',false),
(18, 1, '2023-01-02 14:30:55',true),
(19, 3, '2023-02-14 09:10:00',true),
(20, 2, '2023-03-08 17:45:30',true),
(21, 2, '2023-04-01 12:00:00',true),
(22, 1, '2023-05-10 06:15:40',true),
(23, 1, '2023-06-15 10:30:00',false),
(24, 1, '2023-07-20 22:45:15',true),
(25, 2, '2023-08-25 15:00:00',true),
(26, 2, '2023-09-17 11:20:25',true),
(27, 1, '2023-10-10 18:40:00',true),
(28, 2, '2023-11-21 07:00:35',true),
(29, 2, '2023-12-25 19:30:00',true),
(30, 3, '2024-01-01 13:50:50',true);

INSERT INTO COMENTARIOS (conteudo,data, nota,fk_USUARIO_PESSOA_FISICA_FK_USUARIO_ID,FK_PONTO_COLETA_ID) 
values('Muito bom, só foi difícil encontrar','2023-06-10 08:30:45',4,16,3),
('Não tinha o que eu estava procurando e estava todo sujo','2023-06-20 14:15:00',1,38,10),
('O melhor ponto que já visitei, tinha até cafézinho','2023-07-05 16:45:20',5,13,6),
('Este ponto disse que coletava plástico mas não coleta','2023-07-15 12:00:00',3,31,1),
('O pior ponto de coleta que já visitei','2023-06-10 08:30:45',4,16,3);

INSERT INTO MATERIAL_RECICLAVEL(pesoEstimado, descricao, fk_usuario_pessoa_fisica_fk_usuario_id, fk_usuario_instituicao_fk_usuario_id, latitude, longitude, fk_coletado_id)
	VALUES  ('120kg', 'geladeira duas portas, em perfeito estado', 13, 4, -10.02912, 14.2812, 1),
		('60kg', 'fogão 4 bocas completo', 11, 5, -10.02912, 14.2812, 2),
		('120kg', 'lote de garrafa pet', 25, 6, -10.02912, 14.2812, 3),
		('40kg', 'lote de garrafas de vidro', 40, 10, -10.02912, 14.2812, 1),
		('80kg', 'escrivaninha de quarto', 30, 1, -10.04012, 14.2812, 1),
		('20kg', 'lote de notebooks', 35, 4, -10.04012, 14.4012, 2),
		('15kg', 'lote de papelão', 32, 5, -10.02912, 14.4012, 1),
		('15kg', 'lote de papelão', 22, null, -10.04012, 14.4012, 1),
		('13kg', 'lote de brinquedos de plástico', 26, 1, -10.04012, 14.4012, 1);

INSERT INTO PERTENCE (fk_categorias_de_materiais_reciclados_id, fk_material_reciclavel_id)
	VALUES (1, 1),
		(3, 1),
		(4, 1),
		(6, 1),
		(8, 1),
		(3, 2),
		(4, 2),
		(6, 2),
		(1, 2),
(1, 3),
		(3, 4),
		(7, 5),
		(4, 5),
(1, 6),
		(3, 6),
		(4, 6),
		(8, 6),
(2, 7),
		(2, 8),
		(1, 9),
		(6, 9);
		
