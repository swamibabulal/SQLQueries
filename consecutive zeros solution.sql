
select top 1 count(*) as Max_Consecutives from
(
	select	*, id - row_number() over (order by status, id) as rno
	from	t_assign t0
)t1 where status=0
group by rno order by count(*) desc;


