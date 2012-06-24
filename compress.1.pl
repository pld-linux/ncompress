.\" {PTM/LK/0.1/29-09-1998/"kompresja i dekompresja danych"}
.\" T�umaczenie: 29-09-1998 �ukasz Kowalczyk (lukow@tempac.okwf.fuw.edu.pl)
.PU
.TH compress 1 local
.SH NAZWA
compress, uncompress, zcat \- kompresuj i dekompresuj dane (wersja 4.1)
.SH SK�ADNIA
.ll +8
.B compress
[
.B \-f
] [
.B \-v
] [
.B \-c
] [
.B \-V
] [
.B \-r
] [
.B \-b
.I limit_bit�w
] [
.I "nazwa \&..."
]
.ll -8
.br
.B uncompress
[
.B \-f
] [
.B \-v
] [
.B \-c
] [
.B \-V
] [
.I "nazwa \&..."
]
.br
.B zcat
[
.B \-V
] [
.I "nazwa \&..."
]
.SH OPIS
.I compress
redukuje rozmiar podanych plik�w u�ywaj�c adaptywnego kodowania algorytmem
Lempel-Ziv. Zawsze, je�eli jest to mo�liwe, do nazwy pliku dodawane jest
rozszerzenie 
.B "\&.Z,"
przy zachowaniu informacji o w�a�cicielu pliku, trybie dost�pu oraz czasie 
dost�pu i
modyfikacji. Je�eli nie podano nazwy �adnego pliku, dane do kompresji
pobierane s� ze standardowego wej�cia, a po skompresowaniu zapisywane na
standardowe wyj�cie.
.I compress
kompresuje jedynie zwyk�e pliki. W szczeg�lno�ci, ignoruje dowi�zania
symboliczne. Je�eli plik ma wiele twardych dowi�za�,
.I compress
nie podda go kompresji, chyba �e zostanie uruchomiony z opcj� 
.BR \-f .

.PP
je�eli program zosta� uruchomiony w pierwszym planie bez opcji
.BR \-f ,
u�ytkownik b�dzie pytany przed nadpisywaniem istniej�cych plik�w.
.PP
Skompresowane pliki mog� by� odtworzone do normalnej postaci poleceniem
.I uncompress
lub
.IR zcat .
.PP
.I uncompress
uruchamiany jest z list� plik�w w linii polece�. Nast�pnie ka�dy plik,
kt�rego nazwa ko�czy si� rozszerzeniem 
.BR "\&.Z" 
i w nag��wku pliku znajduje si� prawid�owa liczba (magic number) jest
dekompresowany i z jego nazwy usuwane jest rozszerzenie
.BR "\&.Z" .
Zdekompresowny plik b�dzie mia� te same w�a�ciwo�ci, co plik skompresowany,
tzn. w�a�ciciela, tryb dost�pu oraz czas dost�pu i modyfikacji.
.PP
Opcja
.B \-c
powoduje, �e programy 
.IR compress i uncompress
zapisuj� pliki wyj�ciowe na standardowe wyj�cie; w ten spos�b oryginalne
pliki s� nienaruszane.
.PP
.I zcat
dzia�a tak samo, jak
.I uncompress
.B \-c.
.I zcat
dekompresuje pliki z listy podanej w linii polece� lub pobiera dane ze
standardowego wej�cia, a nast�pnie zapisuje zdekompresowane dane na
standardowe wyj�cie.
.I zcat
dokonuje dekompresji plik�w po sprawdzeniu, �e w nag��wku pliku znajduje si�
w�a�ciwa liczba (magic number); nie jest wymagane, aby nazwa pliku mia�a
rozszerzenie
.BR "\&.Z" .

.PP
Je�eli podano opcj�
.BR \-r ,
.I compress
b�dzie dzia�a� rekurencyjnie. Je�eli w linii polece� opr�cz nazw plik�w
podane zostan� nazwy katalog�w, pliki w tych katalogach r�wnie� zostan�
poddane kompresji.
.PP
Opcja
.B \-V
spowoduje wypisanie na standardowe wyj�cie b��d�w wersji programu, jak
r�wnie� opcji preprocesora u�ytych w trakcie kompilacji. Nast�pnie
dokonywana jest kompresja/dekompresja podanych plik�w.
.PP
.I compress
u�ywa zmodyfikowanego algorytmu Lempel-Ziv spopularyzowanego w artykule
"A Technique for High Performance Data Compression"
autorstwa Terry'ego A. Welcha,
kt�ry ukaza� si� w
.I "IEEE Computer,"
vol. 17, no. 6 (lipiec 1984), strony. 8-19.
Jednakowe podci�gi w pliku s� pocz�tkowo zast�powane 9-bitowymi kodami o
warto�ciach wi�kszych od 257. Gdy osi�gni�ta zostanie warto�� kod�w 512,
algorytm zaczyna u�ywa� kod�w 10-bitowych, potem 11-bitowych itd. a� do
osi�gni�cia limitu podanego w linii polece� opcj�
.BR \-b ,
domy�lnie jest to 16 bit�w.
.I limit_bit�w
musi si� zawiera� pomi�dzy 9 a 16. Warto�� domy�lna mo�e by� zmieniona w
kodzie �r�d�owym, aby umo�liwi� dzia�anie programu na komputerach z mniejsz�
ilo�ci� pami�ci.
.PP
Gdy osi�gni�ty zostanie
.IR limit_bit�w ,
.I compress
zaczyna kontrolowa� wsp�czynnik kompresji. Je�eli wsp�czynnik jest
zwi�kszany,
.I compress
kontynuuje u�ywanie bie��cego s�ownika. Jednak�e, je�eli wsp�czynnik si�
zmniejsza, 
.I compress
tworzy od nowa tablic� podci�g�w, co pozwala algorytmowi zaadaptowa� si� do
kolejnej porcji danych.
.PP
Zauwa�, �e opcja
.B \-b
nie jest u�ywana przez program
.IR uncompress ,
poniewa� parametr
.I limit_bit�w
jest zapisywany wraz z kompresowanymi danymi. Zapisywana jest r�wnie�
w�a�ciwa warto�� w nag��wku (magic number), aby upewni� si�, �e nie zostanie
podj�ta pr�ba dekompresji przypadkowych danych, lub kompresja danych
wcze�niej poddanych kompresji.
.PP
.ne 8
Wydajno�� kompresji zale�y od wielko�ci danych wej�ciowych, ilo�ci bit�w
u�ywanych w kodach oraz rozmieszczenia w danych jednakowych podci�g�w. Dane
takie, jak kod �r�d�owy lub tekst w j�zyku angielskim s� redukowane o 50\-60
procent. Osi�gany stopie� kompresji jest przewa�nie du�o wi�kszy ni� w
kodowaniu Huffmana (u�ywanym przez program
.IR pack ),
lub adaptywnym kodowaniu Huffmana
.RI ( compact ),
kompresja przebiega te� szybciej.
.PP
Po podaniu opcji
.B \-v
po skompresowaniu ka�dego pliku wypisywana jest informacja na temat
osi�gni�tego stopnia kompresji.
.PP
Kod wyj�cia jest normalnie r�wny 0; je�eli ostatni plik jest po (pr�bie)
kompresji wi�kszy ni� przedtem, kod wyj�cia jest r�wny 2; je�eli wyst�pi
jaki� inny b��d, kod wyj�cia jest r�wny 1.
.SH "ZOBACZ TAK�E"
pack(1), compact(1)
.SH "DIAGNOSTYKA"
Usage: compress [\-dfvcVr] [\-b maxbits] [file ...]
.in +8
W linii polece� znalaz�y si� nieprawid�owe opcje.
.in -8
Missing maxbits
.in +8
Po opcji 
.B \-b 
brakowa�o parametru.
.in -8
.IR file :
not in compressed format
.in +8
Plik podany jako parametr programu
.I uncompress
nie jest skompresowany.
.in -8
.IR file :
compressed with 
.I xx
bits, can only handle 
.I yy
bits
.in +8
Plik zosta� skompresowany przez program obs�uguj�cy wi�ksz� ilo�� bit�w
ni� program 
.I compress
na tym komputerze. Skompresuj plik ponownie z mniejszym parametrem
.IR limit_bit�w .
.in -8
.IR file :
already has .Z suffix -- no change
.in +8
Plik z rozszerzeniem nazwy \&.Z nie mo�e by� ponownie kompresowany. Zmie�
nazw� pliku i spr�buj ponownie.
.in -8
.IR file :
filename too long to tack on .Z
.in +8
Plik nie mo�e by� skompresowany, poniewa� jego nazwa jest d�u�sza ni� 12
znak�w. Zmie� nazw� pliku i spr�buj ponownie. Ta informacja nie pojawia si�
na systemach BSD.
.in -8
.I file
already exists; do you wish to overwrite (y or n)?
.in +8
Odpowiedz "y", je�eli chcesz nadpisa� istniej�cy ju� plik wyj�ciowy lub "n",
je�eli nie chcesz
.in -8
uncompress: corrupt input
.in +8
Program otrzyma� sygna� SIGSEGV co zazwyczaj oznacza, �e plik wej�ciowy jest
uszkodzony.
.in -8
Compression: 
.I "xx.xx%"
.in +8
Osi�gni�ty stopie� kompresji (tylko po podaniu opcji
.BR \-v \.)
.in -8
-- not a regular file or directory: ignored
.in +8
Gdy plik wej�ciowy nie jest zwyk�ym plikiem lub katalogiem (tzn. jest np.
dowi�zaniem symbolicznym, gniazdem, kolejk� FIFO, plikiem urz�dzenia) jest
pozostawiany bez zmian.
.in -8
-- has 
.I xx 
other links: unchanged
.in +8
Plik wej�ciowy ma twarde dowi�zania i nie mo�e zosta� zmieniony. Wi�cej
informacji znajdziesz w opisie polecenia
.IR ln "(1)."
U�yj opcji
.BR \-f ,
aby wymusi� kompresj� plik�w maj�cych twarde dowi�zania.
.in -8
-- file unchanged
.in +8
Rozmiar pliku nie zmniejszy� si� po kompresji. Plik zostanie pozostawiony w
oryginalnej postaci.
.in -8
.SH "PROBLEMY"
Mimo, �e skompresowane pliki s� kompatybilne na komputerach z du�� ilo�ci�
pami�ci, dla plik�w, kt�re b�d� odczytywane na innych komputerach nale�y
u�ywa� opcji
.BR "\-b \12" ,
poniewa� dekompresja mo�e by� niemo�liwa na komputerach z mniejsz� ilo�ci�
pami�ci (64KB lub mniej, jak na komputerach serii DEC PDP, lub Intel 80286, etc.)
.PP
Uruchomienie programu z opcj� \-r mo�e niekiedy spowodowa� fa�szywe
komunikaty o b��dach postaci
.PP
.in 8
"<filename>.Z already has .Z suffix - ignored"
.in -8
.PP
Mog� one zosta� zignorowane. Wyja�nienie znajduje si� w komentarzu do
funkcji compdir() w pliku compress.c.

