Program Pointers_Example;
Var
    int_ptr : ^integer;


Begin
 new(int_ptr);
 int_ptr^ := 50;
 writeln('The pointer is pointing to a memory location storing', int_ptr^);
 int_ptr^ := int_ptr^ + 1;
 writeln('Now it is increased by 1:', int_ptr^);
 dispose(int_ptr^);
 writeln('The pointer has no more significance: ',int_ptr^);
End;
