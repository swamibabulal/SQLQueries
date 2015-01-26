
select * from t_emp;
select (Emp_f_name+ ' '+Emp_m_name+ ' ' + Emp_l_name) as Name, Emp_DOB as Date_Of_Birth from t_emp where  DAY(dateadd(day,1,Emp_DOB))= 1;
