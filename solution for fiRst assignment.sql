select		[User_Name],	Product_Name,		sum(ISNULL([Order],0)) as Ordered_Quantity,		sum(ISNULL(payment,0)) as Amount_Paid, 		FORMAT(MAX(Transaction_Date),'dd-MM-yyyy') as Last_Transaction_Date,		abs(sum(ISNULL([Order],0) * Cost_Per_Item ) - sum(IsNULL(payment,0)) ) as Balance
from (
	select 		t0.[User_ID],		[User_Name],		t0.Product_ID,		Product_Name,	Transaction_Date,		Transaction_Amount,		Transaction_Type,		Cost_Per_Item
	from t_transaction t0
	join  	t_product_master t2 	on 	t0.Product_ID = t2.Product_ID
	join	t_user_master t3	on	t0.[User_ID]= t3.[User_ID]
) t1
pivot(
	sum(Transaction_Amount)	for [Transaction_type] in ([Order], Payment)
)pv group by [User_ID],Product_ID,[User_Name],[Product_Name];

