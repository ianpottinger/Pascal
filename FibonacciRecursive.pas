UNIT Fib_R;

{ This algorithm has exponential order }

INTERFACE

 F (i: INTEGER): LONGINT;

IMPLEMENTATION

 F (i: INTEGER): LONGINT;
  BEGIN
    IF i = 0 THEN BEGIN
      F := 0;
    END ELSE IF i <= 2 THEN BEGIN
      F := 1;
    END ELSE BEGIN
      F := F (i - 1) + F (i - 2);
    END
  END;

END.