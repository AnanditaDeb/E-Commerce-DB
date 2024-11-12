create or replace trigger track_order_changes

before delete or insert or update

on ORDERS

referencing old as o new as n

for each row

begin

  if deleting  then

     insert into ORDERS_Changes_Track

        (

        ORDERS_ID ,

        CUSTOMER_ID ,

        PRODUCT_ID ,

        WARRANTY_ID ,

        OFFER_ID ,

        ORDER_DATE ,

        DISPATCH_DATE ,

        ORDER_PRICE ,

        PAY_STATUS,

        ORDER_QTY ,

        INSURANCE_STATUS ,

        EVENT_TYPE

        )

        values(

        :o.ORDERS_ID ,

        :o.CUSTOMER_ID ,

        :o.PRODUCT_ID ,

        :o.WARRANTY_ID ,

        :o.OFFER_ID ,

        :o.ORDER_DATE ,

        :o.DISPATCH_DATE ,

        :o.ORDER_PRICE ,

        :o.PAY_STATUS,

        :o.ORDER_QTY ,

        :o.INSURANCE_STATUS ,

        'deleting'

        );

        end if;

  if inserting  then

     insert into ORDERS_Changes_Track

        (

        ORDERS_ID ,

        CUSTOMER_ID ,

        PRODUCT_ID ,

        WARRANTY_ID ,

        OFFER_ID ,

        ORDER_DATE ,

        DISPATCH_DATE ,

        ORDER_PRICE ,

        PAY_STATUS,

        ORDER_QTY ,

        INSURANCE_STATUS ,

        EVENT_TYPE

        )

        values(

        :n.ORDERS_ID ,

        :n.CUSTOMER_ID ,

        :n.PRODUCT_ID ,

        :n.WARRANTY_ID ,

       :n.OFFER_ID ,

        :n.ORDER_DATE ,

        :n.DISPATCH_DATE ,

        :n.ORDER_PRICE ,

        :n.PAY_STATUS,

        :n.ORDER_QTY ,

        :n.INSURANCE_STATUS ,

        'inserting'

        );

        end if;

  if updating  then

     insert into ORDERS_Changes_Track

        (

        ORDERS_ID ,

        CUSTOMER_ID ,

        PRODUCT_ID ,

        WARRANTY_ID ,

        OFFER_ID ,

        ORDER_DATE ,

        DISPATCH_DATE ,

        ORDER_PRICE ,

        PAY_STATUS,

        ORDER_QTY ,

        INSURANCE_STATUS ,

        EVENT_TYPE

        )

        values(

        :n.ORDERS_ID ,

        :n.CUSTOMER_ID ,

        :n.PRODUCT_ID ,

        :n.WARRANTY_ID ,

        :n.OFFER_ID ,

        :n.ORDER_DATE ,

        :n.DISPATCH_DATE ,

        :n.ORDER_PRICE ,

        :n.PAY_STATUS,

        :n.ORDER_QTY ,

        :n.INSURANCE_STATUS ,

        'updating'

        );

        end if;

 

end;

/
