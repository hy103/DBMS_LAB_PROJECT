DELIMITER //

CREATE procedure book_room (
IN cust_id int,
IN room_no varchar(10),
IN sdate date,
IN edate date,
IN rate int
)
BEGIN
insert into booking(booking_id,cust_id,room_no,in_date,end_date,room_rate,job_id,room_amount,food_amount,service_amount) 
values((select count(*)+1 from booking),@cust_id,@room_no,@sdate,@edate,@rate,4,@rate*datediff(edate,sdate),0,0); 
END; //

DELIMITER ;

DELIMITER //

CREATE procedure check_out (
IN book_id int
)
BEGIN

insert into bookings_history 
select booking_id,cust_id,room_no,in_date,datediff(end_date,in_date) as days_stayed,room_amount,food_amount,service_amount,room_amount+food_amount+service_amount as amount,null as room_rating,4 as job_id
from booking where booking_id=@book_id;

delete from booking where booking_id=@book_id;

END; //

DELIMITER ;