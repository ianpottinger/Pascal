Procedure QSort(numbers : Array of Integer;
                left : Integer; right : Integer);
Var pivot, l_ptr, r_ptr : Integer;


Begin
 l_ptr := left;
 r_ptr := right;
 pivot := numbers[left];
 While (left < right) do
  Begin
   While ((numbers[right] >= pivot) AND (left < right)) do
    right := right - 1;
   If (left <> right) then
    Begin
     numbers[left] := numbers[right];
     left := left + 1;
    End;
   While ((numbers[left] <= pivot) AND (left < right)) do
    left := left + 1;
   If (left <> right) then
    Begin
     numbers[right] := numbers[left];
     right := right - 1;
    End;
  End;
 numbers[left] := pivot;
 pivot := left;
 left := l_ptr;
 right := r_ptr;
 If (left < pivot) then
  QSort(numbers, left, pivot-1);
 If (right > pivot) then
  QSort(numbers, pivot+1, right);
End;

Procedure QuickSort(numbers : Array of Integer; size : Integer);
Begin
 QSort(numbers, 0, size-1);
End;



procedure QuickSort(const AList: TStrings; const AStart, AEnd: Integer);
  procedure Swap(const AIdx1, AIdx2: Integer);
  var
    Tmp: string;
  begin
    Tmp := AList[AIdx1];
    AList[AIdx1] := AList[AIdx2];
    AList[AIdx2] := Tmp;
  end;
 
var
  Left: Integer;
  Pivot: string;
  Right: Integer;
begin
  if AStart >= AEnd then
    Exit;
  Pivot := AList[AStart];
  Left := AStart + 1;
  Right := AEnd;
  while Left < Right do
    begin
      if AList[Left] < Pivot then
        Inc(Left)
      else
        begin
          Swap(Left, Right);
          Dec(Right);
        end;
    end;
  Dec(Left);
  Swap(Left, AStart);
  Dec(Left);
  QuickSort(AList, AStart, Left);
  QuickSort(AList, Right, AEnd);
end;
This implementation sorts an array of integers.
procedure QSort(var A: array of Integer);
  procedure QuickSort(var A: array of Integer; iLo, iHi: Integer);
  var Lo, Hi, Mid, T: Integer;
  begin
    Lo := iLo;
    Hi := iHi;
    Mid := A[(Lo + Hi) div 2];
    repeat
      while A[Lo] < Mid do
        Inc(Lo);
      while A[Hi] > Mid do
        Dec(Hi);
      if Lo <= Hi then begin
        T := A[Lo];
        A[Lo] := A[Hi];
        A[Hi] := T;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > iLo then
      QuickSort(A, iLo, Hi);
    if Lo < iHi then
      QuickSort(A, Lo, iHi);
  end;
begin
  QuickSort(A, Low(A), High(A));
end;
This slightly modified implementation sorts an array of records. This is approximately 8x quicker than the previous one. Note: this is QuickSort only, more speedup can be gain with handling trivial case (comparing two values), or implementing Bubble or Shell sort on small ranges.
type
  TCustomRecord = record
    Key: WideString;
    foo1:Int64;
    foo2:TDatetime;
    foo3:Extended;
  end;
  TCustomArray = array of TCustomRecord;
 
procedure QuickSort(var A: TCustomArray; L, R: Integer; var tmp: TCustomRecord);
var
  OrigL,
  OrigR: Integer;
  Pivot: WideString;
  GoodPivot,
  SortPartitions: Boolean;
begin
  if L<R then begin
    Pivot:=A[L+Random(R-L)].Key;
    OrigL:=L; //saving original bounds
    OrigR:=R;
    repeat
      L:=OrigL; //restoring original bounds if we
      R:=OrigR; //have chosen a bad pivot value
      while L<R do begin
        while (L<R) and (A[L].Key<Pivot) do Inc(L);
        while (L<R) and (A[R].Key>=Pivot) do Dec(R);
        if (L<R) then begin
          tmp:=A[L];
          A[L]:=A[R];
          A[R]:=tmp;
          Dec(R);
          Inc(L);
        end;
      end;
      if A[L].Key>=Pivot then Dec(L);                            //has we managed to choose
      GoodPivot:=L>=OrigL;                                       //a good pivot value?
      SortPartitions:=True;                                      //if so, then sort on
      if not GoodPivot then begin                                //bad luck, the pivot is the smallest one in our range
        GoodPivot:=True;                                         //let's presume that all the values are equal to pivot
        SortPartitions:=False;                                   //then no need to sort it
        for R := OrigL to OrigR do if A[R].Key<>Pivot then begin //we have at least one different value than our pivot
          Pivot:=A[R].Key;                                       //so this will be our new pivot
          GoodPivot:=False;                                      //we have to start again sorting this range
          Break;
        end;
      end;
    until GoodPivot;
    if SortPartitions then begin
      QuickSort(A, OrigL, L, tmp);
      QuickSort(A, L+1, OrigR, tmp);
    end;
  end;
end;