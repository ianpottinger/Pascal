{ Copyright (c) 2012 the authors listed at the following URL, and/or
the authors of referenced articles or incorporated external code:
http://en.literateprograms.org/Fibonacci_numbers_(Pascal)?action=history&offset=20071231030947

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

Retrieved from: http://en.literateprograms.org/Fibonacci_numbers_(Pascal)?oldid=11916
}


program Fibonacci;

var
  i, x, m, n : integer;

begin   {Begins the main part}

  writeln ('Enter the lenghts of the sequence');
  readln (x);
  n := 0; m:=1; {We have to initialize our sequence}
  writeln (n);  {and have the first output}
  writeln (m);
  i:=0;         {"i" is the number of the current iteration}


while i<x-2 do  {The first 2 "x's" we've already had
                 that's why we must get rid of them}

begin           {Begins the iteration loop}

  i:=i+1;
  m:=m+n; n:=m-n;
  writeln(m);

  if i=x-2 then writeln('Finished !');

                {The program has calculated everything
                 and lets us know about it}

end;            {The end of the while-do loop}

  readln;       {This is needed to have enough time
                 to read the output}

end.


