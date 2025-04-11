# MongoDB Crud

## Crear una base de datos 

*Solo se crea si contiene por lo menos una coleccion*

json
use basededatos

## Crear una coleccion
`use bd1
db.createCollection('Empleado')`

## Mostrar collecciones 
show collections

## Insercion de un documento 
db.Empleado.insertOne(
  {
      nombre:'Soyla',
      apellido: 'Vaca',
      edad: 32,
      cuidad: 'San Miguel de las Piedras'
  }
)

## Insercion de un documento mas complejo con array 

json 
db.Empleado.insertOne({
   nombre: 'Ivan',
   apellido:'Baltazar',
   apellodo2: 'Rodriguez',
   aficiones:['Cerveza', 'Canabis', 'Crico','Mentir']
})


## Eliminar una coleccion **
json
db.coleccion.drop()

_Ejemplo_
json 
db.empleado.drop()


## Entrar a la base de datos 
use db1

## insercion de documentos mas complejos con anidados, arrays y ID 
json
db.alumnos.insertOne(
{
  nombre:'Jose Luis',
  apellido1:'Herrera',
  apellido2: 'Gallardo',
  edad: '41',
  estudios:[
    'Ingenieria en sistemas computacionales',
    'Maestria en administracion de tencologias de informacion'
  ],
 experiencias: {
         lenguaje:'SQL', 
         sgb : 'sqlServer',
         anios_Experiencias: 20
  }
}
)

json
db.alumnos.insertOne({
   _id:3,
   nombre:'Sergio',
   apellido:'Ramos',
   equipo:'Monterrey',
   aficiones:['Dinero','Hombres','Fiesta'],
   talentos:{
    futbol:true,
    banarse: false
   }
})
## insertar multiples documentos
``` json
bd.alumnos.ins
