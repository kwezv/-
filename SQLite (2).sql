DROP TABLE IF EXISTS Клиенты;

CREATE TABLE Клиенты (
    ID_Клиента INTEGER PRIMARY KEY AUTOINCREMENT,
    ФИО_Клиента VARCHAR(100),
    Телефон_Клиента VARCHAR(15)
);

INSERT INTO Клиенты (ФИО_Клиента, Телефон_Клиента)
VALUES ('Иван Иванов', '+79991234567');

SELECT * FROM Клиенты;

SELECT COUNT(*) AS Количество
FROM Клиенты
WHERE ФИО_Клиента = 'Иван Иванов';

WITH RECURSIVE random_data(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM random_data WHERE n < 10 
)
INSERT INTO Клиенты (ФИО_Клиента, Телефон_Клиента)
SELECT 'Клиент_' || n, '+7999' || ABS(RANDOM() % 9000000 + 1000000)
FROM random_data;

SELECT * FROM Клиенты;
