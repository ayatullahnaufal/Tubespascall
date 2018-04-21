program tubesdapTERAKHIR;
//RESERVASI TIKET PENERBANGAN
uses crt;
type
        tiket = record
        hari,jam, nama : string;
        tgl, kode, kursi : integer;
        harga : longint;
end;
var
        i,j,x,n,k,temp,l : integer;
        penerbangan : array[0..88] of tiket;
        pnr : file of tiket;

        procedure buat;
        begin
                assign(pnr,'tiket.txt');
                rewrite(pnr);
                clrscr;
                close(pnr);
        end;
        procedure load;
        begin
                assign(pnr,'tiket.txt');
                reset(pnr);
                i:=1;
                while (not eof(pnr)) do
                begin
                        temp:=temp+1;
                        read(pnr,penerbangan[i]);
                        inc(i);
                end;
                readln;
                close(pnr);
        end;
        procedure save;
        var
                i : integer;
        begin
                assign(pnr,'tiket.txt');
                rewrite(pnr);
                for i:= 1 to temp do
                begin
                        write(pnr,penerbangan[i]);
                end;
                close(pnr);
        end;
        procedure input1;
        var
                yt,yy,yb : string;
                brs,bgs : integer;
                begin
                 temp := temp +1;
                 i := 1;
                 yt := 'Y';
                 while ((i <= 4)  and (yt = 'Y')) do
                 begin
                    writeln('==========RESERVASI=========');
                    readln;
                    write('Masukan Nama anda : ');
                    readln(penerbangan[temp].nama);
                    write('Masukan tanggal hari jam : ');
                    readln(penerbangan[temp].tgl,penerbangan[temp].hari,penerbangan[temp].jam);
                    penerbangan[temp].harga := 1200000;
                    writeln('Apakah anda ingin memesan bagasi ?(Y/T) ');
                    readln(yb);
                    if (yb = 'Y') then
                    begin
                        writeln('Masukan berat bagasi anda : ');
                        readln(bgs);
                        if (bgs<= 20) then
                            penerbangan[temp].harga := penerbangan[temp].harga + 200000
                        else if(bgs > 20) and (bgs <=40) then
                            penerbangan[temp].harga := penerbangan[temp].harga + 250000;
                    end;
                    writeln('Kursi tempat duduk anda ',x);
                    penerbangan[temp].kursi := x;
                    x := x-1;
                    writeln();
                    write('Apakah anda ingin pindah tempat kursi (Y/T) ? ');
                    readln(yy);
                    if (yy='Y') then
                    begin
                        write('Masukan nomor kursi : ');
                        readln(brs);
                        j := 1;
                       while(j<=88) and (penerbangan[temp].kursi <> brs) do 
                       begin
                        j:= j+1;
                       end;
                       if(j=89) then
                       begin
                        clrscr;
                        gotoxy(15,10);writeln('Kursi anda telah berpindah ke kursi nomor ',brs);
                        penerbangan[temp].kursi := brs;
                       end
                       else
                        writeln('Kursi sudah terisi');
                    end;
                        penerbangan[temp].kode := penerbangan[temp-1].kode + 1;
                        temp := penerbangan[temp].kode;
                    writeln();
                    writeln('SELAMAT ! Kode Booking anda : ',penerbangan[temp].kode); 
                    write('Apakah anda ingin menginputkan lagi (Y/T) : ');
                    readln(yt);
                    i:=i+1;   
                    k:= k +1;
                 end;
                end;
        procedure lihatbookcari;
        var
                book : integer;
        begin
                writeln('Masukan kode booking anda : ');
                readln(book);
                i := 1;
                repeat
                begin
                if (book = penerbangan[i].kode) then
                begin
                        writeln('Nama penumpang : ',penerbangan[i].nama);
                        writeln('Kursi          : ',penerbangan[i].kursi);
                        writeln('No Booking     : ',penerbangan[i].kode);
                        writeln('harga          : ',penerbangan[i].harga);
                        readln;
                end;
                i:= i+1;
                end;
                until ((book = penerbangan[i].kode) and (i>=88));
        end;
        procedure lihatbook;
        var
                book : integer;
        begin
                for i:= 1 to temp do
                begin
                        writeln('Nama penumpang : ',penerbangan[i].nama);
                        writeln('Kursi          : ',penerbangan[i].kursi);
                        writeln('No Booking     : ',penerbangan[i].kode);
                        writeln('harga          : ',penerbangan[i].harga);
                        writeln;
                end;
        end;
        procedure sorting;
        var
                i,j : integer;
                tempp : tiket;
        begin
                for i:= 1 to temp-1 do
                begin
                        for j:= temp downto i+1 do
                        begin
                                if (penerbangan[j].kode < penerbangan[j-1].kode) then
                                begin
                                        tempp := penerbangan[j];
                                        penerbangan[j] := penerbangan[j-1];
                                        penerbangan[j-1] := tempp;
                                end;
                        end;
                end;
        end;
        procedure menu;
        var
                pil : integer;
        begin
                repeat
                clrscr;
                writeln('PROGRAM RESERVASI TIKET PESAWAT');
                writeln('1. Input Data Penumpang');
                writeln('2. Tampilkan Data Penumpang berdasarkan kode');
                writeln('3. Tampilkan data keseluruhan');
                writeln('4. Urutkan Data Penumpang');
                writeln('0. Exit');
                writeln();
                write('Masukan Pilihan Andaa : ');
                readln(pil);
                case (pil) of
                1: Begin
                        input1();
                        readln;
                   end;
                2: Begin
                        lihatbookcari();
                        readln();
                   end;
                3: Begin
                        lihatbook();
                        readln();
                   end;
                4 : begin
                        sorting();
                        readln();
                    end;
                end;
                until (pil=0);
        end;
        begin
        clrscr;         
                penerbangan[0].kode := 0;
                penerbangan[1].kode := 0;
                x := 88;
                k:= 1;
                n:=0;
                //buat;
                load;
                writeln(temp);
                readln;
                menu();
                readln;
                save;
        end.
{BEGIN
        x := 88;
        penerbangan[0].kode := 0;
        penerbangan[1].kode := 0;
        input1;
        lihatbook;
        readln;
end.}
