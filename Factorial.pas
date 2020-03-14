{ Copyright (c) 2012 the authors listed at the following URL, and/or
the authors of referenced articles or incorporated external code:
http://en.literateprograms.org/Factorial_(Pascal)?action=history&offset=20070203194655

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

Retrieved from: http://en.literateprograms.org/Factorial_(Pascal)?oldid=8821
}

program Factorial;
    {The program computes 0! through 170!}

var
  i, x : integer; {''i'' here stands for iteration}
  fact : real;    {Usually factorials are so large that we
                   can't use integer here}

Function FactorialIterative(n : Integer) : LongInt;
Var
    Result : LongInt;
    i : Integer;

Begin
 Result := n;
 If (n <= 1) then
  Result := 1
 Else
  For i := n-1 DownTo 1 do
   Result := Result * i;
 FactorialIterative := Result;
End;


Function FactorialRecursive(n : Integer) : Integer;
Var
    Result : Integer;

Begin
 If n = 1 then
  FactorialRecursive := 1 Else
  FactorialRecursive := n*FactorialRecursive(n-1);
End;



begin
  writeln ('Enter the value of the factorial');
  readln (x);
  fact:=1; {As we can't multiply by 0, our first number should be 1}

for i:=1 to x do  {Here is our loop}

   fact :=fact*i;
   writeln(x,'! is ',fact);


writeln(FactorialIterative(x));
writeln(FactorialRecursive(x));

readln; {The semicolon is not obligatory here}

end.


