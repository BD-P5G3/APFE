-- Store Procedure's

DROP PROCEDURE IF EXISTS create_department
DROP PROCEDURE IF EXISTS add_employee

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
        INSERT INTO EMPRESA_CONSTRUCAO.EMPREGADO VALUES (@nif, @first_name, @last_name, @email, @phone_number,
                                                         @address, @gender, @birth_date, @salary, @id_dep)
        PRINT 'Sucess'
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END

SELECT * FROM EMPRESA_CONSTRUCAO.EMPREGADO

-- Test
EXEC add_employee 818364927, 'Rui', 'Abacate', 'rui.abacate@ua.pt', 928466013, 'Rua Fátima de Albergaria', NULL, NULL, 1275.38, 20041

