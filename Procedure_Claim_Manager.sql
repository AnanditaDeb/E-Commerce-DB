create or replace PACKAGE CLAIM_MANAGER AS

 

procedure resolve_CLAIM(

 

IN_claim_ID claim.claim_ID%type

 

);

 

 

END CLAIM_MANAGER;

 

/

 

create or replace PACKAGE BODY CLAIM_MANAGER AS

 

procedure resolve_CLAIM(

 

IN_claim_ID claim.claim_ID%type

 

)

 

as

 

cursor c_claim is

 

        select claim_ID, orders_ID, warranty_ID,insurance_id ,issue_date, resolve_date from claim;

 

v_claim_ID number;

 

v_orders_ID number;

 

v_Warranty_ID number;

 

v_insurance_ID number;

 

v_issue_date date;

 

v_resolve_date date;

 

IS_CLAIM_TRUE number := 0;

 

invalid_Claim_ID exception;

 

resolved_claim exception;

 

 

 

BEGIN

 

OPEN c_claim;

 

   LOOP

 

   FETCH c_claim into v_claim_ID, v_orders_ID,v_Warranty_ID,v_insurance_ID,v_issue_date,v_resolve_date;

 

      EXIT WHEN c_claim%notfound;

 

if (v_claim_ID = in_claim_ID)

 

then

 

dbms_output.put_line ('it has come inside claim loop');

 

IS_CLAIM_TRUE := 1;

 

EXIT;

 

end if;

 

end loop;

 

close c_claim;

 

 

 

if IS_CLAIM_TRUE = 0

 

then raise invalid_Claim_ID;

 

end if;

 

 

 

if  (IS_CLAIM_TRUE =1 and v_resolve_date <> '31-DEC-9999')

 

then raise resolved_claim;

 

elsif  (IS_CLAIM_TRUE =1 and v_insurance_ID is not null)

 

then update claim

 

set resolve_date = sysdate

 

where claim.issue_date < (select insurance_end_date

 

from insurance where insurance_ID = v_insurance_ID )

 

and claim_ID = IN_claim_ID;

 

elsif (v_insurance_ID is null)

 

then dbms_output.put_line('this is to let you know that claim is not covered under insurance, please make the payment');

 

end if;

 

 

 

EXCEPTION

 

when invalid_Claim_ID

 

then dbms_output.put_line('entered claim# '|| in_claim_ID || ' does not exist');

 

when resolved_claim

 

then dbms_output.put_line('entered claim# '|| in_claim_ID || ' is already resolved');

 

when others

 

then dbms_output.put_line(sqlerrm);

 

END resolve_CLAIM;

 

END CLAIM_MANAGER;

 

/