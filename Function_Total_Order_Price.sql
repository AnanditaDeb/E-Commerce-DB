create or replace FUNCTION get_total_order_price(

IN_ord_qty NUMBER,

IN_INSURANCE_STATUS ORDERS.INSURANCE_STATUS%type,

IN_PRODUCT_NAME PRODUCT.product_name%TYPE,

IN_CUST_CATEGORY CUSTOMER_CATEGORY.CUSTOMER_CATEGORY_ID%TYPE

 

)

RETURN NUMBER

AS

total_order_price NUMBER := 0;

v_insurance_price NUMBER;

v_offer_id NUMBER;

BEGIN

 

select O.offer_ID into v_offer_id

from offers O

inner join customer_category CC

on O.customer_category_ID = CC.customer_category_id

where CC.customer_category_id = IN_CUST_CATEGORY;

DBMS_OUTPUT.PUT_LINE(v_offer_id);

if (IN_INSURANCE_STATUS = 'N')

then

    select ((p.Unit_PRICE  * (1-(v_offer_id/100)))* IN_ord_qty)

    into total_order_price

    from PRODUCT p

    where lower(trim(p.PRODUCT_NAME)) = lower(trim(IN_PRODUCT_NAME));

    RETURN total_order_price;

else

    select (((p.Unit_PRICE  * (1-(v_offer_id/100))) + i.insurance_price)* IN_ord_qty)

    into total_order_price

    from PRODUCT p join insurance_price i

    on p.product_id = i.product_id

    where lower(trim(p.PRODUCT_NAME)) = lower(trim(IN_PRODUCT_NAME));

    RETURN total_order_price;

end if;

 

RETURN total_order_price;

END;

 

/