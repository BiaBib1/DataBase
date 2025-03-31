from openpyxl import Workbook
import mariadb

# Connect to the database information_schema
db = mariadb.connect(
    host="localhost",
    user="root",
    password="0000",
    database="information_schema"
)

# Function to execute a query and return the results
def execute_query(connection, query):
    cursor = connection.cursor()
    cursor.execute(query)
    return cursor.fetchall(), [desc[0] for desc in cursor.description]  # Return data and column names

# Create a new Excel with results from the querys
wb = Workbook()
ws = wb.active
ws.title = "Query Results"

# First Query: Lista todas las tablas de la base de datos
q1 = "SELECT c.`TABLE_NAME`, c.`COLUMN_NAME`, c.DATA_TYPE, c.CHARACTER_SET_NAME, c.COLUMN_TYPE, c.COLUMN_KEY, c.EXTRA, c.`PRIVILEGES` " \
     "FROM information_schema.COLUMNS c " \
     "WHERE TABLE_SCHEMA = 'sakila';"
r1, columns1 = execute_query(db, q1)
if r1:
    ws.append(["Todas las Tablas"])  # Add a header
    ws.append(columns1)  # Add column titles
    for row in r1:
        ws.append(row)  # Add each row to the Excel sheet

# Second Query: Obtén las columnas y tipos de datos de cada tabla.
q2 = "SELECT t.TABLE_NAME, t.TABLE_TYPE, c.`COLUMN_NAME`, c.DATA_TYPE FROM `TABLES` t " \
     "JOIN COLUMNS c ON c.`TABLE_NAME`= t.`TABLE_NAME` " \
     "WHERE t.table_schema = 'sakila';"
r2, columns2 = execute_query(db, q2)
if r2:
    ws.append([])  # Add an empty row for separation
    ws.append(["Columnas y tipo de datos"])  # Add a header
    ws.append(columns2)  # Add column titles
    for row2 in r2:
        ws.append(row2)

# Third Query: Identifica las claves primarias y foráneas de la base de datos.
q3 = "SELECT k.TABLE_SCHEMA, k.`TABLE_NAME`, k.`COLUMN_NAME`, k.`CONSTRAINT_NAME` " \
     "FROM KEY_COLUMN_USAGE k " \
     "WHERE k.TABLE_SCHEMA = 'sakila' " \
     "ORDER BY k.`CONSTRAINT_NAME` DESC;"
r3, columns3 = execute_query(db, q3)
if r3:
    ws.append([])  # Add an empty row for separation
    ws.append(["Claves primarias y foráneas"])  # Add a header
    ws.append(columns3)  # Add column titles
    for row3 in r3:
        ws.append(row3)

# Third Query dot one: Cuentas claves
q4 = "SELECT tc.CONSTRAINT_TYPE, COUNT(*) AS Keys_Number " \
"FROM information_schema.table_constraints tc " \
"WHERE tc.TABLE_SCHEMA = 'sakila' " \
"GROUP BY tc.CONSTRAINT_TYPE " \
"ORDER BY Keys_Number DESC;"
r4, columns4 = execute_query(db, q4)
if r4:
    ws.append([])  # Add an empty row for separation
    ws.append(["Resultados cuarta Query:"])  # Add a header
    ws.append(columns4)  # Add column titles
    for row4 in r4:
        ws.append(row4)

# Fourth Query

# Save the workbook to a file
wb.save("query_results.xlsx")
print("I risultati sono stati salvati in 'query_results.xlsx'.")
