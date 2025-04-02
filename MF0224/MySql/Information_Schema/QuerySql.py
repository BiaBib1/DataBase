from openpyxl import Workbook
import mariadb

# Connect to the database information_schema
db = mariadb.connect(
    host="localhost",
    user="root",
    password="****",
    database="information_schema"
)

# Function to execute a query and return the results
def execute_query(connection, query):
    cursor = connection.cursor()
    cursor.execute(query)
    return cursor.fetchall(), [desc[0] for desc in cursor.description]  
# Return data and column names

# Create a new Excel with results from the querys
wb = Workbook()
ws = wb.active
ws.title = "Query Results"

# 1)  First Query: Lista todas las tablas de la base de datos
""" SELECT las columnas de la tabla COLUMNS, que contiene información
sobre las columnas de las tablas más relevantes en la base de datos 
FROM la tabla COLUMNS, utilizando c como alias para referirse a ella
WHERE para filtrar los resultados por el esquema de la base de datos 'sakila' """

q1 = "SELECT c.`TABLE_NAME`, c.`COLUMN_NAME`, c.DATA_TYPE, c.CHARACTER_SET_NAME, " \
    "c.COLUMN_TYPE, c.COLUMN_KEY, c.EXTRA, c.`PRIVILEGES` " \
    "FROM COLUMNS c " \
    "WHERE table_schema = 'sakila'"

r1, columns1 = execute_query(db, q1)
if r1:
    ws.append(["1. TODAS LAS TABLAS"])  # Add a Title to the Head
    ws.append(columns1)  # Add column titles
    for row in r1:
        ws.append(row)  # Add each row to the Excel sheet


# 2)  Second Query: Obtén las columnas y tipos de datos de cada tabla.
""" JOIN para unir las tablas TABLES y COLUMNS, y obtener las informaciones con SELECT"""
q2 = "SELECT t.TABLE_NAME, t.TABLE_TYPE, c.`COLUMN_NAME`, c.DATA_TYPE " \
     "FROM `TABLES` t " \
     "JOIN COLUMNS c ON c.`TABLE_NAME`= t.`TABLE_NAME` " \
     "WHERE t.table_schema = 'sakila';"

r2, columns2 = execute_query(db, q2)
if r2:
    ws.append([])  # Add an empty row for separation
    ws.append([])
    ws.append(["2. COLUMNAS Y TIPO DE DATOS"])  # Add a Title to the Head
    ws.append(columns2)  # Add column titles
    for row2 in r2:
        ws.append(row2)  # Add each row to the Excel sheet


# 3)  Third Query: Identifica las claves primarias y foráneas de la base de datos.
""" FROM KEY_COLUMN_USAGE, que contiene información sobre las claves primarias y foráneas"""
q3 = "SELECT k.`TABLE_NAME`, k.`COLUMN_NAME`, k.`CONSTRAINT_NAME`, " \
    "k.REFERENCED_TABLE_NAME, k.REFERENCED_COLUMN_NAME " \
    "FROM KEY_COLUMN_USAGE k " \
    "WHERE k.TABLE_SCHEMA = 'sakila' " \
    "ORDER BY k.`CONSTRAINT_NAME`;"

#  Cuentas de las claves por tipo
""" COUNT funcion para contar el número de claves primarias y foráneas en la base de datos
GROUP BY para agrupar los resultados por el tipo de clave y ORDER BY para ordenar los resultados """
q3_1 = "SELECT tc.CONSTRAINT_TYPE, COUNT(*) AS Keys_Number " \
    "FROM TABLE_CONSTRAINTS tc " \
    "WHERE tc.TABLE_SCHEMA = 'sakila' " \
    "GROUP BY tc.CONSTRAINT_TYPE " \
    "ORDER BY Keys_Number DESC;"

r3, columns3 = execute_query(db, q3)
r3_1, columns3_1 = execute_query(db, q3_1)
if r3 and r3_1:
    ws.append([])  # Add an empty row for separation
    ws.append([])
    ws.append(["3. CLAVES PRIMARIAS Y FORÁNEAS"])  # Add a Title to the Head
    ws.append(columns3)  # Add column titles
    for row3 in r3:
        ws.append(row3)  # Add each row to the Excel sheet
    ws.append([])  # Add an empty row for separation
    ws.append(["3.1 CUENTAS DE LAS CLAVES"])  # Add a Title to the Head
    ws.append(columns3_1)  # Add column titles
    for row3_1 in r3_1:
        ws.append(row3_1)  # Add each row to the Excel sheet


# 4)  Fourth Query: Examina las vistas... 
""" SELECT las columnas de la tabla VIEWS, que contiene información sobre las vistas """
q4 = "SELECT v.TABLE_SCHEMA, v.`TABLE_NAME`" \
    "FROM VIEWS  v " \
    "WHERE TABLE_SCHEMA = 'sakila';" 

#  Numero Total de las vistas
""" COUNT funcion para contar el número de vistas en la base de datos
AS es el alias para identificar el resultado de la suma producida por COUNT. """
q4_1 = "SELECT v.TABLE_SCHEMA, COUNT(*) AS total_vistas " \
    "FROM VIEWS v " \
    "WHERE TABLE_SCHEMA = 'sakila';"

r4, columns4 = execute_query(db, q4)
r4_1, columns4_1 = execute_query(db, q4_1)
if r4 and r4_1:
    ws.append([])  # Add an empty row for separation
    ws.append([])
    ws.append(["4. VISTAS"])  # Add a Title to the Head
    ws.append(columns4)  # Add column titles
    for row4 in r4:
        ws.append(row4)  # Add each row to the Excel sheet
    ws.append([])  # Add an empty row for separationS
    ws.append(["4.1 TOTAL VISTAS"])  # Add a Title to the Head
    ws.append(columns4_1)  # Add column titles
    for row4_1 in r4_1:
        ws.append(row4_1)  # Add each row to the Excel sheet


# 5)  Fifth Query: ...y procedimientos almacenados, si existen
""" SELECT las columnas de la tabla ROUTINES, que contiene información sobre los procedimientos almacenados """
q5 = "SELECT r.ROUTINE_SCHEMA, r.SPECIFIC_NAME, r.ROUTINE_NAME, r.ROUTINE_TYPE " \
    "FROM ROUTINES r " \
    "WHERE r.ROUTINE_SCHEMA = 'sakila';"

#  Numero Total de los procedimientos almacenados
""" COUNT funcion para contar el número de procedimientos almacenados en la base de datos """
q5_1 = "SELECT r.ROUTINE_SCHEMA, COUNT(*) AS Tot_rutines " \
    "FROM ROUTINES r " \
    "WHERE r.ROUTINE_SCHEMA = 'sakila';"

r5, columns5 = execute_query(db, q5)
r5_1, columns5_1 = execute_query(db, q5_1)
if r5 and r5_1:
    ws.append([])  # Add an empty row for separation
    ws.append([])
    ws.append(["5. PROCEDIMIENTOS ALMACENADOS"])  # Add a Title to the Head
    ws.append(columns5)  # Add column titles
    for row5 in r5:
        ws.append(row5)  # Add each row to the Excel sheet
    ws.append([])  # Add an empty row for separation
    ws.append(["5.1 TOTAL PROCEDIMIENTOS ALMACENADOS"])  # Add a Title to the Head
    ws.append(columns5_1)  # Add column titles
    for row5_1 in r5_1:
        ws.append(row5_1)  # Add each row to the Excel sheet

#Creation and customization of cells in the .xlsx file
for col in ws.columns:
    max_length = 0
    col_letter = col[0].column_letter  # Get the column letter
    for cell in col:
        if cell.value:  # Check if the cell has a value
            max_length = max(max_length, len(str(cell.value)))
    ws.column_dimensions[col_letter].width = max_length + 2  # Add some extra space

# Save the Analysis to a file
wb.save("Analysis_results.xlsx")
print("Los resultados serán guardados en 'Analysis_results.xlsx'.")
