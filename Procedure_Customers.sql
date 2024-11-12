create or replace PACKAGE MANAGE_CUSTOMERS AS

 

  /* TODO enter package declarations (types, exceptions, methods etc) here */

procedure add_new_CUSTOMER_CATEGORY(

    IN_CUSTOMER_CATEGORY_DESC IN CUSTOMER_CATEGORY.CUSTOMER_CATEGORY_DESC%TYPE

    );

 

procedure add_new_CUSTOMER(

IN_CUSTOMER_CATEGORY_ID IN CUSTOMER.CUSTOMER_CATEGORY_ID%type,

IN_CUSTOMER_FNAME IN CUSTOMER.CUSTOMER_FNAME%type,

IN_CUSTOMER_LNAME IN CUSTOMER.CUSTOMER_LNAME%type,

IN_CUSTOMER_ADDRESS IN CUSTOMER.CUSTOMER_ADDRESS%type,

IN_CUSTOMER_PHONE IN CUSTOMER.CUSTOMER_PHONE%type,

IN_CUSTOMER_EMAIL IN CUSTOMER.CUSTOMER_EMAIL%type

);

 

procedure DROP_record (IN_customer_ID customer.customer_ID%type );

 

END MANAGE_CUSTOMERS;

/

 

create or replace PACKAGE BODY MANAGE_CUSTOMERS AS

 

  /* TODO enter package declarations (types, exceptions, methods etc) here */

procedure add_new_CUSTOMER_CATEGORY(

    IN_CUSTOMER_CATEGORY_DESC IN CUSTOMER_CATEGORY.CUSTOMER_CATEGORY_DESC%TYPE

    )

as

 

invalid_IN_CUSTOMER_CATEGORY_DESC exception;

 

BEGIN

  if length(IN_CUSTOMER_CATEGORY_DESC) <=0

      then

          raise invalid_IN_CUSTOMER_CATEGORY_DESC ;     

    end if;

 

insert into CUSTOMER_CATEGORY(

CUSTOMER_CATEGORY_ID,

CUSTOMER_CATEGORY_DESC

)

values(

cust_cat_seq.nextval,

IN_CUSTOMER_CATEGORY_DESC

);

commit;

 

exception

when invalid_IN_CUSTOMER_CATEGORY_DESC

then

    dbms_output.put_line('Please enter correct CUSTOMER_CATEGORY_DESC');

when others

then dbms_output.put_line('Please enter correct values for CUSTOMER_CATEGORY');

 

END add_new_CUSTOMER_CATEGORY;

 

procedure add_new_CUSTOMER(

IN_CUSTOMER_CATEGORY_ID IN CUSTOMER.CUSTOMER_CATEGORY_ID%type,

IN_CUSTOMER_FNAME IN CUSTOMER.CUSTOMER_FNAME%type,

IN_CUSTOMER_LNAME IN CUSTOMER.CUSTOMER_LNAME%type,

IN_CUSTOMER_ADDRESS IN CUSTOMER.CUSTOMER_ADDRESS%type,

IN_CUSTOMER_PHONE IN CUSTOMER.CUSTOMER_PHONE%type,

IN_CUSTOMER_EMAIL IN CUSTOMER.CUSTOMER_EMAIL%type

)

as

 

invalid_CUSTOMER_CATEGORY_ID exception;

invalid_CUSTOMER_FNAME exception;

invalid_CUSTOMER_LNAME exception;

invalid_CUSTOMER_ADDRESS exception;

invalid_CUSTOMER_PHONE exception;

invalid_CUSTOMER_EMAIL exception;

 

BEGIN

 

if length(IN_CUSTOMER_CATEGORY_ID) <=0

      then

         raise invalid_CUSTOMER_CATEGORY_ID;

  elsif length( IN_CUSTOMER_FNAME) <= 0

      then

          raise invalid_CUSTOMER_FNAME;

  elsif length( IN_CUSTOMER_LNAME) <=0

      then

          raise invalid_CUSTOMER_LNAME;

  elsif  length(IN_CUSTOMER_ADDRESS) <=0

      then

          raise invalid_CUSTOMER_ADDRESS;

  elsif  length(IN_CUSTOMER_PHONE) <=0

      then

          raise invalid_CUSTOMER_PHONE ;

  elsif length(IN_CUSTOMER_EMAIL) <=0

        then

          raise invalid_CUSTOMER_EMAIL;

    end if;

 

insert into CUSTOMER(

CUSTOMER_ID,

CUSTOMER_CATEGORY_ID,

CUSTOMER_FNAME,

CUSTOMER_LNAME,

CUSTOMER_ADDRESS,

CUSTOMER_PHONE,

CUSTOMER_EMAIL

)values(

cust_seq.nextval,

IN_CUSTOMER_CATEGORY_ID ,

IN_CUSTOMER_FNAME ,

IN_CUSTOMER_LNAME ,

IN_CUSTOMER_ADDRESS ,

IN_CUSTOMER_PHONE ,

IN_CUSTOMER_EMAIL

);

 

EXCEPTION

when invalid_CUSTOMER_CATEGORY_ID

then dbms_output.put_line('Please enter correct customer category ID');

when invalid_CUSTOMER_FNAME

then dbms_output.put_line('Please enter correct value for customer first name');

when invalid_CUSTOMER_LNAME

then dbms_output.put_line('Please enter correct value for customer last name');

when invalid_CUSTOMER_ADDRESS

then dbms_output.put_line('Please enter correct value for customer address');

when invalid_CUSTOMER_PHONE

then dbms_output.put_line('Please enter correct value for customer phone number');

when invalid_CUSTOMER_EMAIL

then dbms_output.put_line('Please enter correct value for customer email');

when others

then dbms_output.put_line(sqlerrm);

 

END add_new_CUSTOMER;

 

procedure DROP_record (IN_customer_ID customer.customer_ID%type )

as

cid number ;

IS_TRUE  number;

invalid_IN_customer_ID exception;

Object_not_found exception;

CURSOR c_customerid is

      select customer_id FROM  customer; --where  lower(object_name) = 'abcd'    ;

 

begin

if IN_customer_ID <=0

      then

          raise invalid_IN_customer_ID;     

    end if;

           

   IS_TRUE:= 0;    

OPEN c_customerid;

   LOOP

   FETCH c_customerid into cid;

      EXIT WHEN c_customerid%notfound;  

if (cid =  IN_customer_ID)

then

dbms_output.put_line ('it has come inside loop');

execute immediate 'delete from customer where customer_ID = '|| IN_customer_ID;

dbms_output.put_line(IN_customer_ID || ' is deleted' );

IS_TRUE := 1;

end if;

end loop;

close c_customerid;

 

if IS_TRUE = 0 then raise Object_not_found ;

   end if;

 

exception

when invalid_IN_customer_ID

then dbms_output.put_line ('Please enter valid customer_ID');

when Object_not_found

then dbms_output.put_line (IN_customer_ID || ' cid not found');

when others

then dbms_output.put_line(sqlerrm);

 

end DROP_record;

 

END MANAGE_CUSTOMERS;

/