use BDEJEMPLO2


--REALIZAR UN TRIGER QUE SE DISPARE CUANDO SE INSERTA UN PEDIDO
--Y MODIFIQUE EL STORE DEL PRODUCTO VENDIDO, VERIFICAR SI HAY SUFICIENTE STOCK SUFICIENTE SI NO 
--SE CAnCELA EL PRODUCTO

SELECT * FROM Pedidos

create or alter trigger tg_pedidos_insertar
on pedidos
after insert
as 
begin

declare @existencia int
declare @fab char (3)
declare @prod char(5)
declare @cantidad int

select @fab = fab, @prod = Producto,
@cantidad = cantidad
from inserted

select @existencia = stock from Productos
where Id_fab = @fab and Id_producto = @prod

if @existencia> (select cantidad from inserted)
begin 
update Productos
set Stock =Stock - @cantidad
where Id_fab = @fab and Id_producto = @prod;

end
else
begin

  raiserror ('Np hay suficiente stock para el pedido',16,1)
  rollback;
  end

end;
 

--nuevo

select * from Pedidos
select  MAX (num_pedido) from Pedidos
select * from Productos

declare @importe money
	select @importe = (p.Cantidad * pr.Precio)
	from Pedidos as p
	inner join Productos as pr
	on p.Fab = pr.Id_fab
	and p.Producto = pr.Id_producto
	insert into Pedidos (Num_Pedido,Fecha_Pedido,Cliente,Rep,Fab,Producto,Cantidad,Importe)
	values (113071, GETDATE(),2103,106,'ACI', '41001',77,@importe )


	select * from Productos
	where Id_fab = 'ACI'
	and Id_producto ='41001'

	select * from Pedidos 
	where Num_Pedido = 113071

	--crear un trigger que cada vez que se elimine un pedido se debe actualizar el stock
	--de los productos con la cantidad eliminada.




