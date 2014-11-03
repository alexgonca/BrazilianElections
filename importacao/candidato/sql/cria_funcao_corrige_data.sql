DROP FUNCTION IF EXISTS CORRIGE_DATA;
delimiter //
CREATE FUNCTION corrige_data(data_original VARCHAR(20))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE data_aux VARCHAR(20);
    DECLARE dia VARCHAR(2);
    DECLARE mes VARCHAR(2);
    DECLARE ano VARCHAR(4);
    SET data_aux = '';

    # se a string da data é vazia (possivelmente, uma data que era inconsistente e que nós alteramos...)
    IF data_original = '' THEN
        # especifica uma data 'zerada'.
        SET data_aux = '00000000';
    # se a data é no formato '13-MAR-1981'...
    # (anos de 2006 e 2008)
    ELSEIF INSTR(data_original, '-') <> 0 THEN
        SET data_aux = date_format(str_to_date(data_original, '%d-%M-%Y'), '%Y%m%d');
    # se a data é no formato '13/03/1981'...
    # (anos de 2010 e 2012)
    ELSEIF INSTR(data_original, '/') <> 0 and length(data_original) = 10 THEN
        SET data_aux = date_format(str_to_date(data_original, '%d/%m/%Y'), '%Y%m%d');
    # se a data é no formato '13/03/81'...
    # (ano de 1994)
    ELSEIF INSTR(data_original, '/') <> 0 and length(data_original) = 8 THEN
        SET dia = SUBSTRING(data_original, 1, 2);
        SET mes = SUBSTRING(data_original, 4, 2);
        SET ano = SUBSTRING(data_original, 7);
        IF length(trim(dia)) = 1 THEN
            SET dia = CONCAT('0', TRIM(dia));
        END IF;
        IF length(trim(mes)) = 1 THEN
            SET mes = CONCAT('0', TRIM(mes));
        END IF;
        SET data_aux = concat('19', ano, mes, dia);        
    # se a data é no formato '13031981'...
    # (anos de 1996 a 2004)
    ELSEIF LENGTH(data_original) = 8 and INSTR(data_original, '/') = 0 THEN
        SET dia = SUBSTRING(data_original, 1, 2);
        SET mes = SUBSTRING(data_original, 3, 2);
        SET ano = SUBSTRING(data_original, 5);
        # se data é " 3031981" ou "3 031981"...
        IF length(trim(dia)) = 1 THEN
            SET dia = CONCAT('0', TRIM(dia));
        END IF;
        # se data é "13 31981" ou "133 1981"...
        IF length(trim(mes)) = 1 THEN
            SET mes = CONCAT('0', TRIM(mes));
        END IF;
        SET data_aux = concat(ano, mes, dia);
    # se a data tem um caracter a menos (idealmente um zero que desapareceu à esquerda, como em '6041981') e o ano no lugar certo.
    # (situação anômala entre os anos de 1996 e 2004)
    ELSEIF LENGTH(data_original) = 7 and SUBSTRING(data_original, 4, 2) in ('18', '19', '20') THEN
        SET dia = CONCAT('0', SUBSTRING(data_original, 1, 1));
        SET mes = SUBSTRING(data_original, 2, 2);
        SET ano = SUBSTRING(data_original, 4);
        IF length(trim(mes)) = 1 THEN
            SET mes = CONCAT('0', TRIM(mes));
        END IF;
        SET data_aux = concat(ano, mes, dia);
    # se a data é no formato '130381'
    # (situação anômala no ano de 2004)
    ELSEIF length(data_original) = 6 THEN
        SET dia = SUBSTRING(data_original, 1, 2);
        SET mes = SUBSTRING(data_original, 3, 2);
        SET ano = SUBSTRING(data_original, 5);
        IF length(trim(dia)) = 1 THEN
            SET dia = CONCAT('0', TRIM(dia));
        END IF;
        IF length(trim(mes)) = 1 THEN
            SET mes = CONCAT('0', TRIM(mes));
        END IF;
        SET data_aux = concat('19', ano, mes, dia);
    # para os casos omissos, concatena 'x' no início para não haver conversões espúrias.
    ELSE
        SET data_aux = concat('x', data_original);
    END IF;
    # se o formato é incompreensível, associa a uma data impossível (29/02/2013, por exemplo).
    # desta forma, o banco de dados vai apontar a linha onde ocorreu o erro.
    IF date(data_aux) is null THEN
        IF date(data_original) is null THEN
            SET data_aux = data_original;
        ELSE
            SET data_aux = '20130229';
        END IF;
    END IF;
    RETURN data_aux;
END
//
delimiter ;