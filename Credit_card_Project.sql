--To Create New Column in Customer Table
alter table customer
add column age_group varchar

--Inserting Data into Column Age Group 
update customer
set age_group = 
case
when customer_age < 30 then '20-30'
when customer_age >= 30 and customer_Age < 40 then '30-40'
when customer_age >= 40 and customer_Age < 50 then '40-50'
when customer_Age >= 50 and customer_age < 60 then '50-60'
else '60+'
end

select * from customer

--Creating Income Group in Customer Table

alter table customer
add column income_group varchar

---Inserting Data into Income_group
update customer
set income_group = 
case
when income < 35000 then 'upto 35K'
when income >= 35000 and income < 70000 then '35K-70K'
when income >= 70000 then '70K+'
else 'unknown'
end

select * from customer

--Creating Revenue Column in Credit_card Table

select * from credit_card

alter table credit_card 
add column Revenue numeric

update credit_card
set Revenue = annual_fees+total_trns_amt+int_earn ---Annual_fees + Total_transaction_amount + Intrest_Earned

select * from credit_card
--Add Week Column in Credit Card Table
alter table credit_card
	add Column Week integer
	
--Inserting Data into Week Column Credit_card Table	
	update credit_card
	set Week =  substring(week_num , 6)::integer 

select* from credit_card

--Weekly Revenue Increasing Percentage 
	---Creating Revenue Analysis Table
create table revenue_analysis as
with cte as
(select week ,sum(revenue) current_revenue
	from credit_card 
group by week
order by week ),
final as 	
(select week,current_revenue ,
lag(current_revenue)over(order by week) as previous_revenue
from cte)

select week ,current_revenue ,previous_revenue ,
	round(((current_revenue - previous_revenue) / (previous_revenue) )*100,2) as increased_percentage from final


select current_revenue from revenue_analysis

