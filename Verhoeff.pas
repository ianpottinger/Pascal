// <summary>
// For more information cf. http://en.wikipedia.org/wiki/Verhoeff_algorithm
// Dihedral Group stuff: http://en.wikipedia.org/wiki/Dihedral_group
// Dihedral Group order 10: http://mathworld.wolfram.com/DihedralGroupD5.html
// </summary>
const
  // The multiplication table
  Verhoeff_D: array[0..9, 0..9] of Integer = (
    (0, 1, 2, 3, 4, 5, 6, 7, 8, 9),
    (1, 2, 3, 4, 0, 6, 7, 8, 9, 5),
    (2, 3, 4, 0, 1, 7, 8, 9, 5, 6),
    (3, 4, 0, 1, 2, 8, 9, 5, 6, 7),
    (4, 0, 1, 2, 3, 9, 5, 6, 7, 8),
    (5, 9, 8, 7, 6, 0, 4, 3, 2, 1),
    (6, 5, 9, 8, 7, 1, 0, 4, 3, 2),
    (7, 6, 5, 9, 8, 2, 1, 0, 4, 3),
    (8, 7, 6, 5, 9, 3, 2, 1, 0, 4),
    (9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
  );
 
  // The permutation table
  Verhoeff_P: array[0..7, 0..9] of Integer = (
    (0, 1, 2, 3, 4, 5, 6, 7, 8, 9),
    (1, 5, 7, 6, 2, 8, 3, 0, 9, 4),
    (5, 8, 0, 3, 7, 9, 6, 1, 4, 2),
    (8, 9, 1, 6, 0, 4, 3, 5, 2, 7),
    (9, 4, 5, 3, 1, 2, 6, 8, 7, 0),
    (4, 2, 8, 6, 5, 7, 3, 9, 0, 1),
    (2, 7, 9, 3, 8, 0, 6, 4, 1, 5),
    (7, 0, 4, 6, 9, 1, 3, 2, 5, 8)
  );
 
  // The inverse table
  Verhoeff_inv: array[0..9] of Integer = (0, 4, 3, 2, 1, 5, 6, 7, 8, 9);
 
type
  TIntArray = array of Integer;
 
function ReverseArray(Num: String): TIntArray;
var
  i, Cnt: Integer;
begin
  Cnt := 0;
  for i := 1 to Length(Num) do
    if (Num[i] >= '0') and (Num[i] <= '9') then
      Inc(Cnt);
 
  SetLength(Result, Cnt);
 
  if Cnt = 0 then
    Exit;
 
  for i := 1 to Length(Num) do
    if (Num[i] >= '0') and (Num[i] <= '9') then begin
      Dec(Cnt);
      Result[Cnt] := Ord(Num[i]) - $30;
    end;
end;
 
// <summary>
// Validates that an entered number is Verhoeff compliant.
// NB: Make sure the check digit is the last one!
// </summary>
// <param name="num"></param>
// <returns>True if Verhoeff compliant, otherwise false</returns>
function ValidVerhoeff(Num: String): Boolean;
var
  i, c: Integer;
  myArray: TIntArray;
begin
  myArray := ReverseArray(Num);
 
  // Calulate check sum
  c := 0;
  for i := 0 to High(myArray) do
    c := Verhoeff_D[c, Verhoeff_P[i mod 8, myArray[i]]];
 
  Result := c = 0;
end;
 
// <summary>
// For a given number generates a Verhoeff digit
// Append this check digit to num
// </summary>
// <param name="num"></param>
// <returns>Verhoeff check digit as string</returns>
function CalcVerhoeff(Num: String): Char;
var
  i, c: Integer;
  myArray: TIntArray;
begin
  myArray := ReverseArray(Num);
 
  // Calulate check digit
  c := 0;
  for i := 0 to High(myArray) do
    c := Verhoeff_D[c, Verhoeff_P[(i + 1) mod 8, myArray[i]]];
 
  Result := Chr(Verhoeff_inv[c] + $30);
end;