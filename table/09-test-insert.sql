create or replace procedure insert_person(
   phone_id int
)
language plpgsql    
as $$
IF NOT EXISTS (SELECT )
begin
    -- subtracting the amount from the sender's account 
    update accounts 
    set balance = balance - amount 
    where id = sender;
    -- adding the amount to the receiver's account
    update accounts 
    set balance = balance + amount 
    where id = receiver;
    commit;
end;$$;