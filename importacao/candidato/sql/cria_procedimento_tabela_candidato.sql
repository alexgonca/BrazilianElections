DROP PROCEDURE IF EXISTS eleicoes.cria_tabela_candidato;
delimiter //
CREATE PROCEDURE eleicoes.cria_tabela_candidato(ano int)
BEGIN
    set @nomedatabela = concat('cand_', ano);

    set @comando = concat('drop table if exists ', @nomedatabela);
    prepare statement from @comando;
    execute statement;
    deallocate prepare statement;

    set @comando = concat(
                'create table ', @nomedatabela, ' 
                (DATA_HORA_GERACAO DATETIME,
                ANO_ELEICAO SMALLINT,
                NUM_TURNO TINYINT,
                DESCRICAO_ELEICAO VARCHAR(150),
                SIGLA_UF VARCHAR(2),
                SIGLA_UE VARCHAR(10),
                DESCRICAO_UE VARCHAR(60),
                CODIGO_CARGO TINYINT,
                DESCRICAO_CARGO VARCHAR(150),
                NOME_CANDIDATO VARCHAR(100),
                SEQUENCIAL_CANDIDATO BIGINT,
                NUMERO_CANDIDATO VARCHAR(5),
                NOME_URNA_CANDIDATO VARCHAR(100),
                COD_SITUACAO_CANDIDATURA SMALLINT,
                DES_SITUACAO_CANDIDATURA VARCHAR(60),
                NUMERO_PARTIDO MEDIUMINT,
                SIGLA_PARTIDO VARCHAR(20),
                NOME_PARTIDO VARCHAR(150),
                CODIGO_LEGENDA VARCHAR(12),
                SIGLA_LEGENDA VARCHAR(60),
                COMPOSICAO_LEGENDA VARCHAR(150),
                NOME_LEGENDA VARCHAR(100),
                CODIGO_OCUPACAO SMALLINT,
                DESCRICAO_OCUPACAO VARCHAR(100),
                DATA_NASCIMENTO DATE,
                NUM_TITULO_ELEITORAL_CANDIDATO VARCHAR(12),
                IDADE_DATA_ELEICAO SMALLINT,
                CODIGO_SEXO VARCHAR(2),
                DESCRICAO_SEXO VARCHAR(20),
                COD_GRAU_INSTRUCAO VARCHAR(2),
                DESCRICAO_GRAU_INSTRUCAO VARCHAR(60),
                CODIGO_ESTADO_CIVIL VARCHAR(2),
                DESCRICAO_ESTADO_CIVIL VARCHAR(60),
                CODIGO_NACIONALIDADE VARCHAR(2),
                DESCRICAO_NACIONALIDADE VARCHAR(100),
                SIGLA_UF_NASCIMENTO VARCHAR(4),
                CODIGO_MUNICIPIO_NASCIMENTO MEDIUMINT,
                NOME_MUNICIPIO_NASCIMENTO VARCHAR(60),
                DESPESA_MAX_CAMPANHA DECIMAL(13,2),
                COD_SIT_TOT_TURNO VARCHAR(2),
                DESC_SIT_TOT_TURNO VARCHAR(60));');
    prepare statement from @comando;
    execute statement;
    deallocate prepare statement;
END
//
delimiter ;
