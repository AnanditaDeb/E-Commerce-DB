create or replace PACKAGE MANAGE_WARRANTY AS

 

  /* TODO enter package declarations (types, exceptions, methods etc) here */

  procedure add_new_WARRANTY(

  

    IN_PRODUCT_ID WARRANTY.PRODUCT_ID%TYPE,

    IN_ORDERS_ID WARRANTY.ORDERS_ID%TYPE,

    IN_START_DATE  WARRANTY.START_DATE%TYPE,

    IN_END_DATE  WARRANTY.END_DATE%TYPE

    );

 

procedure DROP_record_Warranty (IN_Warranty_ID Warranty.Warranty_ID%type );

END MANAGE_WARRANTY;

/

 

create or replace PACKAGE BODY MANAGE_WARRANTY AS

 

  /* TODO enter package declarations (types, exceptions, methods etc) here */

  procedure add_new_WARRANTY(

    IN_PRODUCT_ID WARRANTY.PRODUCT_ID%TYPE,

    IN_ORDERS_ID WARRANTY.ORDERS_ID%TYPE,

    IN_START_DATE  WARRANTY.START_DATE%TYPE,

    IN_END_DATE  WARRANTY.END_DATE%TYPE

    )

AS

   invalid_PRODUCT_ID exception;

    invalid_BILL_NO exception;

    invalid_START_DATE exception;

    invalid_END_DATE exception;

  

BEGIN

if IN_PRODUCT_ID <=0

      then

         raise invalid_PRODUCT_ID ;    

    

  elsif IN_ORDERS_ID <=0

      then

          raise invalid_BILL_NO ;     

   

  elsif length(IN_START_DATE) <=0

      then

          raise invalid_START_DATE ;    

    

  elsif length(IN_END_DATE) <=0

      then

          raise invalid_END_DATE ;       

    end if;

  

Insert into WARRANTY (

    WARRANTY_ID,

    PRODUCT_ID,

    ORDERS_ID,

    START_DATE,

    END_DATE

)

values(

    war_seq.currval,

    IN_PRODUCT_ID,

    IN_ORDERS_ID,

    IN_START_DATE,

    IN_END_DATE

);

commit;

 

exception

when invalid_PRODUCT_ID

then

    dbms_output.put_line('Please enter correct product ID');

when invalid_BILL_NO

then

    dbms_output.put_line('Please enter correct bill no');

when invalid_START_DATE

then

    dbms_output.put_line('Please enter correct start date');

when invalid_END_DATE

then

    dbms_output.put_line('Please enter correct end date');

when others

then dbms_output.put_line('Please enter correct values in WARRANTY Table');

END add_new_warranty;

 

procedure DROP_record_Warranty (IN_Warranty_ID Warranty.Warranty_ID%type )

as

cid number ;

IS_TRUE  number;

invalid_IN_Warranty_ID exception;

Object_not_found exception;

CURSOR c_Warrantyid is

      select Warranty_ID FROM  Warranty; --where  lower(object_name) = 'abcd'    ;

 

begin

if IN_Warranty_ID <=0

      then

          raise invalid_IN_Warranty_ID;     

    end if;

           

   IS_TRUE:= 0;    

OPEN c_Warrantyid;

   LOOP

   FETCH c_Warrantyid into cid;

      EXIT WHEN c_Warrantyid%notfound;  

if (cid =  IN_Warranty_ID)

then

dbms_output.put_line ('it has come inside loop');

execute immediate 'delete from Warranty where Warranty_ID = '|| IN_Warranty_ID;

dbms_output.put_line(IN_Warranty_ID || ' is deleted' );

IS_TRUE := 1;

end if;

end loop;

close c_Warrantyid;

 

if IS_TRUE = 0 then raise Object_not_found ;

   end if;

 

exception

when invalid_IN_Warranty_ID

then dbms_output.put_line ('Please enter valid Warranty_ID');

when Object_not_found

then dbms_output.put_line (IN_Warranty_ID || ' order id not found');

when others

then dbms_output.put_line(sqlerrm);

 

end DROP_record_Warranty;

 

END MANAGE_WARRANTY;

/

 