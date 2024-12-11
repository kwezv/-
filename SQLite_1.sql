DROP TABLE IF EXISTS Заказы;
DROP TABLE IF EXISTS Автомобили;
DROP TABLE IF EXISTS Услуги;
DROP TABLE IF EXISTS Мастера;
DROP TABLE IF EXISTS Клиенты;

CREATE TABLE Клиенты (
    ID_Клиента INT PRIMARY KEY,
    ФИО_Клиента VARCHAR(100),
    Телефон_Клиента VARCHAR(15)
);

CREATE TABLE Автомобили (
    ID_Автомобиля INT PRIMARY KEY,
    Марка VARCHAR(50),
    Модель VARCHAR(50),
    ID_Клиента INT,
    FOREIGN KEY (ID_Клиента) REFERENCES Клиенты(ID_Клиента)
);

CREATE TABLE Услуги (
    ID_Услуги INT PRIMARY KEY,
    Название_Услуги VARCHAR(100),
    Стоимость DECIMAL(10, 2)
);

CREATE TABLE Мастера (
    ID_Мастера INT PRIMARY KEY,
    ФИО_Мастера VARCHAR(100),
    Телефон_Мастера VARCHAR(15),
    Зарплата DECIMAL(10, 2) 
);

CREATE TABLE Заказы (
    ID_Заказа INT PRIMARY KEY,
    Дата_Заказа DATE,
    ID_Клиента INT,
    ID_Автомобиля INT,
    ID_Услуги INT,
    ID_Мастера INT,
    FOREIGN KEY (ID_Клиента) REFERENCES Клиенты(ID_Клиента),
    FOREIGN KEY (ID_Автомобиля) REFERENCES Автомобили(ID_Автомобиля),
    FOREIGN KEY (ID_Услуги) REFERENCES Услуги(ID_Услуги),
    FOREIGN KEY (ID_Мастера) REFERENCES Мастера(ID_Мастера)
);

INSERT INTO Клиенты (ID_Клиента, ФИО_Клиента, Телефон_Клиента) VALUES
(1, 'Иванов Иван Иванович', '+79990001122'),
(2, 'Петров Петр Петрович', '+79990002233'),
(3, 'Сидорова Анна Сергеевна', '+79990003344');

INSERT INTO Автомобили (ID_Автомобиля, Марка, Модель, ID_Клиента) VALUES
(1, 'Toyota', 'Camry', 1),
(2, 'Honda', 'Civic', 2),
(3, 'BMW', 'X5', 3);

INSERT INTO Услуги (ID_Услуги, Название_Услуги, Стоимость) VALUES
(1, 'Замена масла', 3000.00),
(2, 'Шиномонтаж', 1500.00),
(3, 'Диагностика', 2000.00);

INSERT INTO Мастера (ID_Мастера, ФИО_Мастера, Телефон_Мастера, Зарплата) VALUES
(1, 'Смирнов Алексей Владимирович', '+79991234567', 50000.00),
(2, 'Кузнецов Михаил Сергеевич', '+79992345678', 60000.00),
(3, 'Попова Ольга Николаевна', '+79993456789', 55000.00);

INSERT INTO Заказы (ID_Заказа, Дата_Заказа, ID_Клиента, ID_Автомобиля, ID_Услуги, ID_Мастера) VALUES
(1, '2024-12-10', 1, 1, 1, 1),
(2, '2024-12-11', 2, 2, 2, 2),
(3, '2024-12-12', 3, 3, 3, 3);
