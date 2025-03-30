import mariadb
"""
db = mariadb.connect(
    host="localhost",
    user="root",
    password="0000",
    database="sakila"
)

cursor = db.cursor()
sql = "SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS Rents FROM customer c JOIN rental r ON c.customer_id = r.customer_id GROUP BY c.customer_id ORDER BY Rents DESC"
cursor.execute(sql)
result = cursor.fetchall()
for row in result:
    print(row)

db = mariadb.connect(
    host="localhost",
    user="root",
    password="0000",
    database="information_schema"
)

cursor = db.cursor()


sql = "SELECT t.TABLE_NAME, t.TABLE_TYPE, c.`COLUMN_NAME`, c.DATA_TYPE FROM `TABLES` t JOIN COLUMNS c ON c.`TABLE_NAME`= t.`TABLE_NAME` WHERE t.table_schema = 'sakila'"
cursor.execute(sql)
result = cursor.fetchall()
for row in result:
    print(row)


db = mariadb.connect(
    host="localhost",
    user="root",
    password="0000",
    database="information_schema"
)

db_info = mariadb.connect(
    host="localhost",
    user="root",
    password="0000",
    database="information_schema"
)

cursor = db_info.cursor()

sql = "SELECT t.TABLE_NAME, t.TABLE_TYPE, c.`COLUMN_NAME`, c.DATA_TYPE FROM `TABLES` t JOIN COLUMNS c ON c.`TABLE_NAME`= t.`TABLE_NAME` WHERE t.table_schema = 'sakila'"
cursor.execute(sql)
result = cursor.fetchall()
for row in result:
    print(row)"
    """

db = mariadb.connect(
    host="localhost",
    user="root",
    password="0000",
    database="information_schema"
)

def execute_query(connection, query):
        cursor = connection.cursor()
        cursor.execute(query)
        return cursor.fetchall()


q1 = "SELECT t.TABLE_NAME, t.TABLE_TYPE, c.`COLUMN_NAME`, c.DATA_TYPE FROM `TABLES` t JOIN COLUMNS c ON c.`TABLE_NAME`= t.`TABLE_NAME` WHERE t.table_schema = 'sakila';"
r1 = execute_query(db, q1)
if r1:
    print("Resultados primera Query:")
    for row in r1:
        print(row)

q2 = "SELECT k.TABLE_SCHEMA, k.`TABLE_NAME`, k.`COLUMN_NAME`, k.`CONSTRAINT_NAME` FROM KEY_COLUMN_USAGE k WHERE k.TABLE_SCHEMA = 'sakila'ORDER BY k.`CONSTRAINT_NAME` DESC"
r2 = execute_query(db, q2)
if r2:
    print("\nResultados segunda Query:")
    for row2 in r2:
        print(row2)