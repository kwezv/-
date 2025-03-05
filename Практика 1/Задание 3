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

INSERT INTO Клиенты (ID_Клиента, ФИО_Клиента, Телефон_Клиента) VALUES
(1, 'Иванов Иван Иванович', '+79990001122'),
(2, 'Петров Петр Петрович', '+79990002233'),
(3, 'Сидорова Анна Сергеевна', '+79990003344');

CREATE TABLE Автомобили (
    ID_Автомобиля INT PRIMARY KEY,
    Марка VARCHAR(50),
    Модель VARCHAR(50),
    ID_Клиента INT,
    FOREIGN KEY (ID_Клиента) REFERENCES Клиенты(ID_Клиента)
);

INSERT INTO Автомобили (ID_Автомобиля, Марка, Модель, ID_Клиента) VALUES
(1, 'Toyota', 'Camry', 1),
(2, 'Hyundai', 'Solaris', 2),
(3, 'Ford', 'Focus', 3);

CREATE TABLE Услуги (
    ID_Услуги INT PRIMARY KEY,
    Название_Услуги VARCHAR(100),
    Стоимость DECIMAL(10, 2)
);

INSERT INTO Услуги (ID_Услуги, Название_Услуги, Стоимость) VALUES
(1, 'Замена масла', 2000.00),
(2, 'Шиномонтаж', 1500.00),
(3, 'Диагностика двигателя', 3000.00);

CREATE TABLE Мастера (
    ID_Мастера INT PRIMARY KEY,
    ФИО_Мастера VARCHAR(100),
    Телефон_Мастера VARCHAR(15)
);

INSERT INTO Мастера (ID_Мастера, ФИО_Мастера, Телефон_Мастера) VALUES
(1, 'Кузнецов Сергей Анатольевич', '+79990004455'),
(2, 'Новиков Андрей Дмитриевич', '+79990005566'),
(3, 'Волкова Елена Викторовна', '+79990006677');

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

INSERT INTO Заказы (ID_Заказа, Дата_Заказа, ID_Клиента, ID_Автомобиля, ID_Услуги, ID_Мастера) VALUES
(1, '2024-12-01', 1, 1, 1, 1),
(2, '2024-12-02', 2, 2, 2, 2),
(3, '2024-12-03', 3, 3, 3, 3);
