-- Store Procedure's

DROP PROCEDURE IF EXISTS create_department;
DROP PROCEDURE IF EXISTS add_employee;
DROP PROCEDURE IF EXISTS create_obra;
DROP PROCEDURE IF EXISTS create_client;



-- Criar um novo Departamento
GO
CREATE PROCEDURE create_department(@dep_id INT, @dep_name VARCHAR(100))
AS
BEGIN
    BEGIN TRY
        INSERT INTO EMPRESA_CONSTRUCAO.DEPARTAMENTO VALUES (@dep_id, @dep_name)
        PRINT 'Success'
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

SELECT * FROM EMPRESA_CONSTRUCAO.SERVICO
-- Test
EXEC create_department 200411, 'Departamento de Redes'



-- Adicionar um empregado novo
GO
CREATE PROCEDURE add_employee(@nif INT, @first_name VARCHAR(25), @last_name VARCHAR(25), @email VARCHAR(50), @phone_number INT,
                              @address VARCHAR(200), @gender CHAR, @birth_date DATE, @salary DECIMAL(10,2), @id_dep INT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO EMPRESA_CONSTRUCAO.EMPREGADO(nif, nome_proprio, apelido, email, telefone, morada, genero, data_nascimento, id_departamento)
            VALUES (@nif, @first_name, @last_name, @email, @phone_number, @address, @gender, @birth_date, @salary, @id_dep)
            PRINT 'Sucess'
        COMMIT
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
        ROLLBACK
    END CATCH
END
GO

SELECT * FROM EMPRESA_CONSTRUCAO.EMPREGADO

-- Test
EXEC add_employee 818364927, 'Rui', 'Abacate', 'rui.abacate@ua.pt', 928466013, 'Rua Fátima de Albergaria', NULL, NULL, 1275.38, 20041



-- Criar uma obra nova
GO
CREATE PROCEDURE create_obra(@id_obra INT, @location VARCHAR(200), @begin_date DATE, @end_date DATE, @client_nif INT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO EMPRESA_CONSTRUCAO.OBRA(id, localizacao, data_inicio, data_fim, nif_cliente)
                VALUES (@id_obra, @location, @begin_date, @end_date, @client_nif)
        COMMIT
    END TRY

    BEGIN CATCH
        PRINT ERROR_MESSAGE()
        ROLLBACK
    END CATCH
END
GO

SELECT * FROM EMPRESA_CONSTRUCAO.OBRA

EXEC create_obra 19940091, 'Rua São Miguel Açores, BAA', '2023-01-01', '2023-01-22', 287944069



-- Criar um cliente novo
GO
CREATE PROCEDURE create_client(@nif_client INT, @first_name VARCHAR(25), @last_name VARCHAR(25), @email VARCHAR(100), @phone_number INT, @address VARCHAR(200))
AS
BEGIN
   BEGIN TRY
       INSERT INTO EMPRESA_CONSTRUCAO.CLIENTE(nif, nome_proprio, apelido, email, telefone, morada)
            VALUES (@nif_client, @first_name, @last_name, @email, @phone_number, @address)
        PRINT 'Success on the insertion'
   END TRY
   BEGIN CATCH
       PRINT ERROR_MESSAGE()
   END CATCH
END
GO

SELECT * FROM EMPRESA_CONSTRUCAO.CLIENTE

-- Test
EXEC create_client 123741849, 'Maria', 'Beatriz', 'maria.beatriz@ua.pt', 234712984, 'Rua Desportiva de Alvas, ABC'

