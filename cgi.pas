unit CGI;

{========================================================================}
{                                                                        }
{ Interfacing with CGI.                                                  }
{ --------------------                                                   }
{                                        }
{ This unit provides routines                                            }
{   . to analyse the content of the environment variables                }
{   . to parse the QUERY string (GET) or standard input (POST)                                   }
{   . to return the value of a given variable                            }
{                                                                        }
{ Both environment and data are returned as lists of                     }
{ (name, data)                                                           }
{ Lists are implemented as TP's COLLECTION, you might want               }
{ to check the main methods in your manual.                              }
{ You can inspect the code for Valeur to get an idea how it works.       }
{ However, all you want is probably provided in the functions hereafter. }
{                                                                        }
{ This unit should be compiled with Turbo 7.0 or equivalent              }
{ (I mean, *not* Pascal for Windows)                                     }
{                                                                        }
{========================================================================}
{

  This software has been tested using Turbo Pascal 7.0 and
  Internet Information Server on a PC running NT server 4.0

  You are free to use, modify and distribute it without restrictions.
  However, if you do, please let me know : candau@univ-paris12.fr
  I am doing this to promote Pascal programming and I'd like to know
  if it's worth my while.

}
{ MODIFICATIONS
  23/02/99
   - CGI now works whether a GET or a POST method is used.
     This is transparent to the user.
   - StartCGI automatically calls GetData and GetEnvList, so
     you no longer have to do it yourself
}


{
   USAGE :

   procedure StartCGI : should be called at the start of your program.
                        Inits the variables EnvList and DataList.

   procedure StopCGI  : must be called at the end of your program,
                        if you have called StartCGI at the start.
                        Frees the variables.

   function Valeur(name) : returns the data (a string) for the variable
                           name.

   procedure ListEnv

   procedure ListData


}

interface
uses objects,dos;

type dataPtr=^data;
     data = record
              name : string;
              data : string;
            end;

     dataCollection = object(TCollection)
         procedure Freeitem (P: pointer); virtual;
     end;

     PstringCollection = ^stringCollection;
     stringCollection = object(TCollection)
         procedure Freeitem (P: pointer); virtual;
     end;

     strptr = ^string;

var  dataList : dataCollection;
     envList  : dataCollection;

     nb_env : integer;

procedure startCGI;

procedure stopCGI;

procedure ListEnv;

procedure ListData;

function  Valeur (S : string):string;

function Valenv (S : string): string;

{-------------------------------------------------------}
implementation


procedure stringCollection.FreeItem (P:pointer);
begin
  dispose (strptr(P));
end;

procedure dataCollection.FreeItem (P:pointer);
begin
  dispose (dataptr(P));
end;

{------------------------------------------}
{ un-escape special chars in html string   }
{    '+' -> ' '                            }
{    %IJ -> chr(IJ)                        }
{------------------------------------------}
procedure UnEscape (var S : string);
var
    V:string;
    C:string;

    { integer value of hexadecimal 2-digit string }
    function Hex(S:string) : integer;

       { integer value of hexa digit 0..F }
       function ch2ascii(C:char) : integer;
       begin
         if C in ['0'..'9'] then ch2ascii := ord(C)-ord('0')
         else
         if C in ['A'..'F'] then ch2ascii := ord(C)-ord('A')+10
       end;

    begin
       Hex := ch2ascii(S[1])*16
             +ch2ascii(S[2]);
    end;

begin { unescape }
  while pos('+',S)<>0 do S[pos('+',S)]:=' ';
  while pos('%',S)<>0 do begin
    V:=copy(S,pos('%',S)+1,2);
    C:=' ';
    C[1]:= chr(Hex(V));
    insert(C,S,pos('%',S));
    delete(S,pos('%',S),3);
  end;
end;

procedure Escape (var S : string);
begin

end;

{-------------------------------}
{ split a string into 2 strings }
{-------------------------------}
procedure SplitString (S:string; C : char; var head,queue : string);
var
    Index : integer;
begin
   head:=''; queue:='';
   Index := pos(C,S);
   if Index=0 then Index:=length(S)+1;
   head := copy(S,1,Index-1);
   delete(S,1,Index);
   queue := S;
   Unescape(head);
   Unescape(queue);
end;

{----------------------------}
{ split a string into a list }
{----------------------------}
function Split(S : string; C : char) : PstringCollection;
var
    Index : integer;
    S1 : strptr;
    List : PstringCollection;
begin
  new(List); List^.Init(20,10);
  while S<>'' do begin
   new(S1);
   SplitString(S,C,S1^,S);
   List^.Insert(S1);
  end;
  Split := List;
end;

{------------------------------------------------}
{ extracts name & data from a string 'name=data' }
{ and puts them in a list                        }
{------------------------------------------------}
procedure GetData (S:String; var L:TCollection);
var P: dataPtr;
begin
  new(P);
  with P^ do
  SplitString (S,'=',name,data);
  L.insert(P);
end;

{------------------------------------------}
{ gets data list from parsing query_string }
{------------------------------------------}
procedure GetDataList;

   procedure GetDatum (S:StrPtr); far;
   begin
     GetData (S^,dataList);
   end;

var ListP : PstringCollection;
    S : string;
    L,Err,I : integer;
    C : char;
begin
  S:=GetEnv('QUERY_STRING');
  if S<>'' then begin
    writeln('GET<br>');
    ListP := Split(S,'&');
    ListP^.foreach(@GetDatum);
    ListP^.done;
    dispose(ListP);
  end
  else begin
    writeln('POST<br>');
    writeln(GetEnv('CONTENT_LENGTH'),'<br>');
    val(GetEnv('CONTENT_LENGTH'),L,Err);
    writeln('L:',L,' ',Err,'<br>');
    if Err=0 then begin
      S:='';
      for I:=1 to L do begin
        read(C); S:=S+C;
      end;
      writeln('S:',S);
      ListP := Split(S,'&');
      ListP^.foreach(@GetDatum);
      ListP^.done;
      dispose(ListP);
    end;
  end;
end;

{----------------------------------}
{ lists parameters for the script. }
{ especially useful for debugging  }
{----------------------------------}
procedure ListData;
  procedure Print (P:dataPtr); far;
  begin
    writeln(P^.name,'=',P^.data,'<br>');
  end;
begin
  writeln('<code>');
  dataList.foreach(@print);
  writeln('</code>');
end;

{---------------------------------}
{ gets environment variables list }
{---------------------------------}
procedure GetEnvList;
var P : dataPtr;
    I : integer;
    S : string;
begin
  nb_env := EnvCount;
  for I:=1 to nb_env do begin
     S := EnvStr(I);
     GetData(S,envList);
  end;
end;

{-----------------------------------}
{ lists environment variables.      }
{ especially useful for debugging   }
{-----------------------------------}
procedure ListEnv;
  procedure Print (P:dataPtr); far;
  begin
    writeln(P^.name,'=',P^.data,'<br>');
  end;
begin
  writeln('<code>');
  envList.foreach(@Print);
  writeln('</code>');
end;

{----------------------------------------------------}
{  returns the value for the variable with name "S"  }
{----------------------------------------------------}
function Find(S : string; List:dataCollection):string;
var
    requested_name : string;

    function Matches(P:dataPtr):boolean; far;
       begin
         Matches := P^.name=requested_name;
       end;

    begin
      requested_name := S;
      if List.FirstThat(@Matches)<>nil then
      Find :=  dataPtr(List.FirstThat(@Matches))^.data
      else Find:='';
    end;

function Valeur (S : string):string;
begin
  Valeur:=Find(S,DataList);
end;

function Valenv (S : string):string;
begin
  ValEnv:=Find(S,EnvList);
end;

procedure startCGI;
begin
  dataList.init(20,10);
  envList.init(20,10);
  GetEnvList;
  GetDataList;
end;

procedure stopCGI;
begin
  dataList.done;
  envList.done;
end;




begin


end.