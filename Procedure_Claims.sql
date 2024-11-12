create or replace PACKAGE MANAGE_OBJECTS AS

 

  /* TODO enter package declarations (types, exceptions, methods etc) here */

 

  procedure drop_objects(

    In_obj_Name VARCHAR,

    In_obj_type IN VARCHAR

    );

 

END MANAGE_OBJECTS;

/

create or replace PACKAGE BODY MANAGE_OBJECTS AS

 

  /* TODO enter package declarations (types, exceptions, methods etc) here */

 

  procedure drop_objects(

    In_obj_name IN VARCHAR,

    In_obj_type IN VARCHAR

    )

as

 

IS_TRUE  number;

sql_stmt    VARCHAR2(200);

Invalid_In_obj_name exception;

Invalid_In_obj_type exception;

Object_not_found exception;

c_object_name user_objects.object_name%type;

c_object_type user_objects.object_type%type;

CURSOR c_objects is

      SELECT object_name, object_type FROM  user_objects; --where  lower(object_name) = 'abcd'    ;

 

BEGIN

 

if length(In_obj_name) <=0

      then

          raise Invalid_In_obj_name ; 

elsif length(In_obj_type) <= 0

        then

           raise Invalid_In_obj_type;

    end if;

  

    IS_TRUE := 0;

 

   OPEN c_objects;

   LOOP

   FETCH c_objects into c_object_name, c_object_type ;

      EXIT WHEN c_objects%notfound;

    IF (

    trim(lower(c_object_name)) = trim(lower(In_obj_name))

    and trim(lower(c_object_type)) = trim(lower(In_obj_type))

    )

    then

    sql_stmt := 'DROP '|| c_object_type || ' ' ||In_obj_name || ';';

    dbms_output.put_line(sql_stmt );

    --EXECUTE IMMEDIATE sql_stmt;

    execute immediate 'drop ' || c_object_type || ' ' || In_obj_name ; -- || ' cascade constraints';

    dbms_output.put_line(c_object_type|| ' ' || In_obj_name || ' is dropped.' );

    IS_TRUE := 1;

    END IF;

    --dbms_output.put_line(c_object_type||In_obj_name);

  

   END LOOP;

  

   CLOSE c_objects;

   

   if IS_TRUE = 0 then raise Object_not_found ;

   end if;

     

commit;

 

EXCEPTION

when Invalid_In_obj_name

then dbms_output.put_line('Please enter correct value for object name');

when Invalid_In_obj_type

then dbms_output.put_line('Please enter correct value for object type');

when Object_not_found

then dbms_output.put_line( In_obj_type || ' ' || In_obj_name || ' not found');

when others

then dbms_output.put_line(sqlerrm);

--then dbms_output.put_line('Please pass correct parameters');

 

END drop_objects;

 

END MANAGE_OBJECTS;

/

create or replace PACKAGE MANAGE_USERS AS

 

  /* TODO enter package declarations (types, exceptions, methods etc) here */

  procedure drop_users(

    In_user_Name VARCHAR

    );

 

 

END MANAGE_USERS;

/

create or replace PACKAGE BODY MANAGE_USERS AS

 

  /* TODO enter package declarations (types, exceptions, methods etc) here */

  procedure drop_users(

    In_user_Name VARCHAR

    )

  as

  IS_TRUE  number;

sql_stmt    VARCHAR2(200);

Invalid_In_user_name exception;

user_not_found exception ;

v_user_name all_users.username%type;

cursor c_all_users is

    select username from all_users;

BEGIN

if length(In_user_Name) <= 0

        then

            raise Invalid_In_user_name;

    end if;

 

    IS_TRUE := 0;

 

    OPEN c_all_users;

   LOOP

   FETCH c_all_users into v_user_name;

      EXIT WHEN c_all_users%notfound;

      --dbms_output.put_line('My name is mital');

    IF (

    trim(lower(v_user_name)) = trim(lower(In_user_Name))

      )

    then

    sql_stmt := 'DROP user '||In_user_Name;

    dbms_output.put_line(sql_stmt );

    EXECUTE IMMEDIATE sql_stmt;

    --execute immediate 'drop user '||upper(trim(in_user_name))  ;

    dbms_output.put_line(In_user_Name||  ' user is dropped.' );

    IS_TRUE := 1;

    END IF;

    --dbms_output.put_line(c_object_type||In_obj_name);

 

   END LOOP;

 

   CLOSE c_all_users;

 

   if IS_TRUE = 0 then raise user_not_found ;

   end if;

 

commit;

 

EXCEPTION

when Invalid_In_user_name

then dbms_output.put_line('Please enter correct username');

when user_not_found

then dbms_output.put_line( In_user_Name || ' not found');

when others

then dbms_output.put_line(sqlerrm);

END drop_users;

 

END MANAGE_USERS;

/

exec manage_objects.drop_objects('INSURANCE','table');

exec manage_objects.drop_objects('INSURANCE','view');

exec manage_objects.drop_objects('INSURANCE_PRICE','table');

exec manage_objects.drop_objects('INSURANCE_PRICE','view');

exec manage_objects.drop_objects('courier','table');

exec manage_objects.drop_objects('courier','view');

exec manage_objects.drop_objects('claim','table');

exec manage_objects.drop_objects('claim','view');

exec manage_objects.drop_objects('claim_category','table');

exec manage_objects.drop_objects('claim_category','view');

exec manage_objects.drop_objects('warranty','table');

exec manage_objects.drop_objects('warranty','view');

exec manage_objects.drop_objects('ORDERS','table');

exec manage_objects.drop_objects('ORDERS','view');

exec manage_objects.drop_objects('OFFERS','table');

exec manage_objects.drop_objects('OFFERS','view');

exec manage_objects.drop_objects('CUSTOMER','table');

exec manage_objects.drop_objects('CUSTOMER','view');

exec manage_objects.drop_objects('CUSTOMER_CATEGORY','table');

exec manage_objects.drop_objects('CUSTOMER_CATEGORY','view');

exec manage_objects.drop_objects('PRODUCT','table');

exec manage_objects.drop_objects('PRODUCT','view');

exec manage_objects.drop_objects('PRODUCT_CATEGORY','table');

exec manage_objects.drop_objects('PRODUCT_CATEGORY','view');

exec manage_objects.drop_objects('ORDERS_CHANGES_TRACK','table');

 

exec manage_objects.drop_objects('ORDER_seq','sequence');

exec manage_objects.drop_objects('INSURANCE_seq','sequence');

exec manage_objects.drop_objects('INSURANCE_PRICE_seq','sequence');

exec manage_objects.drop_objects('cust_seq','sequence');

exec manage_objects.drop_objects('cust_cat_seq','sequence');

exec manage_objects.drop_objects('prd_seq','sequence');

exec manage_objects.drop_objects('prd_cat_seq','sequence');

exec manage_objects.drop_objects('WAR_SEQ','sequence');

exec manage_objects.drop_objects('COURIER_SEQ','sequence');

exec manage_objects.drop_objects('CLAIM_SEQ','sequence');

exec manage_objects.drop_objects('CLAIM_CAT_SEQ','sequence');

 

Exec manage_objects.drop_objects('INVENTORY_STATUS','view');

Exec manage_objects.drop_objects('get_total_order_price','function');


create or replace PACKAGE MANAGE_CLAIM AS

 

  /* TODO enter package declarations (types, exceptions, methods etc) here */

 

  /* TODO enter package declarations (types, exceptions, methods etc) here */

  procedure add_new_CLAIM_CATEGORY(

    IN_CLAIM_DESCRIPTION CLAIM_CATEGORY.CLAIM_DESCRIPTION%TYPE

    );

  

    procedure add_new_CLAIM(

    IN_CLAIM_DESCRIPTION CLAIM_CATEGORY.CLAIM_DESCRIPTION%TYPE,

    IN_ORDERS_ID CLAIM.ORDERS_ID%TYPE,

    IN_WARRANTY_ID CLAIM.WARRANTY_ID%TYPE,

    IN_INSURANCE_ID CLAIM.INSURANCE_ID%TYPE

    );

 

procedure resolve_CLAIM(

IN_claim_ID claim.claim_ID%type

);

 

procedure DROP_record_claim (IN_claim_ID CLAIM.CLAIM_ID%type );

 

procedure DROP_record_claim_category (IN_claim_category_ID claim_category.claim_category_ID%type );

 

END MANAGE_CLAIM;

/

create or replace PACKAGE BODY MANAGE_CLAIM AS

 

  /* TODO enter package declarations (types, exceptions, methods etc) here */

 

  /* TODO enter package declarations (types, exceptions, methods etc) here */

  procedure add_new_CLAIM_CATEGORY(

    IN_CLAIM_DESCRIPTION CLAIM_CATEGORY.CLAIM_DESCRIPTION%TYPE

    )

as

invalid_IN_CLAIM_DESCRIPTION exception;

BEGIN

  if length(IN_CLAIM_DESCRIPTION) <=0

      then

          raise invalid_IN_CLAIM_DESCRIPTION ;    

    end if;

 

insert into CLAIM_CATEGORY(

CLAIM_CATEGORY_ID,

CLAIM_DESCRIPTION

)

VALUES(

claim_cat_seq.nextval,

IN_CLAIM_DESCRIPTION

);

commit;

exception

when invalid_IN_CLAIM_DESCRIPTION

then

    dbms_output.put_line('Please enter correct CALIM_CATEGORY_DESC');

when others

then dbms_output.put_line('Please enter correct values for CLAIM_CATEGORY');

 

END add_new_CLAIM_CATEGORY;

 

  

    procedure add_new_CLAIM (

    IN_CLAIM_DESCRIPTION CLAIM_CATEGORY.CLAIM_DESCRIPTION%TYPE,

    IN_ORDERS_ID CLAIM.ORDERS_ID%TYPE,

    IN_WARRANTY_ID CLAIM.WARRANTY_ID%TYPE,

    IN_INSURANCE_ID CLAIM.INSURANCE_ID%TYPE

    )

AS

    invalid_CLAIM_DESCRIPTION exception;

    invalid_ORDERS_ID exception;

    invalid_WARRANTY_ID exception;

    invalid_INSURANCE_ID exception;

    claimAlreadyExists exception;

    v_orders_ID number;

    v_warranty_ID number;

    v_insurance_ID number;

    v_claim_category_id number;

    v_cl_claim_ID number;

    v_cl_orders_ID number;

    IS_ORD_TRUE number :=0;

    IS_WAR_TRUE number :=0;

    IS_INS_TRUE number :=0;

    IS_claimcat_TRUE number :=0;

    IS_INS_PURCCHASED number;

    v_ins_status varchar(3);

    CURSOR c_orderdetail is

      select  o.orders_ID,o.warranty_ID,i.insurance_ID,o.insurance_status

      from  insurance i right join orders o on i.orders_id = o.orders_id where ORDER_QTY <> 0;

    cursor c_claim is

        select claim_category_id from claim_category where lower(trim(claim_description)) = lower(trim(IN_CLAIM_DESCRIPTION)) ;

    cursor c_claimAlreadyExists is

        select claim_ID, orders_ID from claim;

  

BEGIN

 

OPEN c_orderdetail;

   LOOP

   FETCH c_orderdetail into v_orders_ID, v_warranty_ID,v_insurance_ID,v_ins_status;

      EXIT WHEN c_orderdetail%notfound;

if (v_warranty_ID =  IN_WARRANTY_ID)

then

dbms_output.put_line ('it has come inside orderdetail war loop');

IS_WAR_TRUE := 1;

end if;

if ( v_orders_ID = IN_orders_id)

then

dbms_output.put_line ('it has come inside orderdetail ord loop');

IS_ORD_TRUE := 1;

end if;

if ( (v_INSURANCE_ID = IN_INSURANCE_id) or (trim(upper(v_ins_status)) = 'N' and v_orders_ID = IN_orders_id) )

then

dbms_output.put_line ('it has come inside orderdetail ins loop');

IS_INS_TRUE := 1;

exit;

end if;

end loop;

close c_orderdetail;

 

OPEN c_claim;

   LOOP

   FETCH c_claim into v_claim_category_id;

      EXIT WHEN c_claim%notfound;

if (v_claim_category_id <> 0)

then

dbms_output.put_line ('it has come inside claim loop');

IS_claimcat_TRUE := 1;

end if;

end loop;

close c_claim;

 

OPEN c_claimAlreadyExists;

   LOOP

   FETCH c_claimAlreadyExists into v_cl_claim_ID, v_cl_orders_ID;

      EXIT WHEN c_claimAlreadyExists%notfound;

if (v_cl_orders_ID = IN_ORDERS_ID)

then

dbms_output.put_line ('it has come inside claimAlreadyExists loop');

raise claimAlreadyExists;

end if;

end loop;

close c_claimAlreadyExists;

 

  if (length(IN_CLAIM_DESCRIPTION) <=0 or IS_claimcat_TRUE = 0)

      then

          raise invalid_CLAIM_DESCRIPTION ;    

    

  elsif (IN_ORDERS_ID <=0 or IS_ORD_TRUE = 0)

      then

          raise invalid_ORDERS_ID ;    

    

    

  elsif (IN_WARRANTY_ID <=0 or IS_WAR_TRUE = 0)

      then

          raise invalid_WARRANTY_ID ;    

    

  elsif (IN_INSURANCE_ID<=0 or IS_INS_TRUE = 0)

      then

          raise invalid_INSURANCE_ID ;    

    end if;

 

insert into claim(

claim_id,

CLAIM_CATEGORY_ID,

ORDERS_ID,

WARRANTY_ID,

ISSUE_DATE,

RESOLVE_DATE,

INSURANCE_ID

)

values(

CLAIM_SEQ.NEXTVAL,

v_claim_category_id,

v_orders_ID,

v_warranty_ID,

sysdate ,

'31-DEC-9999',

v_insurance_ID

);

 

  

commit;

 

exception

when invalid_CLAIM_DESCRIPTION

then

    dbms_output.put_line('Please enter correct claim Description');

when invalid_ORDERS_ID

then

    dbms_output.put_line('Please enter correct order_id');

when invalid_WARRANTY_ID

then

    dbms_output.put_line('Please enter correct warranty id');

when invalid_INSURANCE_ID

then

    dbms_output.put_line('Please enter correct insurance id');

when claimAlreadyExists

then dbms_output.put_line('claim#' || v_cl_claim_ID || 'already exists for order#'||v_cl_orders_ID);

when others

then dbms_output.put_line(sqlerrm);

 

END add_new_claim;

 

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

 

procedure DROP_record_claim (IN_claim_ID claim.claim_ID%type )

as

cid number ;

IS_TRUE  number;

invalid_IN_claim_ID exception;

Object_not_found exception;

CURSOR c_claimid is

      select claim_id FROM  claim; --where  lower(object_name) = 'abcd'    ;

 

begin

if IN_claim_ID <=0

      then

          raise invalid_IN_claim_ID;     

    end if;

           

   IS_TRUE:= 0;    

OPEN c_claimid;

   LOOP

   FETCH c_claimid into cid;

      EXIT WHEN c_claimid%notfound;  

if (cid =  IN_claim_ID)

then

dbms_output.put_line ('it has come inside loop');

execute immediate 'delete from claim where claim_ID = '|| IN_claim_ID;

dbms_output.put_line(IN_claim_ID || ' is deleted' );

IS_TRUE := 1;

end if;

end loop;

close c_claimid;

 

if IS_TRUE = 0 then raise Object_not_found ;

   end if;

 

exception

when invalid_IN_claim_ID

then dbms_output.put_line ('Please enter valid claim_ID');

when Object_not_found

then dbms_output.put_line (IN_claim_ID || ' cid not found');

when others

then dbms_output.put_line(sqlerrm);

 

end DROP_record_claim;

 

procedure DROP_record_claim_category (IN_claim_category_ID claim_category.claim_category_ID%type )

as

cid number ;

IS_TRUE  number;

invalid_IN_claim_category_ID exception;

Object_not_found exception;

CURSOR c_claim_categoryid is

      select claim_category_id FROM  claim_category; --where  lower(object_name) = 'abcd'    ;

 

begin

if IN_claim_category_ID <=0

      then

          raise invalid_IN_claim_category_ID;     

    end if;

           

   IS_TRUE:= 0;    

OPEN c_claim_categoryid;

   LOOP

   FETCH c_claim_categoryid into cid;

      EXIT WHEN c_claim_categoryid%notfound;  

if (cid =  IN_claim_category_ID)

then

dbms_output.put_line ('it has come inside loop');

execute immediate 'delete from claim_category where claim_category_ID = '|| IN_claim_category_ID;

dbms_output.put_line(IN_claim_category_ID || ' is deleted' );

IS_TRUE := 1;

end if;

end loop;

close c_claim_categoryid;

 

if IS_TRUE = 0 then raise Object_not_found ;

   end if;

 

exception

when invalid_IN_claim_category_ID

then dbms_output.put_line ('Please enter valid claim_category_ID');

when Object_not_found

then dbms_output.put_line (IN_claim_category_ID || ' cid not found');

when others

then dbms_output.put_line(sqlerrm);

 

end DROP_record_claim_category;

 

END MANAGE_CLAIM;

/

 