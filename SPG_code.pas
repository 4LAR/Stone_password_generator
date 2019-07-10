program genpassword;
uses crt;
var
password, splash, kur, key, buk, buk_caps, simv_other, namef, name_alph_new, info_alph_new, info_alph, simv_alph:string;
settings:array[1..8] of byte;
name_alph:array[1..3] of string;
simv:array[1..3] of string;
flag_alph:array[1..3] of boolean;
i, c, b, d, r:integer;
setf:textFile;
flag:boolean;
begin
kur:='home';
settings[1]:=0;
settings[2]:=0;
settings[3]:=0;
settings[4]:=8;
settings[5]:=1;
settings[6]:=0;
settings[7]:=0;
settings[8]:=0;
flag_alph[1]:=false;
flag_alph[2]:=false;
flag_alph[3]:=false;
flag:=false;
buk:='qwertyuiopasdfghjklzxcvbnm';
buk_caps:='QWERTYUIOPASDFGHJKLZXCVBNM';
simv_other:='_-#%/\|<>^[]~;*&=+'; 
simv[1]:='';
//сюды чтение и создание файла с настройками
  
//
  while true do begin
    clrscr; 
    writeln('Stone Password Generator');
    writeln('[Stolar Studio]   v0.7');writeln;
    writeln('<settings> - перейти к настройкам');
    writeln('<gen> - сгенерировать пароль по настройкам');
    writeln('<new> - создать свой алфавит ');
    writeln('<info> - информация о алфавите');
    writeln('<exit> - выйти из программы');
    writeln;  
    if kur = 'settings' then begin
      clrscr;
      writeln('<select n> - выбрать пункт(n - число)');
      writeln('<home> - вернуться к главной странице');
      writeln('<save> - сохранить текущие настройки');
      writeln('<open> - открыть файл с готовыми настройками');
      writeln('<import n> - добавить свой алфавит(n - от 1 до 3)');
      writeln('<reset> - сбросить настройки');
      writeln; writeln('  SETTINGS');
      writeln('1)использовать буквы(en) : ' + settings[1]);
      writeln('2)использовать caps : ' + settings[2]);
      writeln('3)использовать необычные символы : ' + settings[3]);
      writeln('4)символов в пароле : ' + settings[4]);
      writeln('5)использовать цифры : ' + settings[5]);
        writeln('6)использовать свой алфавит(1) (' + name_alph[1] +') : ' + settings[6]);
        writeln('7)использовать свой алфавит(2) (' + name_alph[2] +') : ' + settings[7]);
        writeln('8)использовать свой алфавит(3) (' + name_alph[3] +') : ' + settings[8]);
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
      if ((key = 'select 6') and (flag_alph[1] = true)) then begin
        write('использовать свой алфавит(1) :');
        readln(settings[6]);
        if settings[6] < 0 then settings[6] := 0
        else if settings[6] > 1 then settings[6] := 1;
      end else
      if ((key = 'select 7') and (flag_alph[2] = true)) then begin
        write('использовать свой алфавит(2) :');
        readln(settings[7]);
        if settings[7] < 0 then settings[7] := 0
        else if settings[7] > 1 then settings[7] := 1;
      end else
      if ((key = 'select 8') and (flag_alph[3] = true)) then begin
        write('использовать свой алфавит(3) :');
        readln(settings[8]);
        if settings[8] < 0 then settings[8] := 0
        else if settings[8] > 1 then settings[8] := 1;
      end else
      if key = 'import 1' then begin
        write('file name :' );
        readln(name_alph[1]);
        assign(setf, name_alph[1]);
        reset(setf);
          readln(setf, simv[1]);
        close(setf);
        flag_alph[1] := true;
      end else
      if key = 'import 2' then begin
        write('file name :' );
        readln(name_alph[2]);
        assign(setf, name_alph[2]);
        reset(setf);
          readln(setf, simv[2]);
        close(setf);
        flag_alph[2] := true;
      end else
      if key = 'import 3' then begin
        write('file name :' );
        readln(name_alph[3]);
        assign(setf, name_alph[3]);
        reset(setf);
          readln(setf, simv[3]);
        close(setf);
        flag_alph[3] := true;
      end else
      if key = 'reset' then begin
        settings[1]:=0;
        settings[2]:=0;
        settings[3]:=0;
        settings[4]:=8;
        settings[5]:=1;
        settings[6]:=0;
        settings[7]:=0;
        settings[8]:=0;
      end else if key = 'home' then begin
          kur:='home' ;
        end;
    if ((key = 'gen') and (kur = 'home')) then 
      if (settings[1] + settings[2] + settings[3] + settings[5] + settings[6] + settings[7] + settings[8]) > 0 then begin
        for i := 1 to settings[4] do begin
          repeat
            r := random(7);
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
              d := random(length(simv[1]))+1;
              password := password + copy(simv[1],d,1);
              flag := true;
            end else if ((r = 5) and (settings[7] = 1)) then begin
              d := random(length(simv[2]))+1;
              password := password + copy(simv[2],d,1);
              flag := true;
            end else if ((r = 6) and (settings[8] = 1)) then begin
              d := random(length(simv[3]))+1;
              password := password + copy(simv[3],d,1);
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
      clrscr;
      writeln('Введите описание вашего алфавита');
      writeln('В одну строку');writeln;
      write('editor[' + name_alph_new + ']>');
      readln(info_alph_new);
      assign(setf, name_alph_new);
      rewrite(setf);
      writeln(setf, key);
      writeln(setf, info_alph_new);
      close(setf);
      clrscr;
      writeln('Ваш алфавит с названием ' + name_alph_new + ' был сохранён ');
      writeln;writeln('Press enter... ');
      readln;
    end else
    if key = 'info' then begin
      write('file name :');
      readln(key);
      assign(setf, key);
      reset(setf);
      readln(setf, simv_alph);
      readln(setf, info_alph);
      close(setf);
      clrscr;
      writeln('Название алфавита : ' + key);
      writeln('Описание :' + info_alph);writeln;
      writeln('Символы :' + simv_alph);writeln;
      writeln('Press enter... ');
      readln;
    end else if key = 'exit' then break;
      //через каждую комманду сохранять текущие настройки
        
      //
  end;
end.
