DELIMITER $$
CREATE TRIGGER food_served 
    AFTER UPDATE ON food_orders
    FOR EACH ROW 
BEGIN

declare food_amount int;

if old.served=0 and new.served=1 then
set @food_amount = (NEW.item_quantity*NEW.amount);
update booking
set food_amount = food_amount+@food_amount
where booking_id=new.booking_id;
end if;

END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER service_complete 
    AFTER UPDATE ON service_orders
    FOR EACH ROW 
BEGIN

if old.served=0 and new.served=1 then
update booking
set service_amount = service_amount+new.amount
where booking_id=new.booking_id;
end if;

END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER cab_received 
    AFTER UPDATE ON cab_bookings
    FOR EACH ROW 
BEGIN

if old.received=0 and new.received=1 then
update booking
set service_amount = service_amount+new.amount
where booking_id=new.booking_id;
end if;

END$$
DELIMITER ;