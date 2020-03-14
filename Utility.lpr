program Utility;

{$mode objfpc}{$H+}

uses
  crt, process,
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp,
  DateUtils
  { you can add units after this };

type

  { TMyApplication }

  person = record
    given, family: string;
    sex: string;
    age: integer;
    wage: real;
  end;

  TMyApplication = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TMyApplication }


function inputInteger(prompt: string; low: integer; high: integer):integer;
var
  error: integer;
  input: string;
  whole: integer;
  questionX: byte;
  questionY: byte;
  answerX: byte;
  answerY: byte;

begin
  questionX := WhereX; questionY := WhereY;
  repeat
    gotoxy(questionX, questionY);
    write(prompt, '(between ', low, ' and ', high, ' inclusive): ');
    answerX := WhereX; answerY := WhereY;
    gotoxy(answerX, answerY);
    readln(input);
    val(input, whole, error);
    writeln(input, ' was entered. ');
    if (error <> 0) or (whole <= low) or (whole >= high) then
    begin
      writeln('Try please again!');
      textcolor(Black);
      gotoxy(answerX, answerY);
      write(input);
      textcolor(White);
      gotoxy(answerX, answerY);
    end;
  until (error = 0) and (whole >= low) and (whole <= high);
  inputInteger := whole;
end;

function inputFloat(prompt: string; low: real; high: real):real;
var
  error: integer;
  input: string;
  float: real;
  questionX: byte;
  questionY: byte;
  answerX: byte;
  answerY: byte;

begin
  questionX := WhereX; questionY := WhereY;
  repeat
    gotoxy(questionX, questionY);
    write(prompt, '(between ', low, ' and ', high, ' inclusive): ');
    answerX := WhereX; answerY := WhereY;
    gotoxy(answerX, answerY);
    readln(input);
    val(input, float, error);
    writeln(input, ' was entered. ');
    if (error <> 0) or (float <= low) or (float >= high) then
    begin
      writeln('Try please again!');
      textcolor(Black);
      gotoxy(answerX, answerY);
      write(input);
      textcolor(White);
      gotoxy(answerX, answerY);
    end;
  until (error = 0) and (float >= low) and (float <= high);
  inputFloat := float
end;

function inputString(prompt: string; low: integer; high: integer):string;
var
  response: string;
  measure: integer;
  questionX: byte;
  questionY: byte;
  answerX: byte;
  answerY: byte;

begin
  questionX := WhereX; questionY := WhereY;
  repeat
    gotoxy(questionX, questionY);
    write(prompt);
    answerX := WhereX; answerY := WhereY;
    gotoxy(answerX, answerY);
    readln(response);
    measure := length(response);
    if (measure <= low) or (measure >= high) then
    begin
      writeln('Try please again!');
      textcolor(Black);
      gotoxy(answerX, answerY);
      write(input);
      textcolor(White);
      gotoxy(answerX, answerY);
    end;
  until (measure >= low) and (measure <= high);
  inputString := response
end;

procedure summary();
var
  loop: integer;
  index : array[1..10] of integer;

begin

  randomize;
  for loop := 1 to 10 do
  begin
    index[loop] := random(100);
  end;

  for loop := 1 to 10 do
  begin
    write(index[loop]);
  end;

end;

procedure clutterandom();
var
  loop: integer;
  start: TProcess;
begin
  randomize;

  start:= TProcess.Create(nil);
  start.CommandLine:= 'calc.exe';
  start.Execute;
  start.Free;

  for loop := 1 to 80*25 do
  begin
    textcolor(random(16));
    textbackground(random(16));
    gotoxy(random(80), random(25));
    write(random(100));
  end;
  TextColor(White);
  TextBackground(Black);
  readln;

end;

procedure cards();
var
  rank: array[1..13] of string = (' 2', ' 3', ' 4', ' 5', ' 6',
                        ' 7', ' 8', ' 9', '10',
                        ' J',' Q',' K',' A');
  suit: array[1..4] of string = ('D', 'S', 'H', 'C');
  deck: array[1..4,1..13] of string;
  row: integer;
  column: integer;
begin
  clrscr;
  for row := 1 to 4 do
  begin
      for column := 1 to 13 do
      begin
          deck[row,column] := suit[row] + rank[column];
          gotoxy(column * 5, row * 2);
          write(deck[row, column]);
      end;
      writeln();
  end;
  readln;
end;


function readFile(filename: string): string;
var
  datafile: textfile;
  filedata: string;
  linedata: string;

begin
  assignfile(datafile, filename);
  filedata:= 'Seeing this means reading the file failed!';
  try
    reset(datafile);
    filedata:= '';
    while not EoF(datafile) do
    begin
        readln(datafile, linedata);
        filedata:= filedata + linedata;
        writeln(linedata);
    end;
    close(datafile);
    readFile:= filedata;
  except
    writeln('Error reading from file');
  end;
end;

procedure writeFile(filename, content: string);
var
  datafile: textfile;

begin
  assignfile(datafile, filename);
  try
    rewrite(datafile);
    writeln(datafile, content);
    close(datafile);
  except
    writeln('Error writing to file!');
  end;
end;

procedure TMyApplication.DoRun;
var
  ErrorMsg: string;
  details: person;

  Epoch: longint;
  timestring: string;
  question: string;
  low: integer;
  high: integer;
  day: integer;
  month: integer;
  year: integer;
  sex: string;
  error: integer;
  PronounsFile: string;
  pronouns: string;

begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h','help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h','help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  PronounsFile:= 'G:\WorkingData\Work @ Home\Humanity\pronouns2.txt';
  pronouns:= readfile(PronounsFile);
  writeln(pronouns);

  Epoch := DateTimetoUnix(Now);
  writeln(Epoch);
  timestring := DateTimeToStr(UnixToDateTime(Epoch));
  writeln(timestring);
  Epoch := DateTimeToUnix(StrToDateTime(timestring));
  writeln(Epoch);
  readln;

  error := 0;
  randomize;
  writeln('My first pascal console program');
  clutterandom();
  cards();
  summary();

  details.given := inputString('Enter your given name: ', 1, 20);

  details.family := inputString('Enter your family name: ', 1, 20);

  details.sex := inputString('Male or female: ', 1, 1);
  writeln(sex);
  case sex of
  'M', 'm':
    begin
         Writeln('male ');
    end;
  'F', 'f':
    begin
         Writeln('female ');
    end;
  else
      begin
           writeln('Unknown ');
      end;
  end;

  repeat
    question := 'Enter day of birth: ';
    low := 1;
    high := 31;
    day := inputInteger(question, low, high);
    case day of
    1..31:
      begin
           writeln('Valid day ', day);
      end;
    else
        begin
             writeln('Invalid day entered! ', error);
        end;
    end;
  until (day >= 1) and (day <= 31);

  repeat
    question := 'Enter month of birth: ';
    low := 1;
    high := 12;
    month := inputInteger(question, low, high);
    case month of
    1..12:
      begin
           writeln('Valid month ', month);
      end;
    else
        begin
             writeln('Invalid month entered! ', error);
        end;
    end;
  until (month >= 1) and (month <= 12);

  repeat
    question := 'Enter year of birth: ';
    low := 1881;
    high := 2020;
    year := inputInteger(question, low, high);
    case year of
    1881..2020:
      begin
           writeln('Valid year ', month);
      end;
    else
        begin
             if year > 2015 then
             begin
               writeln('Not possible to be from the future! ', year);
             end;
             if year < 1919 then
             begin
               writeln('That is really old! ', year);
             end;
             writeln('Invalid year entered! ', error);
        end;
    end;
  until (error = 0) and (year >= 1919) and (year <= 2002);




  // stop program loop
  Terminate;
end;

constructor TMyApplication.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TMyApplication.Destroy;
begin
  inherited Destroy;
end;

procedure TMyApplication.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ',ExeName,' -h');
end;

var
  Application: TMyApplication;
begin
  Application:=TMyApplication.Create(nil);
  Application.Title:='My Application';
  Application.Run;
  Application.Free;
end.

