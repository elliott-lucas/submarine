pragma SPARK_Mode (On);

with SPARK.Text_IO; use SPARK.Text_IO;

package submarine is

   procedure hatch_close(hatchClosed : in out Boolean) with
   Global => (In_Out => Standard_Output),
   Depends => (Standard_Output => (Standard_Output, hatchClosed), hatchClosed => (hatchClosed)),
   Post => (hatchClosed);

   procedure hatch_open(currentDepth : in Natural; hatchClosed : in out Boolean) with
   Pre => (not (not hatchClosed and currentDepth > 0)),
   Global => (In_Out => Standard_Output),
   Depends => (Standard_Output => (Standard_Output, currentDepth, hatchClosed), hatchClosed => (currentDepth, hatchClosed)),
   Post => ((not hatchClosed and currentDepth = 0) or (hatchClosed and currentDepth > 0));

   procedure descend (hatchClosed : in Boolean; amount : in Natural; batteryLevel, currentDepth : in out Natural) with
   Pre => (amount in 0 .. 150 and currentDepth in 0 .. 150),
   Global => (In_Out => Standard_Output),
   Depends => (Standard_Output => (Standard_Output, hatchClosed, amount, batteryLevel, currentDepth), batteryLevel => (hatchClosed, amount, batteryLevel, currentDepth), currentDepth => (hatchClosed, amount, batteryLevel, currentDepth)),
   Post => ((currentDepth = currentDepth'Old + amount and batteryLevel = batteryLevel'Old - amount) or (currentDepth = currentDepth'Old and batteryLevel = batteryLevel'Old));

   procedure ascend (amount : in Natural; batteryLevel, currentDepth : in out Natural) with
   Pre => (amount in 0 .. 150 and currentDepth in 0 .. 150),
   Global => (In_Out => Standard_Output),
   Depends => (Standard_Output => (Standard_Output, amount, batteryLevel, currentDepth), batteryLevel => (amount, batteryLevel, currentDepth), currentDepth => (amount, batteryLevel, currentDepth)),
   Post => ((currentDepth = currentDepth'Old - amount and batteryLevel = batteryLevel'Old - amount) or (currentDepth = currentDepth'Old and batteryLevel = batteryLevel'Old));

   procedure battery_recharge (currentDepth : in Natural; batteryLevel : in out Natural) with
   Pre => (batteryLevel in 0 .. 1000),
   Global => (In_Out => Standard_Output),
   Depends => (Standard_Output => (Standard_Output, currentDepth, batteryLevel), batteryLevel => (currentDepth, batteryLevel)),
   Post => ((currentDepth = 0 and batteryLevel = 1000) or (currentDepth > 0 and batteryLevel = batteryLevel'Old));

end submarine;


