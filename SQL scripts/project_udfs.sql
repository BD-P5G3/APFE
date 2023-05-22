-- ---------------------------------- UDF'S for EMPRESA_CONSTRUCAO.DEPARTAMENTO ----------------------------------

DROP FUNCTION IF EXISTS getDepartamentoByName;
DROP FUNCTION IF EXISTS getDepartamentoById;

-- Filtrar os departamentos por nome ao ser dado como argumento um nome do departamento
GO
CREATE FUNCTION getDepartamentoByName (@dep_name VARCHAR(100)) RETURNS TABLE
AS
    RETURN(SELECT * FROM EMPRESA_CONSTRUCAO.DEPARTAMENTO
            WHERE nome = @dep_name
    )
GO

-- Test
SELECT * FROM getDepartamentoByName('Departamento de Engenharia Civil')



-- Filtrar os departamentos por id ao ser dado como argumento um id do departamento
GO
CREATE FUNCTION getDepartamentoById (@dep_id INT) RETURNS TABLE
AS
    RETURN(SELECT * FROM EMPRESA_CONSTRUCAO.DEPARTAMENTO
            WHERE id = @dep_id
    )
GO

-- Test
SELECT * FROM getDepartamentoById(200410)

-- ---------------------------------- UDF'S for EMPRESA_CONSTRUCAO.EMPREGADO ----------------------------------

DROP FUNCTION IF EXISTS getEmpregadoByName;
DROP FUNCTION IF EXISTS getEmpregadoByBirthDate;
DROP FUNCTION IF EXISTS getEmpregadoBySex;

-- Filtrar empregados pelo primeiro nome e apelido
GO
CREATE FUNCTION getEmpregadoByName(
    @emp_first_name VARCHAR(20),
    @emp_last_name VARCHAR(20)
) RETURNS TABLE
AS RETURN
    (
        SELECT *
        FROM EMPRESA_CONSTRUCAO.EMPREGADO
        WHERE (@emp_first_name IS NULL OR nome_proprio = @emp_first_name)
        AND (@emp_last_name IS NULL OR apelido = @emp_last_name)
    );
GO

-- Tests
SELECT * FROM getEmpregadoByName('José', NULL)
SELECT * FROM getEmpregadoByName(NULL, NULL)
SELECT * FROM getEmpregadoByName(NULL, 'Miranda')
SELECT * FROM getEmpregadoByName('Rúben', 'Gameiro')



-- Filtrar os empregados por data de nascimento
GO
CREATE FUNCTION getEmpregadoByBirthDate(@emp_birth DATE) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.EMPREGADO
        WHERE data_nascimento = @emp_birth
    );
GO

-- Test
SELECT * FROM getEmpregadoByBirthDate('1973-11-14')



-- Filtrar os empregados por Género
GO
CREATE FUNCTION getEmpregadoBySex(@emp_sex CHAR) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.EMPREGADO
        WHERE genero = @emp_sex
    );
GO

-- Test
SELECT * FROM getEmpregadoBySex('M');



