Type
    StudRec = Record
     Name, Surname : String[40];
     ID, Age : Integer;
     Gender : Char;
    End;

Type
    TStudRec = Record
     Name, Surname : String[40];
     ID, Age : Integer;
     Gender : Char;
    End;


Type
    TNodePtr = ^TNode;
    TNode = Record
     StudRec : TStudRec;
     NodePtr : TNodePtr;
    End;

Type
    TStudRec = Record
     Name, Surname : String[40];
     ID, Age : Integer;
     Gender : Char;
    End;



Var
    Head, Tail : TNodePtr;
    SampRec : TStudRec;

Procedure InitLinkedList;
Begin
 Head := nil;
 Tail := Head;
End;

Procedure AddNode(StudRec : TStudRec);
Var
   Node : TNode;


Begin
 Node.StudRec := StudRec;
 New(Node.NodePtr);
 If Head = nil then
  Begin
   New(Head);
   New(Tail);
   Head^ := Node;
  End Else
  Begin
   Tail^.NodePtr^ := Node;
  End;
 Tail^ := Node;
End;


Procedure InsertRecordByIndex(Index : Integer; StudRec : TStudRec);
Var
    i : Integer;
    TempPtr : TNodePtr;
    Node, TempNode : TNode;
    Done : Boolean;


Begin
 Done := False;
 if Head = nil then
  Exit;
 i := 0;
 TempPtr := Head;
 Node.StudRec := StudRec;
 New(Node.NodePtr);
 If (Index = 0) then
  Begin
   TempNode := Head^;
   Head^ := Node;
   Node.NodePtr^ := TempNode;
   Done := True;
  End;
 If not Done then
  While (i < Index-1) do
   Begin
    If (TempPtr^.NodePtr^.NodePtr = nil) then
     Begin
      Done := True;
      Break;
     End;
    i := i + 1;
    TempPtr := TempPtr^.NodePtr;
   End;
 If not Done then
  Begin
   TempNode := TempPtr^.NodePtr^;
   TempPtr^.NodePtr^ := Node;
   Node.NodePtr^ := TempNode;
  End;
End;


Procedure InsertRecordByID(ID : Integer; StudRec : TStudRec);
Var
    TempPtr : TNodePtr;
    Node, TempNode : TNode;
    Done : Boolean;

Begin
 Done := False;
 if Head = nil then
  Exit;
 TempPtr := Head;
 Node.StudRec := StudRec;
 New(Node.NodePtr);
 If (TempPtr^.StudRec.ID = ID) then
  Begin
   TempNode := Head^;
   Head^ := Node;
   Node.NodePtr^ := TempNode;
   Done := True;
  End;
 While not Done do
  Begin
   If (TempPtr^.StudRec.ID = ID) then
    Break;
   If (TempPtr^.NodePtr^.NodePtr = nil) then
    Begin
     Done := True;
     Break;
    End;
   TempPtr := TempPtr^.NodePtr;
  End;
 If not Done then
  Begin
   TempNode := TempPtr^.NodePtr^;
   Node.NodePtr^ := TempNode;
   TempPtr^.NodePtr^ := Node;
  End;
End;


Procedure DeleteNodeWithID(ID : Integer);
Var
    TempPtr, PrevPtr : TNodePtr;
    Done : Boolean;

Begin
 Done := False;
 if Head = nil then
  Exit;
 PrevPtr := Head;
 TempPtr := Head;
 While True do
  Begin
   If (TempPtr^.StudRec.ID = ID) then
    Break;
   If (TempPtr^.NodePtr^.NodePtr = nil) then
    Begin
     Done := True;
     Break;
    End;
   PrevPtr := TempPtr;
   TempPtr := TempPtr^.NodePtr;
  End;
 If not Done then
  Begin
   If TempPtr = Head then
    Head := Head^.NodePtr
   Else
   Begin
    PrevPtr^.NodePtr := TempPtr^.NodePtr;
   End;
  End;

