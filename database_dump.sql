PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;

-- Таблица возрастных групп
CREATE TABLE AgeGroup (
    age_group_id INTEGER PRIMARY KEY,
    name TEXT,
    min_age INTEGER,
    max_age INTEGER
);

-- Таблица родителей
CREATE TABLE Parent (
    parent_id INTEGER PRIMARY KEY,
    name TEXT,
    city TEXT
);

-- Таблица детей
CREATE TABLE Child (
    child_id INTEGER PRIMARY KEY,
    name TEXT,
    birth_date DATE,
    age_group_id INTEGER,
    parent_id INTEGER,
    FOREIGN KEY (age_group_id) REFERENCES AgeGroup(age_group_id),
    FOREIGN KEY (parent_id) REFERENCES Parent(parent_id)
);

-- Таблица банковских продуктов
CREATE TABLE BankProduct (
    bank_product_id INTEGER PRIMARY KEY,
    name TEXT,
    type TEXT
);

-- Связь родителей с банковскими продуктами
CREATE TABLE ParentBankProduct (
    parent_product_id INTEGER PRIMARY KEY,
    parent_id INTEGER,
    bank_product_id INTEGER,
    start_date DATE,
    FOREIGN KEY (parent_id) REFERENCES Parent(parent_id),
    FOREIGN KEY (bank_product_id) REFERENCES BankProduct(bank_product_id)
);

-- Тематика квестов
CREATE TABLE QuestTheme (
    theme_id INTEGER PRIMARY KEY,
    name TEXT
);

-- Игровые продукты (квесты)
CREATE TABLE GameProduct (
    game_product_id INTEGER PRIMARY KEY,
    name TEXT,
    theme_id INTEGER,
    FOREIGN KEY (theme_id) REFERENCES QuestTheme(theme_id)
);

-- Каникулярные периоды
CREATE TABLE VacationPeriod (
    vacation_id INTEGER PRIMARY KEY,
    name TEXT,
    start_date DATE,
    end_date DATE
);

-- Сессии прохождения квестов
CREATE TABLE GameSession (
    session_id INTEGER PRIMARY KEY,
    child_id INTEGER,
    game_product_id INTEGER,
    session_date DATE,
    completed INTEGER,
    FOREIGN KEY (child_id) REFERENCES Child(child_id),
    FOREIGN KEY (game_product_id) REFERENCES GameProduct(game_product_id)
);

-- Данные для AgeGroup
INSERT INTO AgeGroup (name, min_age, max_age) VALUES
('Младшие школьники', 7, 10),
('Средняя группа', 11, 14),
('Старшие школьники', 15, 17);

-- Данные для Parent
INSERT INTO Parent (name, city) VALUES
('Иванов Иван', 'Москва'),
('Петрова Мария', 'Санкт-Петербург'),
('Сидоров Алексей', 'Казань'),
('Козлова Елена', 'Новосибирск'),
('Морозов Дмитрий', 'Екатеринбург');

-- Данные для BankProduct
INSERT INTO BankProduct (name, type) VALUES
('Потребительский кредит', 'кредит'),
('Ипотека', 'кредит'),
('Накопительный счет', 'вклад'),
('Депозит', 'вклад'),
('Зарплатная карта', 'зарплатная карта'),
('Детская карта', 'зарплатная карта'),
('Инвестиционный счет', 'инвестиции'),
('Автокредит', 'кредит');

-- Данные для ParentBankProduct
INSERT INTO ParentBankProduct (parent_id, bank_product_id, start_date) VALUES
(1, 1, '2025-01-15'),
(1, 3, '2025-02-20'),
(2, 5, '2025-03-10'),
(3, 2, '2025-04-05'),
(4, 4, '2025-05-12'),
(2, 6, '2025-06-01'),
(5, 7, '2025-04-18'),
(5, 8, '2025-05-22');

-- Данные для QuestTheme
INSERT INTO QuestTheme (name) VALUES
('Депозиты'),
('Кредиты'),
('Инвестиции'),
('Бюджетирование'),
('Страхование'),
('Накопления');

-- Данные для GameProduct
INSERT INTO GameProduct (name, theme_id) VALUES
('Копилка', 1),
('Путешествие с процентами', 1),
('Займы в королевстве', 2),
('Биржевой трейдер', 3),
('Бюджет семьи', 4),
('Страховой агент', 5),
('Накопи на мечту', 6),
('Кредитная история', 2),
('Инвестиционный портфель', 3),
('Финансовый детектив', 4);

-- Данные для VacationPeriod
INSERT INTO VacationPeriod (name, start_date, end_date) VALUES
('Летние каникулы 2025', '2025-06-01', '2025-08-31'),
('Зимние каникулы 2025', '2025-12-28', '2026-01-10'),
('Весенние каникулы 2025', '2025-03-24', '2025-03-31'),
('Осенние каникулы 2025', '2025-10-27', '2025-11-02');

-- Данные для Child
INSERT INTO Child (name, birth_date, age_group_id, parent_id) VALUES
('Иванов Петя', '2016-05-10', 1, 1),
('Иванова Катя', '2012-08-15', 2, 1),
('Петрова Анна', '2009-03-22', 3, 2),
('Сидоров Миша', '2015-11-30', 1, 3),
('Сидорова Лена', '2011-07-19', 2, 3),
('Козлов Дима', '2017-01-25', 1, 4),
('Морозова Алиса', '2010-09-14', 2, 5),
('Морозов Артем', '2008-12-03', 3, 5);

-- Данные для GameSession (минимум 20 записей)
INSERT INTO GameSession (child_id, game_product_id, session_date, completed) VALUES
(1, 1, '2025-07-10', 1),
(1, 1, '2025-07-15', 1),
(1, 3, '2025-07-20', 0),
(1, 5, '2025-08-05', 1),
(2, 2, '2025-06-05', 1),
(2, 4, '2025-07-18', 1),
(2, 7, '2025-08-01', 1),
(2, 9, '2025-08-20', 1),
(3, 5, '2025-06-20', 1),
(3, 5, '2025-07-25', 1),
(3, 8, '2025-08-10', 1),
(3, 2, '2025-08-15', 1),
(4, 1, '2025-07-05', 1),
(4, 7, '2025-07-30', 1),
(4, 4, '2025-08-12', 1),
(5, 2, '2025-06-15', 1),
(5, 3, '2025-06-20', 1),
(5, 4, '2025-07-12', 1),
(5, 6, '2025-07-28', 1),
(5, 9, '2025-08-14', 1),
(6, 1, '2025-07-01', 1),
(6, 5, '2025-07-22', 1),
(6, 8, '2025-08-08', 1),
(7, 3, '2025-07-03', 1),
(7, 4, '2025-07-17', 1),
(7, 7, '2025-08-21', 1),
(8, 5, '2025-06-28', 1),
(8, 9, '2025-07-19', 1),
(8, 10, '2025-08-25', 1);

COMMIT;