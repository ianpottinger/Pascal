Procedure BubbleSort(numbers : Array of Integer; size : Integer);
Var i, j, temp : Integer;


Begin
 For i := size-1 DownTo 1 do
  For j := 2 to i do
   If (numbers[j-1] > numbers[j]) then
    Begin
     temp := numbers[j-1];
     numbers[j-1] := numbers[j];
     numbers[j] := temp;
    End;

End.


(*
Procedure BubbleSorter:

const
  MAXINTARRAY    : 1000; { Set this value to fit your data needs for max array size }
  STARTINTARRAY  : 1;    { Set 1 _or_ 0; indicates the lower index of the array }
Type
  IntArray : Array[STARTINTARRAY..MAXINTARRAY] of integer;

BubbleSort is an all purpose sorting procedure that is passed an array of
integers and returns that same array with the array elements sorted as desired.

Parameters are used to control the sorting operation:

If you want to sort the entire array, pass a value in Count that signals the number
of elements you want sorted. BubbleSort will then sort Count number of elements starting 
with the first element in the array. 

If you want to sort a subset of elements within the array, pass 0 in Count and pass
a beginning and ending subset index number in First and Last, respectively.

The sort will be either ascending or descending as controlled by the parameter Ascend:

Pass True in Ascend and the sort will be ascending. Pass False and the sort will be 
descending.

Data: The array to be sorted.

NOTE: Sample is a var and will be modified by BubbleSort, unless the array is 
already in a sorted state.

Count:  0 _or_ the number of elements to be sorted, starting with the first element.

First:  The first element to be sorted in a subset of the array.

Last:   The last element to be sorted in a subset of the array.

Ascend:  Flag to indicate the sort order. True is ascending order. False is descending.

Succ:   Flag returns result of BubbleSort

0 = success.

1 = Failed. Parameter First has value below allowed first index value.

2 = Failed. Parameter Last has value above allowed last index value.

3 = Failed. Parameter Last has value below allowed first index value.

===================================================================================*)
 Procedure BubbleSorter( 
                       Var Data : IntArray;
                       Count    : integer;
                       First    : integer;
                       Last     : integer;
                       Acend    : boolean;
                       Var Succ : integer );
 
 var 
   i,
   temp, 
   s_begin, 
   s_end,
   numsort : integer;
   sorted  : boolean;
 
 Begin
   { initialize for full array sort }
   s_begin := STARTINTARRAY;
   s_end   := STARTINTARRAY + count - 1 ;
   numsort := Count;
   Succ    := 0;    { assume success }
 
   { check for a subset sort; check parameters for correctness }
   if (Count = 0) then 
     Begin
       If (First < STARTINTARRAY) then 
       Begin { error: sort start index too low }
         Succ := 1;
         Exit;
       End;
       If (Last > MAXINTARRAY) then
       Begin { error: sort end index too high }
         Succ := 2;
         Exit;
       End;
       if (Last < STARTINTARRAY) then 
       Begin { error: sort end index too low }
         Succ := 3;
         Exit;
       End;
       s_begin := First;
       s_end   := Last;
       numsort := Last - First + 1;
     End;
   If numsort <= 1 then Exit; { only one element, so exit }
 
   If Acend then
   Begin { do the ascending sort }
     Repeat
       sorted := true; { flag default is true }
       For i := s_begin to s_end -1 do
         if (Data[i] < Data[i+1]) then
         Begin
           { swap contents of Data[i] and Data[i+1] }
           temp      := Data[i];
           Data[i]   := Data[i+1];
           Data[i+1] := temp;
           { set flag to indicate a swap occured; i.e., sort may not be completed }
           sorted := false;
         End;
     Until sorted;
   End Else
   Begin { do the descending sort }
     Repeat
       sorted := true; { flag default is true }
       For i := s_begin to s_end -1 do
         if (Data[i] < Data[i+1]) then
         Begin
           { swap contents of Data[i] and Data[i+1] }
           temp      := Data[i];
           Data[i]   := Data[i+1];
           Data[i+1] := temp;
           { set flag to indicate a swap occured; i.e., sort may not be completed }
           sorted := false;
         End;
     Until sorted;
   End;
 End;
 