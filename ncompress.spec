Summary:	a fast compress utility
Summary(de):	ein schnelles Komprimierungs-Dienstprogramm
Summary(fr):	Utilitaire rapide de compression
Summary(pl):	Narz�dzie do szybkiego kompresowania plik�w
Summary(tr):	H�zl� bir s�k��t�rma arac�
Name:		ncompress
Version:	4.2.4
Release:	22
License:	unknown
Group:		Applications/Archiving
Group(de):	Applikationen/Archivierung
Group(pl):	Aplikacje/Archiwizacja
Source0:	ftp://sunsite.unc.edu/pub/Linux/utils/compress/%{name}-%{version}.tar.Z
Source1:	compress.1.pl
Patch0:		%{name}-make.patch
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%description
ncompress is a utility that will do fast compression and decompression
compatible with the original *nix compress utility (.Z extensions). It
will not handle gzipped (.gz) images (although gzip can handle
compress images). It is pretty much obsolete - unless you need to
exchange files with some really odd unix variants, use gzip or bzip2
instead.

%description -l de
ncompress ist ein Utility zur Durchf�hrung schneller Komprimierungen
und Dekomprimierungen, das zu dem Original *nix-Komprimierungs-Utility
(.Z- Erweiterungen) kompatibel ist. gzip-Grafikdateien (.gz) k�nnen
damit nicht verarbeitet werden (obwohl gzip mit compress-Dateien
arbeiten kann).

%description -l fr
ncompress est un utilitaire qui effectue une compression et une
d�compression rapide avec l'utilitaire de compression *nix original
(extension .Z). Il ne g�re pas les images gzipp�es (.gz) (bien que
gzip puisse g�rer les images compress).

%description -l pl
ncompress jest narz�dziem umo�liwiaj�cym szybk� kompresj� i
dekompresj� plik�w zgodnym z orginalnym *nixowym narz�dziem o nazwie
compress (tworzy pliki z rozszerzeniem .Z). ncompres nie obs�uguje
plik�w .gz (ale gzip potrafi obs�ugiwa� pliki ncompress-a).

%description -l tr
ncompress, orijinal Un*X compress uygulamas� ile uyumlu (.Z uzant�l�)
h�zl� s�k��t�rma ve a�ma i�lemleri yap�lmas�n� sa�lar. ncompress gzip
ile s�k��t�r�lm�� dosyalarla i�lem yapamaz. (gzip compress ile
s�k��t�r�lm�� dosyalar �zerinde �al��abilir)

%prep
%setup -q
%patch -p1

%build
%ifarch %{ix86}
%{__make} OPT="%{?debug:-O -g}%{!?debug:$RPM_OPT_FLAGS}" ENDIAN=4321
%endif

%ifarch sparc sparc64 m68k armv4l ppc s390
%{__make} OPT="%{?debug:-O -g}%{!?debug:$RPM_OPT_FLAGS}" ENDIAN=1234
%endif

%ifarch alpha ia64
make OPT="%{?debug:-O -g}%{!?debug:$RPM_OPT_FLAGS} -DNOALLIGN=0" ENDIAN=4321
%endif

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT{%{_bindir},%{_mandir}/{man1,pl/man1}}

install compress $RPM_BUILD_ROOT%{_bindir}
ln -sf compress $RPM_BUILD_ROOT%{_bindir}/uncompress
install compress.1 $RPM_BUILD_ROOT%{_mandir}/man1
install %{SOURCE1} $RPM_BUILD_ROOT%{_mandir}/pl/man1/compress.1

echo ".so compress.1" > $RPM_BUILD_ROOT%{_mandir}/man1/uncompress.1
echo ".so compress.1" > $RPM_BUILD_ROOT%{_mandir}/pl/man1/uncompress.1

gzip -9nf LZW.INFO README

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc {LZW.INFO,README}.gz
%attr(755,root,root) %{_bindir}/*
%{_mandir}/man1/*
%lang(pl) %{_mandir}/pl/man1/*
