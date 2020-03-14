unit SunRaAppUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Menus;

type

  { TForm1 }

  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    First: TButton;
    MainMenu1: TMainMenu;
    FileMenu: TMenuItem;
    Second: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    StaticText1: TStaticText;
    ToggleBox1: TToggleBox;
    procedure CheckBox1Change(Sender: TObject);
    procedure FirstClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FileMenuClick(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure SecondClick(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);
    procedure ToggleBox1Change(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FirstClick(Sender: TObject);
begin
  StaticText1.Caption:= 'First button clicked';

end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  ToggleBox1.Enabled:= CheckBox1.Checked;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin



end;

procedure TForm1.FileMenuClick(Sender: TObject);
begin

end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin

end;

procedure TForm1.SecondClick(Sender: TObject);
begin
  StaticText1.Caption:= 'Second button clicked';

end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin
  StaticText1.Caption:= 'Radio button 1 clicked';

end;

procedure TForm1.RadioButton2Change(Sender: TObject);
begin
  StaticText1.Caption:= 'Radio button 2 clicked';

end;

procedure TForm1.StaticText1Click(Sender: TObject);
begin

end;

procedure TForm1.ToggleBox1Change(Sender: TObject);
begin

  StaticText1.Caption:= 'Toggle box state is ';

end;

end.

