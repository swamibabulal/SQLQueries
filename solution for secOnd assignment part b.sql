SELECT  
	isnull(t3.Emp_f_name,'')+' '+isnull(t3.Emp_m_name,'')+ ' ' +isnull(t3.Emp_l_name,'') as FullName,
	case when [1]-[2]>0 then 'Yes'
		else 'No'
	end as SalaryIncrement,
	ISNULL([2],0) as PreviousSalary,
	[1] as CurrentSalary,
	t1.totalhours,t4.Activity_description, t2.Atten_end_hrs
FROM(
select 
	ROW_NUMBER() over(partition by emp_id order by changed_date desc) as rno
	,New_Salary,Emp_id
from
	t_salary
)T0
pivot
(
sum(t0.new_salary)
for t0.rno in([2],[1])
)as s 
join
(select
	sum(Atten_end_hrs) as totalhours,
	emp_id,
	max(atten_start_Datetime) as start
from 
	t_atten_det
group by emp_id
)t1
on s.Emp_id=t1.Emp_id
join t_atten_det t2
on
	t1.Emp_id=t2.Emp_id and t1.start=t2.Atten_start_datetime
join 
	t_emp t3
on
	t3.Emp_id=t2.Emp_id
join t_activity t4
on
	t4.Activity_id = t2.Activity_id;
