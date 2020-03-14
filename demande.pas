program Demande;
uses
     CGI,Dos;

{***********************************************}
{ Process the fields from "DOSSIER.HTM"         }
{ An acknoledgment message is sent to the user  }
{ and the data is stored into a file.           }
{***********************************************}

  procedure makemail;
  var
     Nom, Prenom,
     Adresse, Ville, Code, Phone,
     Diplome, Annee, Etab : string;
     F : text;
     year,month,day,dayofweek : word;

  begin
    Nom     := valeur('Nom');
    Prenom  := Valeur('Prenom');
    Adresse := Valeur('Adresse');
    Ville   := Valeur('Ville');
    Code    := Valeur('Code');
    Phone   := Valeur('Phone');
    Diplome := Valeur('Diplome');
    Annee   := Valeur('Annee');
    Etab    := Valeur('Etablissement');

    writeln ('<h2>Votre demande a ete enregistree</h2>');
    writeln (Prenom,' ',Nom,'<br>');
    writeln (Adresse,'<br>');
    writeln (Code,' ',Ville,'<br>');

    assign(F,'demandes.txt'); append(F);
    GetDate(year,month,day,dayofweek);
    writeln(F,'date:',day,'/',month,'/',year);
    writeln(F,Prenom,' ',Nom);
    writeln(F,Adresse);
    writeln(F,Code,' ',Ville);
    writeln(F,'tel. ',Phone);
    writeln(F,Diplome,' ',Annee);
    writeln(F,Etab);
    writeln(F);
    close(F);

  end;

begin
  startCGI;

  writeln('Content-type: text/html'); writeln;
  writeln('<HTML>');
  writeln('<head>');
  writeln('<title>DEA THERMIQUE ET SYSTEME ENERGETIQUE</title>');
  writeln('</head>');
  writeln('<body>');

  GetEnvironment;
{  ListEnv;}

  GetDataList;
{  ListData;}


  makemail;

  writeln('</body></html>');

  stopCGI;

end.
