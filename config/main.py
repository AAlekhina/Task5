import psycopg2

## Подключение к локальной базе данных PostgreSQL
conn = psycopg2.connect(
    dbname = 'task4',
    user = 'postgres',
    password = 'postgres',
    host = 'localhost',
    port = '5432'  # default is 5432
)

# Создаем курсор для выполнения SQL-запросов
cursor = conn.cursor()

# Пример запроса
cursor.execute("SELECT version();")

# Получение результата запроса
record = cursor.fetchone()
print(f"Вы подключены к - {record}")

# Закрываем соединение
cursor.close()
conn.close()
