-- 1. Процедура вставки данных с обработкой ошибок
CREATE OR REPLACE PROCEDURE insert_record(
    p_table_name IN VARCHAR2,
    p_values     IN VARCHAR2
) AS
    sql_stmt VARCHAR2(1000);
BEGIN
    sql_stmt := 'INSERT INTO ' || p_table_name || ' VALUES (' || p_values || ')';
    EXECUTE IMMEDIATE sql_stmt;
    DBMS_OUTPUT.PUT_LINE('Запись вставлена');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка при вставке записи: ' || SQLERRM);
END;
/

-- 2. Функция для получения количества записей с фильтром
CREATE OR REPLACE FUNCTION get_record_count(
    p_table_name IN VARCHAR2,
    p_filter     IN VARCHAR2
) RETURN NUMBER IS
    sql_stmt VARCHAR2(1000);
    record_count NUMBER;
BEGIN
    sql_stmt := 'SELECT COUNT(*) FROM ' || p_table_name || ' WHERE ' || p_filter;
    EXECUTE IMMEDIATE sql_stmt INTO record_count;
    RETURN record_count;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLERRM);
        RETURN -1;
END;
/

-- 3. Функция перевода числа в текст
CREATE OR REPLACE FUNCTION number_to_words(p_number IN NUMBER) RETURN VARCHAR2 IS
    TYPE t_array IS TABLE OF VARCHAR2(100);
    units t_array := t_array(
        'ноль', 'один', 'два', 'три', 'четыре', 'пять', 'шесть', 'семь', 'восемь', 'девять');
    teens t_array := t_array(
        'десять', 'одиннадцать', 'двенадцать', 'тринадцать', 'четырнадцать', 
        'пятнадцать', 'шестнадцать', 'семнадцать', 'восемнадцать', 'девятнадцать');
    tens t_array := t_array(
        NULL, NULL, 'двадцать', 'тридцать', 'сорок', 'пятьдесят', 
        'шестьдесят', 'семьдесят', 'восемьдесят', 'девяносто');
    hundreds t_array := t_array(
        NULL, 'сто', 'двести', 'триста', 'четыреста', 'пятьсот', 
        'шестьсот', 'семьсот', 'восемьсот', 'девятьсот');
    result VARCHAR2(1000) := '';
    num NUMBER := p_number;
BEGIN
    IF num < 0 OR num >= 1000000 THEN
        RETURN 'Число вне диапазона (0-999999)';
    END IF;

    IF num = 0 THEN
        RETURN units(1);
    END IF;

    -- Обработка сотен
    IF num >= 100 THEN
        result := result || hundreds(TRUNC(num / 100)) || ' ';
        num := MOD(num, 100);
    END IF;

    -- Обработка десятков и единиц
    IF num >= 10 AND num <= 19 THEN
        result := result || teens(num - 9);
    ELSE
        IF num >= 20 THEN
            result := result || tens(TRUNC(num / 10)) || ' ';
        END IF;
        IF MOD(num, 10) > 0 THEN
            result := result || units(MOD(num, 10));
        END IF;
    END IF;

    RETURN RTRIM(result);
END;
/

-- 4. Процедура заполнения таблицы случайными значениями
CREATE OR REPLACE PROCEDURE populate_table(
    p_table_name IN VARCHAR2,
    p_column1    IN VARCHAR2,
    p_column2    IN VARCHAR2,
    p_row_count  IN NUMBER
) AS
BEGIN
    FOR i IN 1..p_row_count LOOP
        EXECUTE IMMEDIATE 'INSERT INTO ' || p_table_name || '(' || p_column1 || ', ' || p_column2 || ') VALUES (' ||
                          DBMS_RANDOM.VALUE(1, 100) || ', ''' || DBMS_RANDOM.STRING('U', 10) || ''')';
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Таблица заполнена ' || p_row_count || ' записями.');
END;
/
