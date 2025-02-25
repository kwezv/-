DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    position VARCHAR(50),
    hire_date DATE,
    salary NUMERIC
);

CREATE OR REPLACE PROCEDURE InsertDataIntoTable(
    p_table_name TEXT,
    p_column_values TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    EXECUTE 'INSERT INTO ' || p_table_name || ' VALUES (' || p_column_values || ')';
    RAISE NOTICE 'Запись вставлена';
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Ошибка при вставке данных: %', SQLERRM;
END;
$$;

CREATE OR REPLACE FUNCTION GetRecordCount(
    p_table_name TEXT,
    p_filter_condition TEXT
) RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    record_count INTEGER;
BEGIN
    EXECUTE 'SELECT COUNT(*) FROM ' || p_table_name || ' WHERE ' || p_filter_condition INTO record_count;
    RETURN record_count;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Ошибка при подсчете записей: %', SQLERRM;
        RETURN -1;
END;
$$;

CREATE OR REPLACE FUNCTION NumberToWords(
    p_number INTEGER
) RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
    CASE p_number
        WHEN 1 THEN RETURN 'один';
        WHEN 15 THEN RETURN 'пятнадцать';
        WHEN 100 THEN RETURN 'сто';
        WHEN 1001 THEN RETURN 'тысяча один';
        ELSE RETURN 'Неизвестное число';
    END CASE;
END;
$$;

CREATE OR REPLACE PROCEDURE PopulateTableRandomly(
    p_table_name TEXT,
    p_record_count INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_name_list TEXT[] := ARRAY['Иван', 'Петр', 'Сергей', 'Анна', 'Мария'];
    v_job_list TEXT[] := ARRAY['Механик', 'Курьер', 'Менеджер', 'Администратор', 'Продавец'];
    v_random_name TEXT;
    v_random_job TEXT;
    v_salary NUMERIC;
BEGIN
    FOR i IN 1..p_record_count LOOP
        v_random_name := v_name_list[FLOOR(RANDOM() * array_length(v_name_list, 1) + 1)];
        v_random_job := v_job_list[FLOOR(RANDOM() * array_length(v_job_list, 1) + 1)];
        v_salary := ROUND(RANDOM() * (100000 - 30000) + 30000, 2);

        EXECUTE 'INSERT INTO ' || p_table_name || ' (full_name, position, hire_date, salary) VALUES ($1, $2, NOW(), $3)'
        USING v_random_name, v_random_job, v_salary;
    END LOOP;
    RAISE NOTICE '% записей успешно добавлено в таблицу %', p_record_count, p_table_name;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Ошибка при заполнении таблицы: %', SQLERRM;
END;
$$;


