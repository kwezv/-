-- Удаление таблиц, если они уже существуют
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS OrderDetails;

-- Создание таблиц
CREATE TABLE Employees (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    position TEXT NOT NULL,
    hire_date DATE NOT NULL,
    salary REAL NOT NULL
);

CREATE TABLE Orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_name TEXT NOT NULL,
    order_date DATE NOT NULL,
    cost REAL NOT NULL,
    employee_id INTEGER NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employees (id)
);

CREATE TABLE Products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    price REAL NOT NULL,
    category TEXT NOT NULL
);

CREATE TABLE OrderDetails (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders (id),
    FOREIGN KEY (product_id) REFERENCES Products (id)
);

-- Вставка данных в таблицы
INSERT INTO Employees (full_name, position, hire_date, salary) VALUES
('Иванов Иван', 'Механик', '2021-03-15', 50000),
('Петров Петр', 'Курьер', '2022-05-10', 40000),
('Сидоров Сергей', 'Менеджер', '2020-07-20', 60000);

INSERT INTO Products (name, price, category) VALUES
('Моторное масло', 1200, 'Автотовары'),
('Фильтр', 800, 'Автотовары'),
('Шины', 1600, 'Шины и диски'),
('Ароматизатор', 200, 'Аксессуары');

INSERT INTO Orders (client_name, order_date, cost, employee_id) VALUES
('ООО Транспорт', '2024-12-01', 2000, 1),
('Частное лицо', '2024-12-02', 500, 2),
('Компания А', '2024-12-01', 3000, 1);

INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 1),
(3, 3, 2),
(3, 4, 3);

-- Запросы из задания

-- 1a. Вывести ФИО, должность, дату приема и стаж сотрудников, принятых в определенный месяц и год
SELECT
    full_name,
    position,
    hire_date,
    CAST((JULIANDAY('now') - JULIANDAY(hire_date)) AS INTEGER) AS days_worked
FROM Employees
WHERE strftime('%m', hire_date) = '05' AND strftime('%Y', hire_date) = '2022';

-- 1b. Вывести название и стоимость продукции, превышающую 1500 рублей, определенной категории
SELECT
    name,
    price
FROM Products
WHERE price > 1500 AND category = 'Шины и диски';

-- 1c. Получить фамилии сотрудников, заканчивающиеся на «-ов»
SELECT
    full_name
FROM Employees
WHERE full_name LIKE '%ов';

-- 1d. Подсчитать сотрудников, принятых в 2022 году
SELECT
    COUNT(*) AS employees_hired_in_2022
FROM Employees
WHERE strftime('%Y', hire_date) = '2022';

-- 1e. Вывести заказы, стоимость которых превышает 1000 рублей, связанные с определенным курьером
SELECT
    Orders.id,
    Orders.client_name,
    Orders.cost
FROM Orders
JOIN Employees ON Orders.employee_id = Employees.id
WHERE Orders.cost > 1000 AND Employees.full_name = 'Иванов Иван';

-- 1f. ФИО курьера, у которого был самый крупный заказ
SELECT
    Employees.full_name,
    MAX(Orders.cost) AS max_order
FROM Orders
JOIN Employees ON Orders.employee_id = Employees.id
GROUP BY Employees.full_name
ORDER BY max_order DESC
LIMIT 1;

-- 1j. Сумма заказов по категориям за определенный день
SELECT
    Products.category,
    SUM(Products.price * OrderDetails.quantity) AS total_sales
FROM OrderDetails
JOIN Products ON OrderDetails.product_id = Products.id
JOIN Orders ON OrderDetails.order_id = Orders.id
WHERE Orders.order_date = '2024-12-01'
GROUP BY Products.category;

-- 2a. Увеличение зарплаты сотрудников со стажем более 1 года
UPDATE Employees
SET salary = salary * 1.05
WHERE (JULIANDAY('now') - JULIANDAY(hire_date)) > 365;

-- Проверка обновленных зарплат
SELECT * FROM Employees;

