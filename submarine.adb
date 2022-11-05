pragma SPARK_Mode (On);

with AS_IO_Wrapper; use AS_IO_Wrapper;

package body submarine is
   
   procedure hatch_close(hatchClosed : in out Boolean) is
      
   begin
      
      if not hatchClosed then
         hatchClosed := True;
         AS_Put_Line("Hatch closed.");
      else
         AS_Put_Line("Hatch already closed.");
      end if;
   
   end hatch_close;
   
   procedure hatch_open(currentDepth : in Natural; hatchClosed : in out Boolean) is
      
   begin
      
      if currentDepth = 0 then
         if hatchClosed then
            hatchClosed := False;
            AS_Put_Line("Hatch opened.");
         else
            AS_Put_Line("Hatch already open.");
         end if;
      else
         AS_Put_Line("Cannot open hatch when submerged.");
      end if;
   
   end hatch_open;
   
   procedure descend (hatchClosed : in Boolean; amount : in Natural; batteryLevel, currentDepth : in out Natural) is
      
   begin
      if currentDepth + amount <= 150 then
         if hatchClosed then
            if batteryLevel - (amount * 2 + currentDepth) >= 0 then
               currentDepth := currentDepth + amount;
               batteryLevel := batteryLevel - amount;
               AS_Put("Depth increased to");
               AS_Put(Integer'Image(currentDepth));
               AS_Put_Line(" metres.");
            else
               AS_Put_Line("Insufficient power for descension and reascencion. Depth unchanged.");
            end if;
         else
            AS_Put_Line("Cannot submerge when hatch is open. Depth unchanged.");

         end if;
      else
         AS_Put_Line("Cannot exceed maximum depth of 150 metres. Depth unchanged.");
      end if;
   
   end descend;
   
   procedure ascend (amount : in Natural; batteryLevel, currentDepth : in out Natural) is
      
   begin
      
      if currentDepth - amount >= 0 then
         if batteryLevel - amount * 1 >= 0 then
            currentDepth := currentDepth - amount;
            batteryLevel := batteryLevel - amount;
            AS_Put("Depth decreased to");
            AS_Put(Integer'Image(currentDepth));
            AS_Put_Line(" metres.");
         else
            AS_Put("Insufficient power to ascend");
            AS_Put(Integer'Image(amount));
            AS_Put_Line(" metres.");
         end if;
      else
         AS_Put_Line("Depth cannot be greater than 0 metres. Depth unchanged.");
      end if;
   
   end ascend;
   
   procedure battery_recharge (currentDepth : in Natural; batteryLevel : in out Natural) is
      
   begin
      
      if currentDepth = 0 then
         if batteryLevel < 1000 then
            AS_Put_Line("Recharging...");
            batteryLevel := 1000;
            AS_Put_Line("Battery recharged.");
         else
            AS_Put_Line("Battery already fully charged.");
         end if;
      else
         AS_Put_Line("Cannot recharge battery when submerged.");
      end if;
   
   end battery_recharge;
   
end submarine;
