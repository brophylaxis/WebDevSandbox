select
x.local_id as ‘ID’,
cast(x.expense_date As Date) as ‘Date’,
x.amount as ‘Amount’,
v.name as ‘Contact’,
xc.name as ‘Sub Category’,
xp.name as ‘Pay Method’,
x.tax as ‘Taxes Paid’,
x.shipping as ‘S&H_Paid’,
x.notes as ‘Notes’,
x.last_modified as ‘Last Modified’
from expense x
left join (
select xv.name, xv.id
from expense_vendor xv
where xv.account_id = %filltext:name=AID%
) v
on x.vendor_id = v.id
left join (
select exc.name, exc.id, exc.category_id
from expense_category exc
where exc.account_id = %filltext:name=AID%
) xc
on x.category_id = xc.id
left join (
select xpt.id, xpt.name
from expense_payment_type xpt
where xpt.account_id = %filltext:name=AID%
) xp
on xp.id = x.payment_type_id
where x.account_id = %filltext:name=AID%
and x.deleted = 0
and x.archived = 0;