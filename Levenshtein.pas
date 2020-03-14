function Levenshtein(Word1, Word2: String): integer;
var lev : array of array of integer;
    i,j : integer;
    s : string;
begin
  result := 0;
  // If the words are identical, do nothing
  if LowerCase(Word1) = LowerCase(Word2) then
  exit;
 
  SetLength(lev, length(Word1) + 1);
  for i := low(lev) to high(lev) do
    setLength(lev[i], length(Word2) + 1);
 
  for i := low(lev) to high(lev) do lev[i][0] := i;
  for j := low(lev[low(lev)]) to high(lev[low(lev)]) do lev[0][j] := j;
 
  for i := low(lev)+1 to high(lev) do
    for j := low(lev[i])+1 to high(lev[i]) do
      lev[i][j] := min(min(lev[i-1][j] + 1,lev[i][j-1] + 1)
                      ,lev[i-1][j-1] + ifthen(Word1[i] = Word2[j], 0, 1));
 
  result := lev[length(word1)][length(word2)];
 
end;