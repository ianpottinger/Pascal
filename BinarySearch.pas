(* Returns index of requested value in an integer array that has been sorted
in ascending order -- otherwise returns -1 if requested value does not exist. *)
 
function BinarySearch(const DataSortedAscending: array of Integer;
 const ElementValueWanted: Integer): Integer;
var
    MinIndex, MaxIndex: Integer;
    { When optimizing remove these variables: }
    MedianIndex, MedianValue: Integer;
begin
    MinIndex := Low(DataSortedAscending);
    MaxIndex := High(DataSortedAscending);
    while MinIndex <= MaxIndex do begin
        MedianIndex := (MinIndex + MaxIndex) div 2; (* If you're going to change
         the data type here e.g. Integer to SmallInt consider the possibility of
         an overflow. All it needs to go bad is MinIndex=(High(MinIndex) div 2),
         MaxIndex = Succ(MinIndex). *)
        MedianValue := DataSortedAscending[MedianIndex];
        if ElementValueWanted < MedianValue then
            MaxIndex := Pred(MedianIndex)
        else if ElementValueWanted = MedianValue then begin
            Result := MedianIndex;
            Exit; (* Successful exit. *)
        end else
            MinIndex := Succ(MedianIndex);
    end;
    Result := -1; (* We couldn't find it. *)
end;