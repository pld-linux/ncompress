.\" {PTM/LK/0.1/29-09-1998/"kompresja i dekompresja danych"}
.\" T³umaczenie: 29-09-1998 £ukasz Kowalczyk (lukow@tempac.okwf.fuw.edu.pl)
.PU
.TH compress 1 local
.SH NAZWA
compress, uncompress, zcat \- kompresuj i dekompresuj dane (wersja 4.1)
.SH SK£ADNIA
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
.I limit_bitów
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
redukuje rozmiar podanych plików u¿ywaj±c adaptywnego kodowania algorytmem
Lempel-Ziv. Zawsze, je¿eli jest to mo¿liwe, do nazwy pliku dodawane jest
rozszerzenie 
.B "\&.Z,"
przy zachowaniu informacji o w³a¶cicielu pliku, trybie dostêpu oraz czasie 
dostêpu i
modyfikacji. Je¿eli nie podano nazwy ¿adnego pliku, dane do kompresji
pobierane s± ze standardowego wej¶cia, a po skompresowaniu zapisywane na
standardowe wyj¶cie.
.I compress
kompresuje jedynie zwyk³e pliki. W szczególno¶ci, ignoruje dowi±zania
symboliczne. Je¿eli plik ma wiele twardych dowi±zañ,
.I compress
nie podda go kompresji, chyba ¿e zostanie uruchomiony z opcj± 
.BR \-f .

.PP
je¿eli program zosta³ uruchomiony w pierwszym planie bez opcji
.BR \-f ,
u¿ytkownik bêdzie pytany przed nadpisywaniem istniej±cych plików.
.PP
Skompresowane pliki mog± byæ odtworzone do normalnej postaci poleceniem
.I uncompress
lub
.IR zcat .
.PP
.I uncompress
uruchamiany jest z list± plików w linii poleceñ. Nastêpnie ka¿dy plik,
którego nazwa koñczy siê rozszerzeniem 
.BR "\&.Z" 
i w nag³ówku pliku znajduje siê prawid³owa liczba (magic number) jest
dekompresowany i z jego nazwy usuwane jest rozszerzenie
.BR "\&.Z" .
Zdekompresowny plik bêdzie mia³ te same w³a¶ciwo¶ci, co plik skompresowany,
tzn. w³a¶ciciela, tryb dostêpu oraz czas dostêpu i modyfikacji.
.PP
Opcja
.B \-c
powoduje, ¿e programy 
.IR compress i uncompress
zapisuj± pliki wyj¶ciowe na standardowe wyj¶cie; w ten sposób oryginalne
pliki s± nienaruszane.
.PP
.I zcat
dzia³a tak samo, jak
.I uncompress
.B \-c.
.I zcat
dekompresuje pliki z listy podanej w linii poleceñ lub pobiera dane ze
standardowego wej¶cia, a nastêpnie zapisuje zdekompresowane dane na
standardowe wyj¶cie.
.I zcat
dokonuje dekompresji plików po sprawdzeniu, ¿e w nag³ówku pliku znajduje siê
w³a¶ciwa liczba (magic number); nie jest wymagane, aby nazwa pliku mia³a
rozszerzenie
.BR "\&.Z" .

.PP
Je¿eli podano opcjê
.BR \-r ,
.I compress
bêdzie dzia³a³ rekurencyjnie. Je¿eli w linii poleceñ oprócz nazw plików
podane zostan± nazwy katalogów, pliki w tych katalogach równie¿ zostan±
poddane kompresji.
.PP
Opcja
.B \-V
spowoduje wypisanie na standardowe wyj¶cie b³êdów wersji programu, jak
równie¿ opcji preprocesora u¿ytych w trakcie kompilacji. Nastêpnie
dokonywana jest kompresja/dekompresja podanych plików.
.PP
.I compress
u¿ywa zmodyfikowanego algorytmu Lempel-Ziv spopularyzowanego w artykule
"A Technique for High Performance Data Compression"
autorstwa Terry'ego A. Welcha,
który ukaza³ siê w
.I "IEEE Computer,"
vol. 17, no. 6 (lipiec 1984), strony. 8-19.
Jednakowe podci±gi w pliku s± pocz±tkowo zastêpowane 9-bitowymi kodami o
warto¶ciach wiêkszych od 257. Gdy osi±gniêta zostanie warto¶æ kodów 512,
algorytm zaczyna u¿ywaæ kodów 10-bitowych, potem 11-bitowych itd. a¿ do
osi±gniêcia limitu podanego w linii poleceñ opcj±
.BR \-b ,
domy¶lnie jest to 16 bitów.
.I limit_bitów
musi siê zawieraæ pomiêdzy 9 a 16. Warto¶æ domy¶lna mo¿e byæ zmieniona w
kodzie ¼ród³owym, aby umo¿liwiæ dzia³anie programu na komputerach z mniejsz±
ilo¶ci± pamiêci.
.PP
Gdy osi±gniêty zostanie
.IR limit_bitów ,
.I compress
zaczyna kontrolowaæ wspó³czynnik kompresji. Je¿eli wspó³czynnik jest
zwiêkszany,
.I compress
kontynuuje u¿ywanie bie¿±cego s³ownika. Jednak¿e, je¿eli wspó³czynnik siê
zmniejsza, 
.I compress
tworzy od nowa tablicê podci±gów, co pozwala algorytmowi zaadaptowaæ siê do
kolejnej porcji danych.
.PP
Zauwa¿, ¿e opcja
.B \-b
nie jest u¿ywana przez program
.IR uncompress ,
poniewa¿ parametr
.I limit_bitów
jest zapisywany wraz z kompresowanymi danymi. Zapisywana jest równie¿
w³a¶ciwa warto¶æ w nag³ówku (magic number), aby upewniæ siê, ¿e nie zostanie
podjêta próba dekompresji przypadkowych danych, lub kompresja danych
wcze¶niej poddanych kompresji.
.PP
.ne 8
Wydajno¶æ kompresji zale¿y od wielko¶ci danych wej¶ciowych, ilo¶ci bitów
u¿ywanych w kodach oraz rozmieszczenia w danych jednakowych podci±gów. Dane
takie, jak kod ¼ród³owy lub tekst w jêzyku angielskim s± redukowane o 50\-60
procent. Osi±gany stopieñ kompresji jest przewa¿nie du¿o wiêkszy ni¿ w
kodowaniu Huffmana (u¿ywanym przez program
.IR pack ),
lub adaptywnym kodowaniu Huffmana
.RI ( compact ),
kompresja przebiega te¿ szybciej.
.PP
Po podaniu opcji
.B \-v
po skompresowaniu ka¿dego pliku wypisywana jest informacja na temat
osi±gniêtego stopnia kompresji.
.PP
Kod wyj¶cia jest normalnie równy 0; je¿eli ostatni plik jest po (próbie)
kompresji wiêkszy ni¿ przedtem, kod wyj¶cia jest równy 2; je¿eli wyst±pi
jaki¶ inny b³±d, kod wyj¶cia jest równy 1.
.SH "ZOBACZ TAK¯E"
pack(1), compact(1)
.SH "DIAGNOSTYKA"
Usage: compress [\-dfvcVr] [\-b maxbits] [file ...]
.in +8
W linii poleceñ znalaz³y siê nieprawid³owe opcje.
.in -8
Missing maxbits
.in +8
Po opcji 
.B \-b 
brakowa³o parametru.
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
Plik zosta³ skompresowany przez program obs³uguj±cy wiêksz± ilo¶æ bitów
ni¿ program 
.I compress
na tym komputerze. Skompresuj plik ponownie z mniejszym parametrem
.IR limit_bitów .
.in -8
.IR file :
already has .Z suffix -- no change
.in +8
Plik z rozszerzeniem nazwy \&.Z nie mo¿e byæ ponownie kompresowany. Zmieñ
nazwê pliku i spróbuj ponownie.
.in -8
.IR file :
filename too long to tack on .Z
.in +8
Plik nie mo¿e byæ skompresowany, poniewa¿ jego nazwa jest d³u¿sza ni¿ 12
znaków. Zmieñ nazwê pliku i spróbuj ponownie. Ta informacja nie pojawia siê
na systemach BSD.
.in -8
.I file
already exists; do you wish to overwrite (y or n)?
.in +8
Odpowiedz "y", je¿eli chcesz nadpisaæ istniej±cy ju¿ plik wyj¶ciowy lub "n",
je¿eli nie chcesz
.in -8
uncompress: corrupt input
.in +8
Program otrzyma³ sygna³ SIGSEGV co zazwyczaj oznacza, ¿e plik wej¶ciowy jest
uszkodzony.
.in -8
Compression: 
.I "xx.xx%"
.in +8
Osi±gniêty stopieñ kompresji (tylko po podaniu opcji
.BR \-v \.)
.in -8
-- not a regular file or directory: ignored
.in +8
Gdy plik wej¶ciowy nie jest zwyk³ym plikiem lub katalogiem (tzn. jest np.
dowi±zaniem symbolicznym, gniazdem, kolejk± FIFO, plikiem urz±dzenia) jest
pozostawiany bez zmian.
.in -8
-- has 
.I xx 
other links: unchanged
.in +8
Plik wej¶ciowy ma twarde dowi±zania i nie mo¿e zostaæ zmieniony. Wiêcej
informacji znajdziesz w opisie polecenia
.IR ln "(1)."
U¿yj opcji
.BR \-f ,
aby wymusiæ kompresjê plików maj±cych twarde dowi±zania.
.in -8
-- file unchanged
.in +8
Rozmiar pliku nie zmniejszy³ siê po kompresji. Plik zostanie pozostawiony w
oryginalnej postaci.
.in -8
.SH "PROBLEMY"
Mimo, ¿e skompresowane pliki s± kompatybilne na komputerach z du¿± ilo¶ci±
pamiêci, dla plików, które bêd± odczytywane na innych komputerach nale¿y
u¿ywaæ opcji
.BR "\-b \12" ,
poniewa¿ dekompresja mo¿e byæ niemo¿liwa na komputerach z mniejsz± ilo¶ci±
pamiêci (64KB lub mniej, jak na komputerach serii DEC PDP, lub Intel 80286, etc.)
.PP
Uruchomienie programu z opcj± \-r mo¿e niekiedy spowodowaæ fa³szywe
komunikaty o b³êdach postaci
.PP
.in 8
"<filename>.Z already has .Z suffix - ignored"
.in -8
.PP
Mog± one zostaæ zignorowane. Wyja¶nienie znajduje siê w komentarzu do
funkcji compdir() w pliku compress.c.

