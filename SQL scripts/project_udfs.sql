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
DROP FUNCTION IF EXISTS getEmpregadoBySalary;

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


-- Filtrar os empregados por salário
GO
CREATE FUNCTION getEmpregadoBySalary(@salary DECIMAL(10,2)) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.EMPREGADO
        WHERE salario > @salary
    );
GO

-- Test
SELECT * FROM getEmpregadoBySalary(1200.67)



-- ---------------------------------- UDF'S for EMPRESA_CONSTRUCAO.SERVICO ----------------------------------

DROP FUNCTION IF EXISTS getServicoByCategory;
DROP FUNCTION IF EXISTS getServicoByDepId;


-- Filtrar os serviços por categoria
GO
CREATE FUNCTION getServicoByCategory(@serv_cat VARCHAR(50)) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM  EMPRESA_CONSTRUCAO.SERVICO
        WHERE categoria = @serv_cat
    );
GO

-- Test
SELECT * FROM getServicoByCategory('Construção Sustentável');


-- Filtrar os serviços pelo id do departamento correspondente
GO
CREATE FUNCTION  getServicoByDepId(@dep_id INT) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.SERVICO
        WHERE id_departamento = @dep_id
    );
GO

-- Test
SELECT * FROM getServicoByDepId(20045);



-- ---------------------------------- UDF'S for EMPRESA_CONSTRUCAO.CLIENTE ----------------------------------

DROP FUNCTION IF EXISTS getClientByName;

-- Filtrar empregados pelo primeiro nome e apelido
GO
CREATE FUNCTION getClientByName (
    @client_first_name VARCHAR(20),
    @client_last_name VARCHAR(20)
) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.CLIENTE
        WHERE (@client_first_name IS NULL OR nome_proprio = @client_first_name)
        AND (@client_last_name IS NULL OR apelido = @client_last_name)
    );
GO

-- Test
SELECT * FROM getClientByName('Katelyn','Solis')



-- ---------------------------------- UDF'S for EMPRESA_CONSTRUCAO.OBRA ----------------------------------

DROP FUNCTION IF EXISTS getObraByLocation;
DROP FUNCTION IF EXISTS getObraByClientNif;
DROP FUNCTION IF EXISTS getObraByDate;


-- Filtrar as obras por localização
GO
CREATE FUNCTION getObraByLocation(@ob_location VARCHAR(200)) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.OBRA
        WHERE localizacao = @ob_location
    );
GO

-- Test
SELECT * FROM getObraByLocation ('45102 Monica Mission Apt. 080, Stephaniechester, KS 00774');


-- Filtrar as obras por nif do cliente
GO
CREATE FUNCTION getObraByClientNif(@client_nif INT) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.OBRA
        WHERE nif_cliente = @client_nif
    );
GO

-- Test
SELECT * FROM getObraByClientNif(111356719)


-- Filtrar as obras por data de início e/ou de fim
GO
CREATE FUNCTION getObraByDate(@start_date DATE, @end_date DATE) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.OBRA
        WHERE (@start_date IS NULL OR data_inicio >= @start_date)
        AND (@end_date IS NULL OR data_fim <= @end_date)
    );
GO

-- Test
SELECT * FROM getObraByDate('2023-05-10', '2023-05-28')



-- ---------------------------------- UDF'S for EMPRESA_CONSTRUCAO.REL_OBRA_SERVICO ----------------------------------

DROP FUNCTION IF EXISTS getObraServicoByObra;
DROP FUNCTION IF EXISTS getObraServicoByServico;

-- Filtrar as obras e serviços por id da obra
GO
CREATE FUNCTION getObraServicoByObra(@obra_id INT) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.REL_OBRA_SERVICO
        WHERE id_obra = @obra_id
    )
GO

-- Test
SELECT * FROM getObraServicoByObra(19940064)


-- Filtrar as obras e serviços por id do serviço
GO
CREATE FUNCTION getObraServicoByServico(@servico_id INT) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.REL_OBRA_SERVICO
        WHERE id_servico = @servico_id
    )
GO

-- Test
SELECT * FROM getObraServicoByServico(201111)



-- ---------------------------------- UDF'S for EMPRESA_CONSTRUCAO.REL_OBRA_EMPREGADO ----------------------------------

DROP FUNCTION IF EXISTS getObraEmpregadoByObra;
DROP FUNCTION IF EXISTS getObraEmpregadoByEmpregado;

-- Filtrar as obras e empregados por id de obra
GO
CREATE FUNCTION getObraEmpregadoByObra(@obra_id INT) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.REL_OBRA_EMPREGADO
        WHERE id_obra = @obra_id
    );
GO

-- Test
SELECT * FROM getObraEmpregadoByObra(19940038)


-- Filtrar as obras e empregados por nif do empregado
GO
CREATE FUNCTION getObraEmpregadoByEmpregado(@empr_nif INT) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.REL_OBRA_EMPREGADO
        WHERE nif_empregado = @empr_nif
    );
GO

-- Test
SELECT * FROM getObraEmpregadoByEmpregado(567890321)



-- ---------------------------------- UDF'S for EMPRESA_CONSTRUCAO.MATERIAL_CONSTRUCAO ----------------------------------

DROP FUNCTION IF EXISTS getMaterialByCategory;
DROP FUNCTION IF EXISTS getMaterialByName;
DROP FUNCTION IF EXISTS getMaterialByQuantity;

-- Filtrar os materiais de construção por categoria
GO
CREATE FUNCTION getMaterialByCategory(@category VARCHAR(50)) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.MATERIAL_CONSTRUCAO
        WHERE categoria = @category
    );
GO

-- Test
SELECT * FROM getMaterialByCategory('Acabamentos')


-- Filtrar os materiais de construção por nome
GO
CREATE FUNCTION getMaterialByName(@mat_name VARCHAR(50)) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.MATERIAL_CONSTRUCAO
        WHERE nome = @mat_name
    );
GO

-- Test
SELECT * FROM getMaterialByName('Capacetes')


-- Filtrar os materiais de construção por unidades em armazém
GO
CREATE FUNCTION getMaterialByQuantity(@quantity_mat INT) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.MATERIAL_CONSTRUCAO
        WHERE unidades_armazem >= @quantity_mat
    );
GO

-- Test
SELECT * FROM getMaterialByQuantity(400)



-- ---------------------------------- UDF'S for EMPRESA_CONSTRUCAO.FORNECEDOR ----------------------------------

DROP FUNCTION IF EXISTS getFornecedorByName;


-- Filtrar os fornecedores por nome
GO
CREATE FUNCTION getFornecedorByName(@forn_name VARCHAR(50)) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.FORNECEDOR
        WHERE nome = @forn_name
    );
GO

-- Test
SELECT * FROM getFornecedorByName('MegaConstrução')
