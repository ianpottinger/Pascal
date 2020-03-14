{ Copyright (c) 2012 the authors listed at the following URL, and/or
the authors of referenced articles or incorporated external code:
http://en.literateprograms.org/Kruskal's_algorithm_(Pascal)?action=history&offset=20060725200719

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Retrieved from: http://en.literateprograms.org/Kruskal's_algorithm_(Pascal)?oldid=7052
}

unit ModSet;{$MODE DELPHI}{$r+}

interface

const 
  nVertices = 10;


procedure InitFirst (n : integer);
procedure Merge (a, b : integer);
function Find (x : integer) : integer;


implementation
type
MFSetRec = record
  setHeaders : array[1..nVertices] of record
    count : integer;
    firstElement : integer;
  end;
  names : array[1..nVertices] of record
    setName : integer;
    nextElement : integer;
  end;
end;

var
  MFSet : MFSetRec;

procedure Initial (a, x : integer);
begin
  MFSet.names[x].setName := a;
  MFSet.names[x].nextElement := 0;
  MFSet.setHeaders[a].count := 1;
  MFSet.setHeaders[a].firstElement := x
end;

function Find (x : integer) : integer;
begin
  find := MFSet.names[x].setName
end;

procedure Merge (a, b : integer);
var
  i, temp : integer;
begin
  if MFSet.setHeaders[b].count > MFSet.setHeaders[a].count then
    begin temp := a; a := b; b := temp end;
  i := MFSet.setHeaders[b].firstElement;
  while MFSet.names[i].nextElement <> 0 do
  begin
    MFSet.names[i].setName := a;
    i := MFSet.names[i].nextElement
  end;
  MFSet.names[i].setName := a;
  MFSet.names[i].nextElement := MFSet.setHeaders[a].firstElement;
  MFSet.setHeaders[a].firstElement := MFSet.setHeaders[b].firstElement;
  MFSet.setHeaders[a].count := MFSet.setHeaders[a].count + MFSet.setHeaders[b].count
end;

procedure InitFirst (n : integer);
  var i : integer;
begin
  for i := 1 to n do
    Initial (i, i)
end;


begin
end.


