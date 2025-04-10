import pymongo
from pymongo import MongoClient

# Conexión a la base de datos MongoDB
client = MongoClient('mongodb://localhost:27017/')


# Selección de la base de datos
db = client['MongoDB']
collection = db['ex_studenti']

# Realiza una operación de prueba para verificar la conexión
try:
    client.admin.command('ping')
    print("Conexión exitosa a MongoDB")
except Exception as e:
    print("Error al conectar a MongoDB:", e)

"""https://github.com/ozlerhakan/mongodb-json-files/blob/master/datasets/students.json"""