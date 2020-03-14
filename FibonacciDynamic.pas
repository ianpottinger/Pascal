UNIT Fib_D;

{ This algoritm has constant order }

INTERFACE

 F (I: INTEGER): LONGINT;

IMPLEMENTATION

VAR
  FIB: ARRAY [0..46] OF LONGINT;
  I: INTEGER;

 F (I: INTEGER): LONGINT;
  BEGIN
    F := Fib [I];
  END;

BEGIN  
  FIB [0] := 0;
  FIB [1] := 1;
  I := 2;
  WHILE I < 46 DO BEGIN
    FIB [I] := FIB [I - 1] + FIB [I - 2];
    I := I + 1;
  END
END.