pragma SPARK_Mode (On);

with AS_IO_Wrapper, submarine; use AS_IO_Wrapper, submarine;

procedure main is

   cmd : String(1 .. 20);
   amount : Integer;
   Last : Integer;
   
   batteryLevel : Integer range 0 .. 1000 := 1000;  
   currentDepth : Integer range 0 .. 150 := 0;
   hatchClosed : Boolean := False;
   
begin
   
   loop
      
      -- Closing hatch if it is open underwater.
      if currentDepth > 0 and not hatchClosed then
         AS_Put_Line("Submerged and hatch not closed! Closing hatch automatically!");
         hatch_close(hatchClosed);
      end if;
      
      -- Resurfacing before there is not enough power to resurface.
      if currentDepth > 0 and batteryLevel <= currentDepth + 5 then
         AS_Put_Line("Must resurface now! Ascending automatically!");
         ascend(currentDepth, batteryLevel, currentDepth);
      end if;
      
      -- Automatic battery recharging on surface.
      if batteryLevel < 1000 and currentDepth = 0 then
         AS_Put_Line("Recharging battery automatically while at surface.");
         battery_recharge(currentDepth, batteryLevel);
      end if;
      
      -- Get command input.
      loop
         AS_Put(">> ");
         AS_Get_Line(cmd, Last);
         exit when Last in 0 .. 20;
         AS_Put_Line("Invalid command.");
      end loop;
     
      cmd(Last+1 .. 20) := (Last+1 .. 20 => ' ');
      
      -- Process command input.
      if cmd(1 .. 7) = "battery" then
         if cmd(8 .. 13) = " level" then
            AS_Put("Battery Level:");
            AS_Put_Line(Integer'Image(batteryLevel));
         elsif cmd(8 .. 16) = " recharge" then
            battery_recharge (currentDepth, batteryLevel);
         else
            AS_Put_Line("Invalid command.");
         end if;
      elsif cmd(1 .. 5) = "hatch" then
         if cmd(6 .. 10) = " open" then
            hatch_open(currentDepth, hatchClosed);
         elsif cmd(6 .. 11) = " close" then
            hatch_close(hatchClosed);
         else
            AS_Put_Line("Invalid command.");
         end if;
      
      elsif cmd(1 .. 5) = "depth" then
         if cmd(6 .. 11) = " level" then
            AS_Put("Depth:");
            AS_Put_Line(Integer'Image(currentDepth));
         elsif cmd(6 .. 14) = " increase" then
            loop
               AS_Put("Amount: ");
               AS_Get(amount);
               exit when amount in 0 .. (150 - currentDepth);
               AS_Put("Amount must be between 0 and");
               AS_Put(Integer'Image(150 - currentDepth));
               AS_Put_Line(".");
            end loop;
            descend(hatchClosed, amount, batteryLevel, currentDepth);
         elsif cmd(6 .. 14) = " decrease" then
            loop
               AS_Put("Amount: ");
               AS_Get(amount);
               exit when amount in 0 .. currentDepth;
               AS_Put("Amount must be between 0 and");
               AS_Put(Integer'Image(currentDepth));
               AS_Put_Line(".");
            end loop;
            ascend(amount, batteryLevel, currentDepth);
         else
            AS_Put_Line("Invalid command.");
         end if;
      elsif cmd(1 .. Last) = "shutdown" then
         if currentDepth = 0 then
            AS_Put_Line("Shutting down.");
         else
            AS_Put_Line("Cannot shut down when submerged.");
         end if;
      else
         AS_Put_Line("Invalid command.");
      end if;
      
      exit when cmd(1 .. Last) = "shutdown" and currentDepth = 0;
   end loop;

end main;
