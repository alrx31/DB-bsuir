select * from user_ u where u.produceruserid is null


select * from dream d where d.price < 25


select * from "role"

select * from payment p where p.orderid  = 'c219a71c-a74f-4396-bda5-84e0e7b5c521'


select * from review r where userid = '0b6ad028-8582-432b-af34-e83f090760a4'

select * from dreamcategory d 
 
select 
	o.userid ,
	d.title ,
	d.price ,
	xref.count 
from order_ o 
join orderdreamxref xref on o.orderid = xref.orderId
join dream d  on xref.dreamid = d.dreamid 
where o.orderid = '56002ce6-b61b-44b1-bf8e-6456a173d076'


select * from producer p 

select p.title ,pu.secretkey , u."name" 
from produceruser pu
join producer p on p.producerid = pu.producerid 
join user_ u on pu.produceruserid = u.produceruserid 
where p.title = 'Lucid Labs'


select p.producerid, d.title, d.price from dream d 
join producer p on d.producerid  = p.producerid 
where p.title  = 'Lucid Labs'
