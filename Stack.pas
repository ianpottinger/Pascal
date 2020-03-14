
Const
    STACK_SIZE = 100;


Var
    myStack : Array[1..STACK_SIZE] of DataItem;
    topPointer : Integer;


Procedure InitStack;
Begin
 topPointer := 0;
End;


Function IsEmpty : Boolean;
Begin
 IsEmpty := false;
 If (topPointer = 0) then
  IsEmpty := true;
End;


Function IsFull : Boolean;
Begin
 IsFull := false;
 If ((topPointer + 1) = STACK_SIZE) then
  IsFull := true;
End;


Function Pop : DataItem;

Begin
 Pop := nil;

 If not IsEmpty then
  Begin
   Pop := myStack[topPointer];
   topPointer := topPointer - 1;
  End;
End;


Procedure Push(item : DataItem);
Begin
 If not IsFull then
  Begin
   myStack[topPointer+1] := item;
   topPointer := topPointer + 1;
  End;
End;


Function GetSize : Integer;
Begin
 GetSize := topPointer;
End;
