{ Copyright (c) 2012 the authors listed at the following URL, and/or
the authors of referenced articles or incorporated external code:
http://en.literateprograms.org/Logarithm_Function_(Pascal)?action=history&offset=20070203053426

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

Retrieved from: http://en.literateprograms.org/Logarithm_Function_(Pascal)?oldid=8804
}


program Logarithm; 

var
  a, b : integer; {''a'' is the number of decimal points of the mantissa we want the computer tocalculate}
  x, i : real;   {''b'' is the base, ''x'' is our value. We'll need ''i'' later}

begin

  writeln ('Enter the base "b" of your logarithm and press Enter');
  readln (b); 
  writeln ('Enter the value of your logarithm and press Enter');
  readln (x);  {Now the computer knows the base and the value of the expression}

  writeln ('How many decimal places (up to 16) should it have?'); 
                              {This is how precise you want the computer to be.}
                              {Unfortunately it can calculate only up to the 16-th digit}
  readln (a); 
  i := ln(x)/ln(b);  {Now we use our formula, that's why we need a new variable}
  writeln ('The base-',b, ' logarithm of ', x:3:3, ' = ', i:3:a); {Here is the output}
                                        {Digits mean how long the representation should be, ''a'' also treated as digit} 

  readln    {This is for you to have enough time to read the result}       

end. {The end:)}


