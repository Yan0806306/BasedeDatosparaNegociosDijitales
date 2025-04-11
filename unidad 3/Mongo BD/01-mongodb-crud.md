---

# 🟢 **MongoDB CRUD**

## 📁 Crear una base de datos

> ⚠️ *Una base de datos solo se crea si contiene al menos una colección.*

```js
use basededatos
```

## 📂 Mostrar bases de datos existentes

```js
show dbs
```

---

## 📂 Crear una colección

```js
use bd1
db.createCollection('Empleado')
```

---

## 📋 Mostrar colecciones dentro de una base de datos

```js
show collections
```

---

## 📝 Insertar un documento

```js
db.Empleado.insertOne({
  nombre: 'Soyla',
  apellido: 'Vaca',
  edad: 32,
  ciudad: 'San Miguel de las Piedras'
})
```

---

## 🧩 Insertar un documento con arrays

```js
db.Empleado.insertOne({
  nombre: 'Iván',
  apellido: 'Vasaltar',
  aficion: ['Cerveza', 'Cannabis', 'Penes', 'Mentir']
})
```

> ⚠️ **Nota:** No puedes repetir campos con el mismo nombre dentro de un mismo documento. Si lo haces, solo se conservará el último.

---

## ❌ Eliminar una colección

```js
db.nombreColeccion.drop()
```

### Ejemplo:

```js
db.ejemplo.drop()
```

---

## 🧠 Insertar documento con estructuras anidadas y arrays

```js
db.alumno.insertOne({
  nombre: 'José Luis',
  apellido1: 'Herrera',
  apellido2: 'Gallardo',
  edad: 41,
  estudios: [
    'Ingeniería en Sistemas Computacionales',
    'Maestría en Administración de Tecnologías de Información'
  ],
  experiencia: [
    {
      lenguaje: 'SQL',
      SGBD: 'SQL Server',
      añosExperiencia: 20
    }
  ]
})
```

---

## 🆔 Insertar documento con ID personalizado

```js
db.alumno.insertOne({
  _id: 3,
  nombre: 'Sergio',
  apellido1: 'Ramos',
  equipo: 'Monterrey',
  aficiones: ['Dinero', 'Hombres', 'Fiesta'],
  talentos: {
    futbol: true,
    bañarse: false
  }
})
```

---

## 📄 Insertar múltiples documentos

```js
db.alumno.insertMany([
  {
    _id: 12,
    nombre: 'Oswaldo',
    apellido: 'Venado',
    edad: 20
  },
  {
    nombre: 'Maritza',
    apellido: 'Rechicken',
    edad: 21,
    habilidades: ['Ser víbora', 'Ilusionar', 'Caguamear'],
    direccion: {
      calle: 'Del Infierno',
      numero: 666
    },
    esposos: [
      {
        nombre: 'Joshua',
        edad: 20,
        pension: -34,
        hijos: ['Iván', 'José']
      },
      {
        nombre: 'Leo',
        edad: 20,
        pension: 100,
        hijos: ['Carlos', 'Ramón'],
        complaciente: true
      }
    ]
  }
])
```

> 💡 **Dato:** Todo lo que esté entre `{}` se considera un documento.  

---

# 🔎 Búsquedas y condiciones simples

## 📚 Método `find()`

### 1. Seleccionar todos los documentos de la colección `libros`

```js
db.libros.find({})
```

### 2. Buscar por editorial

```js
db.libros.find({ editorial: 'biblio' })
```

### 3. Buscar por precio

```js
db.libros.find({ precio: 25 })
```

### 4. Buscar por título exacto

```js
db.libros.find({ titulo: 'JSON para todos' })
```

---

## ⚖️ Operadores de comparación

🔗 [Referencia oficial de operadores](https://www.mongodb.com/docs/manual/reference/operator/query/)

### Ejemplos:

- Precio mayor a 25

```js
db.libros.find({ precio: { $gt: 25 } })
```

- Precio igual a 25

```js
db.libros.find({ precio: { $eq: 25 } })
```

- Cantidad menor a 5

```js
db.libros.find({ cantidad: { $lt: 5 } })
```

- Editorial sea *biblio* o *planeta*

```js
db.libros.find({ editorial: { $in: ['biblio', 'planeta'] } })
```

- Precio sea 20 o 25

```js
db.libros.find({ precio: { $in: [20, 25] } })
```

- Precio distinto a 20 o 25

```js
db.libros.find({ precio: { $nin: [20, 25] } })
```

---

## 🔗 Operadores lógicos

🔗 [Referencia oficial de operadores lógicos](https://www.mongodb.com/docs/manual/reference/operator/query-logical/)

### `$or`: Libros con precio mayor a 25 **o** cantidad menor a 15

```js
db.libros.find({
  $or: [
    { precio: { $gt: 25 } },
    { cantidad: { $lt: 15 } }
  ]
})
```

### `$and` + `$or`: Combinación de condiciones

```js
db.libros.find({
  $and: [
    {
      $or: [
        { editorial: 'Biblio' },
        { precio: { $gt: 40 } }
      ]
    },
    {
      $or: [
        { editorial: 'Planeta' },
        { precio: { $gt: 30 } }
      ]
    }
  ]
})
```

---

## 🔍 Proyección (mostrar solo ciertos campos)

> Sintaxis: `db.coleccion.find(filtro, camposAMostrar)`

### Mostrar solo el título (sin `_id`):

```js
db.libros.find({}, {
  titulo: 1,
  _id: 0
})
```

### Otro ejemplo con más campos:

```js
db.getCollection('libros').find(
  { editorial: 'Planeta' },
  { _id: 0, titulo: 1, editorial: 1, precio: 1 }
)
```
---

# 📦 **Consultas avanzadas, actualizaciones y borrado en MongoDB**

---

## 📦 Operador `$exists`

> Verifica si un campo **existe** o **no existe** en los documentos.

### Buscar documentos donde el campo `cantidad` **existe**:

```js
db.libros.find({
  cantidad: { $exists: true }
})
```

### Buscar documentos donde el campo `cantidad` **no existe**:

```js
db.libros.find({
  cantidad: { $exists: false }
})
```

---

## 🔍 Operador `$type`

> Permite buscar documentos en función del tipo de dato de un campo.

🔗 [Referencia oficial del operador `$type`](https://www.mongodb.com/docs/manual/reference/operator/query/type/)

### Buscar documentos donde `precio` sea de tipo entero (16):

```js
db.libros.find({
  precio: { $type: 16 }
})
```

### Insertar documentos con diferentes tipos:

```js
db.libros.insertMany([
  {
    _id: 12,
    titulo: 'IA',
    editorial: 'Terra',
    precio: 125,
    cantidad: 20
  },
  {
    _id: 13,
    titulo: 'Python para todos',
    editorial: 2001, // tipo número
    precio: 200,
    cantidad: 30
  }
])
```

### Buscar documentos donde `editorial` sea de tipo **string**:

```js
db.libros.find({
  editorial: { $type: 2 }
})
```

### Buscar documentos donde `editorial` sea de tipo **entero**:

```js
db.libros.find({
  editorial: { $type: 16 }
})
```

---

## 🛠️ Modificar documentos

### Comandos principales

1. `updateOne()` – Modifica un solo documento.  
2. `updateMany()` – Modifica múltiples documentos.  
3. `replaceOne()` – Reemplaza completamente un documento.

🔗 [Operadores de actualización](https://www.mongodb.com/docs/manual/reference/operator/update/)

---

### ✅ Usando `$set` para actualizar campos

Modificar un campo específico:

```js
db.libros.updateOne(
  { titulo: 'Python para todos' },
  { $set: { titulo: 'Java para todos' } }
)
```

Modificar el documento con `_id: 10`, estableciendo `precio` y `cantidad` en 50:

```js
db.libros.updateOne(
  { _id: 10 },
  { $set: { precio: 50, cantidad: 50 } }
)
```

---

### 🔢 Multiplicar valores con `$mul`

Multiplicar por 2 el precio y cantidad de todos los libros donde el precio sea mayor a 20:

```js
db.libros.updateMany(
  { precio: { $gt: 20 } },
  { $mul: { precio: 2, cantidad: 2 } }
)
```

---

## 🔁 Reemplazar documento (`replaceOne`)

Reemplazar completamente el documento con `_id: 2`:

```js
db.libros.replaceOne(
  { _id: 2 },
  {
    _id: 2,
    titulo: 'De la Tierra a la Luna',
    autor: 'Julio Verne',
    editorial: 'Terra',
    precio: 100
  }
)
```

---

## 🗑️ Eliminar documentos

### 1. Eliminar un solo documento (`deleteOne`)

Eliminar el documento con `_id: 2`:

```js
db.libros.deleteOne({ _id: 2 })
```

### 2. Eliminar varios documentos (`deleteMany`)

Eliminar todos los documentos donde la `cantidad` sea mayor a 150:

```js
db.libros.deleteMany({
  cantidad: { $gt: 150 }
})
```

---

## 🔎 Expresiones Regulares (`$regex`)

🔗 [Referencia oficial de `$regex`](https://www.mongodb.com/docs/manual/reference/operator/query/regex/)

### Buscar títulos que contengan una "t" minúscula:

```js
db.libros.find({
  titulo: /t/
})
```

### Buscar títulos que contengan la palabra "json" (sin importar mayúsculas):

```js
db.libros.find({
  titulo: { $regex: /json/i }
})
```

### Buscar títulos que terminen con "tos":

```js
db.libros.find({
  titulo: /tos$/
})
```

### Buscar títulos que comiencen con "j":

```js
db.libros.find({
  titulo: /^j/i
})
```

---

## 🔃 Ordenar documentos (`sort()`)

### Ordenar por precio ascendente:

```js
db.libros.find(
  {},
  { _id: 0, titulo: 1, precio: 1 }
).sort({ precio: 1 })
```

### Ordenar por precio descendente:

```js
db.libros.find(
  {},
  { _id: 0, titulo: 1, precio: 1 }
).sort({ precio: -1 })
```

### Ordenar por editorial (ascendente) y precio (descendente):

```js
db.libros.find(
  {},
  { _id: 0, titulo: 1, editorial: 1, precio: 1 }
).sort({ editorial: 1, precio: -1 })
```

---

## 🧮 Otros métodos útiles

### `limit()` – Limitar la cantidad de resultados

Mostrar solo los **2 primeros** libros:

```js
db.libros.find({}).limit(2)
```

### `skip()` – Omitir documentos

Omitir los **2 primeros** documentos y mostrar el resto:

```js
db.libros.find({}).skip(2)
```

---

## 🧨 Eliminar una colección

```js
db.libros.drop()
db.productos.drop()
```

---

---

# 🟢 **MongoDB CRUD**

## 📁 Crear una base de datos

> ⚠️ *Una base de datos solo se crea si contiene al menos una colección.*

```js
use basededatos
```

## 📂 Mostrar bases de datos existentes

```js
show dbs
```

---

## 📂 Crear una colección

```js
use bd1
db.createCollection('Empleado')
```

---

## 📋 Mostrar colecciones dentro de una base de datos

```js
show collections
```

---

## 📝 Insertar un documento

```js
db.Empleado.insertOne({
  nombre: 'Soyla',
  apellido: 'Vaca',
  edad: 32,
  ciudad: 'San Miguel de las Piedras'
})
```

---

## 🧩 Insertar un documento con arrays

```js
db.Empleado.insertOne({
  nombre: 'Iván',
  apellido: 'Vasaltar',
  aficion: ['Cerveza', 'Cannabis', 'Penes', 'Mentir']
})
```

> ⚠️ **Nota:** No puedes repetir campos con el mismo nombre dentro de un mismo documento. Si lo haces, solo se conservará el último.

---

## ❌ Eliminar una colección

```js
db.nombreColeccion.drop()
```

### Ejemplo:

```js
db.ejemplo.drop()
```

---

## 🧠 Insertar documento con estructuras anidadas y arrays

```js
db.alumno.insertOne({
  nombre: 'José Luis',
  apellido1: 'Herrera',
  apellido2: 'Gallardo',
  edad: 41,
  estudios: [
    'Ingeniería en Sistemas Computacionales',
    'Maestría en Administración de Tecnologías de Información'
  ],
  experiencia: [
    {
      lenguaje: 'SQL',
      SGBD: 'SQL Server',
      añosExperiencia: 20
    }
  ]
})
```

---

## 🆔 Insertar documento con ID personalizado

```js
db.alumno.insertOne({
  _id: 3,
  nombre: 'Sergio',
  apellido1: 'Ramos',
  equipo: 'Monterrey',
  aficiones: ['Dinero', 'Hombres', 'Fiesta'],
  talentos: {
    futbol: true,
    bañarse: false
  }
})
```

---

## 📄 Insertar múltiples documentos

```js
db.alumno.insertMany([
  {
    _id: 12,
    nombre: 'Oswaldo',
    apellido: 'Venado',
    edad: 20
  },
  {
    nombre: 'Maritza',
    apellido: 'Rechicken',
    edad: 21,
    habilidades: ['Ser víbora', 'Ilusionar', 'Caguamear'],
    direccion: {
      calle: 'Del Infierno',
      numero: 666
    },
    esposos: [
      {
        nombre: 'Joshua',
        edad: 20,
        pension: -34,
        hijos: ['Iván', 'José']
      },
      {
        nombre: 'Leo',
        edad: 20,
        pension: 100,
        hijos: ['Carlos', 'Ramón'],
        complaciente: true
      }
    ]
  }
])
```

> 💡 **Dato:** Todo lo que esté entre `{}` se considera un documento.  

---

# 🔎 Búsquedas y condiciones simples

## 📚 Método `find()`

### 1. Seleccionar todos los documentos de la colección `libros`

```js
db.libros.find({})
```

### 2. Buscar por editorial

```js
db.libros.find({ editorial: 'biblio' })
```

### 3. Buscar por precio

```js
db.libros.find({ precio: 25 })
```

### 4. Buscar por título exacto

```js
db.libros.find({ titulo: 'JSON para todos' })
```

---

## ⚖️ Operadores de comparación

🔗 [Referencia oficial de operadores](https://www.mongodb.com/docs/manual/reference/operator/query/)

### Ejemplos:

- Precio mayor a 25

```js
db.libros.find({ precio: { $gt: 25 } })
```

- Precio igual a 25

```js
db.libros.find({ precio: { $eq: 25 } })
```

- Cantidad menor a 5

```js
db.libros.find({ cantidad: { $lt: 5 } })
```

- Editorial sea *biblio* o *planeta*

```js
db.libros.find({ editorial: { $in: ['biblio', 'planeta'] } })
```

- Precio sea 20 o 25

```js
db.libros.find({ precio: { $in: [20, 25] } })
```

- Precio distinto a 20 o 25

```js
db.libros.find({ precio: { $nin: [20, 25] } })
```

---

## 🔗 Operadores lógicos

🔗 [Referencia oficial de operadores lógicos](https://www.mongodb.com/docs/manual/reference/operator/query-logical/)

### `$or`: Libros con precio mayor a 25 **o** cantidad menor a 15

```js
db.libros.find({
  $or: [
    { precio: { $gt: 25 } },
    { cantidad: { $lt: 15 } }
  ]
})
```

### `$and` + `$or`: Combinación de condiciones

```js
db.libros.find({
  $and: [
    {
      $or: [
        { editorial: 'Biblio' },
        { precio: { $gt: 40 } }
      ]
    },
    {
      $or: [
        { editorial: 'Planeta' },
        { precio: { $gt: 30 } }
      ]
    }
  ]
})
```

---

## 🔍 Proyección (mostrar solo ciertos campos)

> Sintaxis: `db.coleccion.find(filtro, camposAMostrar)`

### Mostrar solo el título (sin `_id`):

```js
db.libros.find({}, {
  titulo: 1,
  _id: 0
})
```

### Otro ejemplo con más campos:

```js
db.getCollection('libros').find(
  { editorial: 'Planeta' },
  { _id: 0, titulo: 1, editorial: 1, precio: 1 }
)
```
---

# 📦 **Consultas avanzadas, actualizaciones y borrado en MongoDB**

---

## 📦 Operador `$exists`

> Verifica si un campo **existe** o **no existe** en los documentos.

### Buscar documentos donde el campo `cantidad` **existe**:

```js
db.libros.find({
  cantidad: { $exists: true }
})
```

### Buscar documentos donde el campo `cantidad` **no existe**:

```js
db.libros.find({
  cantidad: { $exists: false }
})
```

---

## 🔍 Operador `$type`

> Permite buscar documentos en función del tipo de dato de un campo.

🔗 [Referencia oficial del operador `$type`](https://www.mongodb.com/docs/manual/reference/operator/query/type/)

### Buscar documentos donde `precio` sea de tipo entero (16):

```js
db.libros.find({
  precio: { $type: 16 }
})
```

### Insertar documentos con diferentes tipos:

```js
db.libros.insertMany([
  {
    _id: 12,
    titulo: 'IA',
    editorial: 'Terra',
    precio: 125,
    cantidad: 20
  },
  {
    _id: 13,
    titulo: 'Python para todos',
    editorial: 2001, // tipo número
    precio: 200,
    cantidad: 30
  }
])
```

### Buscar documentos donde `editorial` sea de tipo **string**:

```js
db.libros.find({
  editorial: { $type: 2 }
})
```

### Buscar documentos donde `editorial` sea de tipo **entero**:

```js
db.libros.find({
  editorial: { $type: 16 }
})
```

---

## 🛠️ Modificar documentos

### Comandos principales

1. `updateOne()` – Modifica un solo documento.  
2. `updateMany()` – Modifica múltiples documentos.  
3. `replaceOne()` – Reemplaza completamente un documento.

🔗 [Operadores de actualización](https://www.mongodb.com/docs/manual/reference/operator/update/)

---

### ✅ Usando `$set` para actualizar campos

Modificar un campo específico:

```js
db.libros.updateOne(
  { titulo: 'Python para todos' },
  { $set: { titulo: 'Java para todos' } }
)
```

Modificar el documento con `_id: 10`, estableciendo `precio` y `cantidad` en 50:

```js
db.libros.updateOne(
  { _id: 10 },
  { $set: { precio: 50, cantidad: 50 } }
)
```

---

### 🔢 Multiplicar valores con `$mul`

Multiplicar por 2 el precio y cantidad de todos los libros donde el precio sea mayor a 20:

```js
db.libros.updateMany(
  { precio: { $gt: 20 } },
  { $mul: { precio: 2, cantidad: 2 } }
)
```

---

## 🔁 Reemplazar documento (`replaceOne`)

Reemplazar completamente el documento con `_id: 2`:

```js
db.libros.replaceOne(
  { _id: 2 },
  {
    _id: 2,
    titulo: 'De la Tierra a la Luna',
    autor: 'Julio Verne',
    editorial: 'Terra',
    precio: 100
  }
)
```

---

## 🗑️ Eliminar documentos

### 1. Eliminar un solo documento (`deleteOne`)

Eliminar el documento con `_id: 2`:

```js
db.libros.deleteOne({ _id: 2 })
```

### 2. Eliminar varios documentos (`deleteMany`)

Eliminar todos los documentos donde la `cantidad` sea mayor a 150:

```js
db.libros.deleteMany({
  cantidad: { $gt: 150 }
})
```

---

## 🔎 Expresiones Regulares (`$regex`)

🔗 [Referencia oficial de `$regex`](https://www.mongodb.com/docs/manual/reference/operator/query/regex/)

### Buscar títulos que contengan una "t" minúscula:

```js
db.libros.find({
  titulo: /t/
})
```

### Buscar títulos que contengan la palabra "json" (sin importar mayúsculas):

```js
db.libros.find({
  titulo: { $regex: /json/i }
})
```

### Buscar títulos que terminen con "tos":

```js
db.libros.find({
  titulo: /tos$/
})
```

### Buscar títulos que comiencen con "j":

```js
db.libros.find({
  titulo: /^j/i
})
```

---

## 🔃 Ordenar documentos (`sort()`)

### Ordenar por precio ascendente:

```js
db.libros.find(
  {},
  { _id: 0, titulo: 1, precio: 1 }
).sort({ precio: 1 })
```

### Ordenar por precio descendente:

```js
db.libros.find(
  {},
  { _id: 0, titulo: 1, precio: 1 }
).sort({ precio: -1 })
```

### Ordenar por editorial (ascendente) y precio (descendente):

```js
db.libros.find(
  {},
  { _id: 0, titulo: 1, editorial: 1, precio: 1 }
).sort({ editorial: 1, precio: -1 })
```

---

## 🧮 Otros métodos útiles

### `limit()` – Limitar la cantidad de resultados

Mostrar solo los **2 primeros** libros:

```js
db.libros.find({}).limit(2)
```

### `skip()` – Omitir documentos

Omitir los **2 primeros** documentos y mostrar el resto:

```js
db.libros.find({}).skip(2)
```

---

## 🧨 Eliminar una colección

```js
db.libros.drop()
db.productos.drop()
```

---