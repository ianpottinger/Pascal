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

unit ModEdges;{$MODE DELPHI}{$r+}

interface

const nEdges = 1024;

procedure AddEdge (a, b, w : integer);
function GetEdgeU (i : integer) : integer;
function GetEdgeV (i : integer) : integer;
function EdgeCount : integer;
function HighestVertex : integer;
procedure SortEdges;


implementation
 
type
  edge = record
    u, v, weight : integer;
  end;

  edgesRec = array[1..nEdges] of edge;

var
  edges : edgesRec;
  numEdges, vHighest : integer; 

procedure AddEdge (a, b, w : integer);
begin
  numEdges := numEdges + 1;
  if a > vHighest then vHighest := a;
  if b > vHighest then vHighest := b;
  edges[numEdges].u := a;
  edges[numEdges].v := b;
  edges[numEdges].weight := w
end;

function GetEdgeU (i : integer) : integer;
begin
  GetEdgeU := edges[i].u
end;

function GetEdgeV (i : integer) : integer;
begin
  GetEdgeV := edges[i].v
end;

function EdgeCount : integer;
begin
  EdgeCount := NumEdges
end;

procedure SortEdges;
var i, j : integer;
  key : edge;
begin
  for j := 2 to EdgeCount do
  begin
    key := edges[j];
    i := j - 1;
    while (i > 0) and (edges[i].weight > key.weight) do
    begin
      edges[i+1] := edges[i];
      i := i - 1
    end;
    edges[i+1] := key
  end
end;

function HighestVertex : integer;
begin
  HighestVertex := vHighest
end;


begin
  numEdges := 0
end.


