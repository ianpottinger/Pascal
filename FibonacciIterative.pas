UNIT Fib_I;

{ This algoritm has linear order }

INTERFACE

 F (I: INTEGER): LONGINT;

IMPLEMENTATION

 F (I: INTEGER): LONGINT;
  VAR Fib: LONGINT;
      Fib_1: LONGINT;
      Fib_2: LONGINT;
      J:   INTEGER;
  BEGIN
    IF I = 0 THEN BEGIN
      F := 0;
    END ELSE IF I < 3 THEN BEGIN
      F := 1;
    END ELSE BEGIN      
      Fib_1 := 1;
      Fib_2 := 1;
      J := 3;
      WHILE j <= i DO BEGIN
        Fib := Fib_1 + Fib_2;
        Fib_2 := Fib_1;
        Fib_1 := Fib;
        J := J + 1;
        F := Fib;
      END
    END;
  END;

END.