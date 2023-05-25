-- ---------------------------------- UDF'S for EMPRESA_CONSTRUCAO.DEPARTAMENTO ----------------------------------

DROP FUNCTION IF EXISTS getDepartamentoById;

-- Filtrar os departamentos por id ao ser dado como argumento um id do departamento
GO
CREATE FUNCTION getDepartamentoById (@dep_id INT) RETURNS TABLE
AS
    RETURN (
        SELECT DEP.nome AS Departamento_nome, E.nome_proprio AS Emp_nome_proprio, E.apelido AS Emp_apelido, E.email AS Emp_email, S.id_S AS Serv_id, S.categoria AS SER_categoria
        FROM EMPRESA_CONSTRUCAO.DEPARTAMENTO AS DEP
        JOIN EMPRESA_CONSTRUCAO.EMPREGADO AS E ON DEP.id = E.id_departamento
        JOIN EMPRESA_CONSTRUCAO.SERVICO AS S ON E.id_departamento = S.id_departamento
        WHERE id = @dep_id
    )
GO

-- Test
SELECT * FROM getDepartamentoById(20041)



-- ---------------------------------- UDF'S for EMPRESA_CONSTRUCAO.EMPREGADO ----------------------------------

DROP FUNCTION IF EXISTS getEmpregadoByName;
DROP FUNCTION IF EXISTS getEmpregadoBySexBirthSalary;

-- Filtrar empregados pelo primeiro nome e apelido
GO
CREATE FUNCTION getEmpregadoByName(
    @emp_first_name VARCHAR(20),
    @emp_last_name VARCHAR(20)
) RETURNS TABLE
AS
    RETURN (
        SELECT *
        FROM EMPRESA_CONSTRUCAO.EMPREGADO
        WHERE (@emp_first_name IS NULL OR nome_proprio LIKE @emp_first_name + '%')
        AND (@emp_last_name IS NULL OR apelido LIKE  @emp_last_name + '%')
    );
GO

-- Tests
SELECT * FROM getEmpregadoByName('Jo', NULL)
SELECT * FROM getEmpregadoByName(NULL, NULL)
SELECT * FROM getEmpregadoByName(NULL, 'Mir')
SELECT * FROM getEmpregadoByName('Rúben', 'Gameiro')


-- Filtrar os empregados por género/data de nascimento/salário
GO
CREATE FUNCTION getEmpregadoBySexBirthSalary(@sex CHAR, @birth_date DATE, @salary DECIMAL(10,2)) RETURNS TABLE
AS
    RETURN (
        SELECT * FROM EMPRESA_CONSTRUCAO.EMPREGADO
        WHERE (@sex IS NULL OR genero = @sex) AND
        (@birth_date IS NULL OR data_nascimento >= @birth_date) AND
        (@salary IS NULL OR salario >= @salary)
    )
GO

SELECT * FROM getEmpregadoBySexBirthSalary('M' , '1955-08-11', 50000)



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
        WHERE (@client_first_name IS NULL OR nome_proprio LIKE @client_first_name + '%')
        AND (@client_last_name IS NULL OR apelido LIKE @client_last_name + '%')
    );
GO

-- Test
SELECT * FROM getClientByName('K', 'W')



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
        SELECT REL_O_E.nif_empregado, REL_O_E.dia, REL_O_E.horas, E.nome_proprio, E.apelido, E.email
        FROM EMPRESA_CONSTRUCAO.REL_OBRA_EMPREGADO AS REL_O_E
        JOIN EMPRESA_CONSTRUCAO.EMPREGADO AS E ON REL_O_E.nif_empregado = E.nif
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
        SELECT REL_O_E.id_obra, O.localizacao, O.data_inicio, O.data_fim
        FROM EMPRESA_CONSTRUCAO.REL_OBRA_EMPREGADO AS REL_O_E
        JOIN EMPRESA_CONSTRUCAO.OBRA AS O ON REL_O_E.id_obra = O.id
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
