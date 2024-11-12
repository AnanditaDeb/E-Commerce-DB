create or replace PACKAGE MANAGE_INSURANCE AS

 

  /* TODO enter package declarations (types, exceptions, methods etc) here */

  procedure add_new_INSURANCE_PRICE(

    IN_PRODUCT_ID INSURANCE_PRICE.PRODUCT_ID%TYPE,

    IN_PRODUCT_CATEGORY_ID INSURANCE_PRICE.PRODUCT_CATEGORY_ID%TYPE,

    IN_INSURANCE_PRICE INSURANCE_PRICE.INSURANCE_PRICE%TYPE

    );

 

  procedure add_new_INSURANCE(

    IN_INSURANCE_START_DATE INSURANCE.INSURANCE_START_DATE%TYPE,

    IN_INSURANCE_END_DATE INSURANCE.INSURANCE_END_DATE%TYPE,

    IN_ORDERS_ID INSURANCE.ORDERS_ID%TYPE,

    IN_INSURANCE_PRICE_ID INSURANCE.INSURANCE_PRICE_ID%TYPE

    );

 

  procedure DROP_record_Insurance (IN_Insurance_ID Insurance.Insurance_ID%type );

 

END MANAGE_INSURANCE;

/

create or replace PACKAGE BODY MANAGE_INSURANCE AS

 

  /* TODO enter package declarations (types, exceptions, methods etc) here */

  procedure add_new_INSURANCE_PRICE(

    IN_PRODUCT_ID INSURANCE_PRICE.PRODUCT_ID%TYPE,

    IN_PRODUCT_CATEGORY_ID INSURANCE_PRICE.PRODUCT_CATEGORY_ID%TYPE,

    IN_INSURANCE_PRICE INSURANCE_PRICE.INSURANCE_PRICE%TYPE

    )

AS

    invalid_PRODUCT_ID exception;

   invalid_PRODUCT_CATEGORY_ID exception;

    invalid_INSURANCE_PRICE exception;

BEGIN

if IN_PRODUCT_ID <=0

      then

         raise invalid_PRODUCT_ID;

  elsif  IN_PRODUCT_CATEGORY_ID <= 0

      then

          raise invalid_PRODUCT_CATEGORY_ID;

  elsif  IN_INSURANCE_PRICE <= 0

      then

          raise invalid_INSURANCE_PRICE;

    end if;

 

Insert into INSURANCE_PRICE (

    INSURANCE_PRICE_ID,

    PRODUCT_ID,

    PRODUCT_CATEGORY_ID,

    INSURANCE_PRICE

)

values(

    INSURANCE_PRICE_seq.nextval,

    IN_PRODUCT_ID,

    IN_PRODUCT_CATEGORY_ID,

    IN_INSURANCE_PRICE

);

commit;

 

exception

when invalid_PRODUCT_ID

then

    dbms_output.put_line('Please enter correct PRODUCT ID');

when invalid_PRODUCT_CATEGORY_ID

then

    dbms_output.put_line('Please enter correct PRODUCT CATEGORY ID');

when invalid_INSURANCE_PRICE

then

    dbms_output.put_line('Please enter correct INSURANCE PRICE');

when others

then dbms_output.put_line('Please enter correct values in INSURANCE PRICE Table');

 

END add_new_insurance_price;

 

procedure add_new_INSURANCE(

    IN_INSURANCE_START_DATE INSURANCE.INSURANCE_START_DATE%TYPE,

    IN_INSURANCE_END_DATE INSURANCE.INSURANCE_END_DATE%TYPE,

    IN_ORDERS_ID INSURANCE.ORDERS_ID%TYPE,

    IN_INSURANCE_PRICE_ID INSURANCE.INSURANCE_PRICE_ID%TYPE

    )

as

   invalid_INSURANCE_START_DATE exception;

    invalid_INSURANCE_END_DATE exception;

    invalid_ORDERS_ID exception;

    invalid_INSURANCE_PRICE_ID exception;

 

BEGIN

  if length(IN_INSURANCE_START_DATE) <=0

      then

          raise invalid_INSURANCE_START_DATE ;    

    

  elsif length(IN_INSURANCE_END_DATE) <=0

      then

          raise invalid_INSURANCE_END_DATE ;

  elsif  IN_ORDERS_ID <=0

      then

          raise invalid_ORDERS_ID ;

  elsif  IN_INSURANCE_PRICE_ID <=0

      then

          raise invalid_INSURANCE_PRICE_ID ;

    end if;

 

INSERT INTO INSURANCE(

INSURANCE_ID,

INSURANCE_START_DATE,

INSURANCE_END_DATE,

ORDERS_ID,

INSURANCE_PRICE_ID

)

VALUES

(

INSURANCE_seq.nextval,

IN_INSURANCE_START_DATE,

IN_INSURANCE_END_DATE,

IN_ORDERS_ID,

IN_INSURANCE_PRICE_ID

);

COMMIT;

 

exception

when invalid_INSURANCE_START_DATE

then

    dbms_output.put_line('Please enter correct INSURANCE start date');

when invalid_INSURANCE_END_DATE

then

    dbms_output.put_line('Please enter correct INSURANCE end date');

when invalid_ORDERS_ID

then

    dbms_output.put_line('Please enter correct ORDERS ID');

when invalid_INSURANCE_PRICE_ID

then

   dbms_output.put_line('Please enter correct INSURANCE PRICE ID');

when others

then dbms_output.put_line('Please enter correct values in INSURANCE Table');

END add_new_INSURANCE;

 

procedure DROP_record_Insurance (IN_Insurance_ID Insurance.Insurance_ID%type )

as

cid number ;

IS_TRUE  number;

invalid_IN_Insurance_ID exception;

Object_not_found exception;

CURSOR c_Insuranceid is

      select Insurance_id FROM  Insurance; --where  lower(object_name) = 'abcd'    ;

 

begin

if IN_Insurance_ID <=0

      then

          raise invalid_IN_Insurance_ID;     

    end if;

           

   IS_TRUE:= 0;    

OPEN c_Insuranceid;

   LOOP

   FETCH c_Insuranceid into cid;

      EXIT WHEN c_Insuranceid%notfound;  

if (cid =  IN_Insurance_ID)

then

dbms_output.put_line ('it has come inside loop');

execute immediate 'delete from Insurance where Insurance_ID = '|| IN_Insurance_ID;

dbms_output.put_line(IN_Insurance_ID || ' is deleted' );

IS_TRUE := 1;

end if;

end loop;

close c_Insuranceid;

 

if IS_TRUE = 0 then raise Object_not_found ;

   end if;

 

exception

when invalid_IN_Insurance_ID

then dbms_output.put_line ('Please enter valid Insurance_ID');

when Object_not_found

then dbms_output.put_line (IN_Insurance_ID || ' cid not found');

when others

then dbms_output.put_line(sqlerrm);

 

end DROP_record_Insurance;

 

END MANAGE_INSURANCE;

/