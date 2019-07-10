program genpassword;
uses crt;
var
password, splash, kur, key, buk, buk_caps, simv_other, simv, namef, name_alph, name_alph_new:string;
settings:array[1..6] of byte;
i, c, b, d, r:integer;
setf:textFile;
flag, flag_alph:boolean;
begin
kur:='home';
settings[1]:=0;
settings[2]:=0;
settings[3]:=0;
settings[4]:=8;
settings[5]:=1;
settings[6]:=0;
flag_alph:=false;
flag:=false;
buk:='qwertyuiopasdfghjklzxcvbnm';
buk_caps:='QWERTYUIOPASDFGHJKLZXCVBNM';
simv_other:='_-#%/\|<>^[]~;*&=+'; 
simv:='';
  while true do begin
    clrscr; 
    writeln('Stone Password Generator');
    writeln('[Stolar Studio]   v0.6');writeln;
    writeln('<settings> - перейти к настройкам');
    writeln('<gen> - сгенерировать пароль по настройкам');
    writeln('<new> - создать свой алфавит ');
    writeln('<exit> - выйти из программы');
    writeln;  
    if kur = 'settings' then begin
      clrscr;
      writeln('<select n> - выбрать пункт(n - число)');
      writeln('<home> - вернуться к главной странице');
      writeln('<save> - сохранить текущие настройки');
      writeln('<open> - открыть файл с готовыми настройками');
      writeln('<import> - добавить свой алфавит');
      writeln('<reset> - сбросить настройки');
      writeln; writeln('  SETTINGS');
      writeln('1)использовать буквы(en) : ' + settings[1]);
      writeln('2)использовать caps : ' + settings[2]);
      writeln('3)использовать необычные символы : ' + settings[3]);
      writeln('4)символов в пароле : ' + settings[4]);
      writeln('5)использовать цифры : ' + settings[5]);
      if flag_alph = true then
        writeln('6)использовать свой алфавит (' + name_alph+') : ' + settings[6]);
      writeln;
    end;
    write('[' + kur + ']>' );
    readln(key);
    if ((key = 'settings') and not(kur = 'settings')) then kur := 'settings';
    if kur = 'settings' then
      if key = 'save' then begin
        write('file name :' );
        readln(namef);
        assign(setf, namef);
        rewrite(setf);
        for i := 1 to 5 do
          writeln(setf, settings[i]);
        close(setf);
      end else
      if key = 'open' then begin
        write('file name :' );
        readln(namef);
        assign(setf, namef);
        reset(setf);
        for i := 1 to 5 do
          readln(setf, settings[i]);
        close(setf);
      end else
      if key = 'select 1' then begin
        write('использовать буквы(en) : ');
        readln(settings[1]);
        if settings[1] < 0 then settings[1] := 0
        else if settings[1] > 1 then settings[1] := 1;
        end else
      if key = 'select 2' then begin
        write('использовать caps : ');
        readln(settings[2]); 
        if settings[2] < 0 then settings[2] := 0
        else if settings[2] > 1 then settings[2] := 1;
        end else
      if key = 'select 3' then begin
        write('использовать необычные символы : ');
        readln(settings[3]); 
        if settings[3] < 0 then settings[3] := 0
        else if settings[3] > 1 then settings[3] := 1;
        end else
      if key = 'select 4' then begin
        write('символов в пароле : ');
        readln(settings[4]); 
        if settings[4] < 1 then settings[4]:=1;
        end else
      if key = 'select 5' then begin
        write('использовать цифры : ');
        readln(settings[5]); 
        if settings[5] < 0 then settings[5] := 0
        else if settings[5] > 1 then settings[5] := 1;
        end else 
      if ((key = 'select 6') and (flag_alph = true)) then begin
        write('использовать свой алфавит :');
        readln(settings[6]);
        if settings[6] < 0 then settings[6] := 0
        else if settings[6] > 1 then settings[6] := 1;
      end else
      if key = 'import' then begin
        write('file name :' );
        readln(name_alph);
        assign(setf, name_alph);
        reset(setf);
          readln(setf, simv);
        close(setf);
        flag_alph := true;
      end else
      if key = 'reset' then begin
        settings[1]:=0;
        settings[2]:=0;
        settings[3]:=0;
        settings[4]:=8;
        settings[5]:=1;
        settings[6]:=0;
      end else if key = 'home' then begin
          kur:='home' ;
        end;
    if ((key = 'gen') and (kur = 'home')) then 
      if (settings[1] + settings[2] + settings[3] + settings[5] + settings[6]) > 0 then begin
        for i := 1 to settings[4] do begin
          repeat
            r := random(5);
            if ((r = 0) and (settings[5] = 1)) then begin
              password := password + random(10);
              flag := true;
            end else if ((r = 1) and (settings[1] = 1)) then begin
              d := random(26)+1;
              if d = 0 then d := 1;
              password := password + copy(buk,d,1);
              flag := true;
            end else if ((r = 2) and (settings[2] = 1)) then begin
              d := random(26)+1;
              if d = 0 then d := 1;
              password := password + copy(buk_caps,d,1);
              flag := true;
            end else if ((r = 3) and (settings[3] = 1)) then begin
              d := random(20)+1;
              if d = 0 then d := 1;
              password := password + copy(simv_other,d,1);
              flag := true;
            end else if ((r = 4) and (settings[6] = 1)) then begin
              d := random(length(simv))+1;
              password := password + copy(simv,d,1);
              flag := true;
            end else flag := false;
          until (flag)
        end;
        clrscr;writeln;
        writeln('ваш пароль : ' + password);
        writeln; writeln('Press enter... ');
        password := '';
        readln;
    end else begin
      clrscr;writeln;
      writeln('Error settings');
      writeln; writeln('Press enter... ');
      readln;
    end else if key = 'new' then begin
      clrscr;
      write('Название будущего алфавита : ');
      readln(name_alph_new);
      clrscr;
      writeln('Вводите символы которые будут в алфавите');
      writeln('Например : ABCabcGg123');
      writeln('После нажмите enter');writeln;
      write('editor[' + name_alph_new + ']>');
      readln(key);
      assign(setf, name_alph_new);
      rewrite(setf);
      writeln(setf, key);
      close(setf);
      clrscr;
      writeln('Ваш алфавит с названием ' + name_alph_new + ' был сохранён ');
      writeln;writeln('Press enter... ');
      readln;
    end else if key = 'exit' then break;
  end;
end.
