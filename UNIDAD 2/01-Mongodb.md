# MongoDB CRUD

## Crear una base de datos  

#### Solo se crea si contiene por lo menos una coleccion


`json

use basede

`

## Crear una collecion

`use db1
db.createCollection ('Empleado')`

## Mostrar colecciiones
show collections

## Insercion de un documento
`
db.Empleado.insertOne(
    {
    nombre: 'Soyla',
    apellido: 'Vaca',
    edad: 32,
    ciudad: 'San Miguel de las Piedras'
    }
)`


# Insercion de un documento con complejo de Array

 json
db.Empleado.insertOne(

    {
    nombre: 'Ivan',
    apellido: 'Baltazar',
    apellido2: 'Rodriguez',
    aficiones: ['Cerveza', 'Canabis', 'Crico', 'Mentir'] 

    }
)


*Eliminar una coleccion*
json
db.collection.drop()

Ejemplo
json
db.Empleado.drop()


## Insercion de documentos mas complejos con documentos anidados, arrays y id's
json
        db.alumnos.insertOne(
        {
            nombre: 'Jose Luis',
            apellido1: 'Herrera',
            apellido2: 'Gallardo',
            edad: 41,
            estudios: [
                'Ingenieria en Sistemas Computacionales',
                'Maestria en Administracion de Tecnologias de la Informacion'
            ],
            experiencia: {
                lenguaje: 'SQL',
                sgb: 'SqlServer',
                anios_experiencia: 20
            }
        }
        
        )



## Generar un ID personalizado

json
    db.alumnos.insertOne({
        _id:3,
        nombre:'Sergio',
        apellido: 'Ramos',
        equipo: 'Monterrey',
        aficiones: ['Dinero','Hombres', 'Fiesta'],
        talentos:{
        futbol:true,
        bañarse:false
        }

    })


## Insertar Multiples  Documentos
 ###### "  LLAVES SIGNIFICAN DOCUMENTO"
json
    
    db.alumnos.insertMany(
    [
   
       {
        nombre: 'Osgualdo',
        apellido: 'Venado',
        edad: 20,
        descripcion: 'Es un quejumbroso'
        },
        {
            nombre: 'Maritza',
            apellido: 'Rechiken',
            edad: 19,
            habilidades: [
                'Ser Vivora', 'Ilusionar', 'Caguamear'
            ],
            direccion: {
                calle: 'Del infierno',
                numero: 666
            },
            esposos:[
                {
                    nombre: 'Joshua',
                    edad: 20,
                    pension: -34,
                    hijos:
                    ['Ivan', 'Jose']
                },
                {
                    nombre: 'Leo',
                    edad: 15,
                    pension: 70,
                    complaciente:true
                }
            ]
        }
    ]
    )


# Busquedas, Condiciones Simples de Igualdad Metodo Find


1. Seleccionar todos los documentos de la coleccion libros

json
    db.libros.find({})

2. Seleccionar todos los documentos que sean de la editorial biblio
json
    db.libros.find({editorial:'Biblio'})

3. Mostrar todos los documentos que el precio sea 25
json
    db.libros.find({precio:25})

4. seleccionar todos los documentos donde el titulo sea 
"Json para todos"
json
    db.libros.find({titulo: 'JSON para todos'})


### Operadores de comparacion
[Operaadores de Comparacion](https://www.mongodb.com/docs/manual/reference/operator/query/)

1-. Operadores Logicos
 ![Comparacion](../mongodb/imgu3/Operadores-Logicos.png)
2-. Operadores Relacionales
 ![Comparacion](../mongodb/imgu3/operadores-Relacionales.png)

1. mostrar todos los documentoas que sea mayor a 25
json
    db.libros.find({precio:{$gt:25}})


2. Mostrar los documentos donde el precio sea 25

json
    db.libros.find({precio:{$eq:25}})
    
    db.libros.find(precio:25)


3. mostrar los documentos cuya cantidad sea menor a 5
json
    db.libros.find({cantidad:{$lt:5}})

4. Mostrar los documentos que pertenecen a la editoria biblio o planeta
json
    db.libros.find({editorial: {$in: ['Biblio','Planeta']}})

5. mostrar todos los documentos de libros que muestren 20 o 25
json
 db.libros.find({precio: {$in: [20,25]}})
 
 6. recuperar todos los documentos que no cuesten 20 o 25
json
    db.libros.find({ precio: { $nin: [20, 25] } })



# *Instrucción Find One*

7. Recuperar solo una fila (Devuelve el primer elemento que cumpla la condicion, solo el primero)

json
 db.libros.findOne({precio: {$in: [20,25]}})
 

## Operadores Logicos
[Operadores Logicos](https://www.mongodb.com/docs/manual/reference/operator/query-logical/)

- Dos posibles Opciones

1. La simple, mediante condiciones por comas
    
    db.libros.find({condicion1,condicion2,..}) -> con esto asume que es un AND.

    Usando un Operador AND
    { $and: [ { <expression1> }, { <expression2> } , ... , { <expressionN> } ] }

    db.libros.find{ $and: [ {Condicion1},{Condicion2}]}

    1. Mostrar todos aquellos libros que cuesten mas de 25 y cuya cantidad sea inferior a 25
json
    db.libros.find(
        {
        precio:{$gt:25},
        cantidad:{$lt:15}
        }
    )


## forma 2
json
    db.libros.find(
        {
            $and:
            [
                {precio:{$gt:25}},
                {cantidad:{$lt:15}}
            ]
     
        }
    )


### Operador Or
- Mostrar  todos aquellos libros que cuesten mas de 12 o cuya cantidad sea inferior a 15 
``` json

db.libros.find(
{
$or:[
    { precio:{$gt: 25}

    },
    {
     cantidad:{$lt:15}   
    }
    
]
}
)

```


### ejemplo con AND y OR Combinados

- Mostrar los libros de la editorial biblio con precio mayor a 40 o libros de la editorial planeta con precio mayor a 30

bd.libros.find(
{
    $and:[
        {
            $ sor: [ {editorial:'biblio'}, {precio: {$gt:40}}] }, {or: [ {editorial: { $eq: 'planeta'}},{precio:{$gt:20}} ]}
            ]
        }
    
}

)

### PROYECCION (ver ciertas columnas)

**Sintaxis**

bd.coleccion.find (filtro, columnas)

1. Sleccionar todos los libros, solo mostrando el titulo
db.libros.find ({},{ titulo: 1})
db.libros.find ({},{ titulo: 1,_id:0})
db.libros.find(
    { editorial:'planeta' },
    {_id:0, titulo: 1, editorial: precio: 1}
)

### OPERARDOR EXIST ( este permite si un campo se encuentra o no en un documento)
[operador exists](https://www.mongodb.com/docs/manual/reference/operator/query/exists/)

{ field: { $exists: <boolean> } }

db.libros.find({editorial:{$exists:true}})

db.libros.insertOne(
    {
        _id:10,
        tiutlo: 'Mongo en Negocios Digitales',
        editorial: 'terra',
        precio: 125
    }
)

- Buscar todos los documentos que no tengan cantidad
db.libros.find({
    cantidad:{$exists:false}
})

### OPERADOR TYPE (permite solicitar a mongodb si un campo corresponde a un tipo)

[operador type](https://www.mongodb.com/docs/manual/reference/operator/query/type/)


-- Mostrar todos los documentos donde el precio sea de tipo double o entero o cualquier otro
tipo de dato

db.libros.find(
    {
        precio:{$type:1}
    }
)

db.libros.find(
    {
        precio:{$type:16}
    }
)

db.libros.find(
    {
        precio:{$type:'int'}
    }
)

db.libros.insertMany(
    [
        {
_id:12,
titulo:'IA',
editorial:'terra',
precio:125,
cantidad:20
    },
    {
        _id:13,
        titulo:'Python para todos',
        editorial:2001,
        precio:200,
        cantidad:30
    }
]    
)

- Selccionar todos los documentos de libros donde los valores de la editorial sean
--string

db.libros.find({editorial:{$type:2}})


}

)

# Modificando Documentos
## comando importante
1. updateOne -> Modifica un solo documento
2. UpDateMany -> Modificar Multiples documento
3. replaceOne -> Sustituir el contenido completo de un documento

Tiene el siguente formato


```json
bd.colelection.updateone(
{filtro},
{operador:}
)
```
[Operadores UpDate] https://www.mongodb.com/docs/manual/reference/operator/update/


*Operador $set**

1. Modificador un documento

``` json
bd.libros.updateone({titulo>'Phyton para todos'}, {$set:{titulo:'java para todos'}})
```

# Modificar el documento con id 10, estableciendo el precio en 100 y la cantidad en 50

db.libros.upadateone(
    {
      _id:10
    },
    {
        
        $set:{precio:100,cantidad:50}
    }
)


# utilizando el upadteMany, modificar todos los libros donde el precio sea mayor a 100 y
# cambiarlo por 150.

db.libros.upadateMany(
    {
        precio:{$gt:100}
    },
    {
        precio:150
    }
)


## Operadores $inc $mul

--Incrementar todos los precios de los libros en 5
``` json
db.libros.upadateMany(
{editorial: Terra},
{
    $inc:{precios:5}
}
)


-- Multiplcar todos los libos donde la cantidad sea mayor a 20
 en su cantidad por 2 ($mul)

 db.libros.updateMany(
{
   cantidad:{$gt:20}
},
{
  $mul:{precio:2}
}
)

-- Actualizar todos los libros multiplcados por 2 la cantidad y el precio de todos aquellos 
donde el precio sea mayor a 10

db.libros.updateMany(
{
   cantidad:{$gt:20}
},
{
  $mul:{cantidad:2, precio:2}
}
)

## Reemplazar documentos (RepleaceOne)


-- Actualizar todo el documento del id 2 por el titulo de la tierra a la
luna, autor julio verne, editorial tierra,precio 100




# Borrar documentos

1. deleteone -> elimina un solo documento
2. deleteMany -> elimina multiples documentos 

-- eliminar el documento con el id 2

``` json
bd.libros.deleteOne(
{ _id:2}
)

-- eliminar todos los libros donde la cantidad es mayor a 150



## expreciones regulares 

-- seleccionar todos los libros que en titulo terminen con tos

## operdaror $regex
## metodo sort (ordenar documentos)
## otros metodos skip, limit,size

bd.libros.detemanyone

bd.libros.find({}).limit(2)

bd.libros.find({})

#borrar colecciones y base de datos

db.libros.drop()
