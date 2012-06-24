Summary:	A fast compress utility
Summary(de):	ein schnelles Komprimierungs-Dienstprogramm
Summary(fr):	Utilitaire rapide de compression
Summary(pl):	Narz�dzie do szybkiego kompresowania plik�w
Summary(tr):	H�zl� bir s�k��t�rma arac�
Name:		ncompress
Version:	4.2.4
Release:	26
License:	distributable
Group:		Applications/Archiving
Source0:	ftp://sunsite.unc.edu/pub/Linux/utils/compress/%{name}-%{version}.tar.Z
# Source0-md5:	171e69cdb4a28b24597f1f913ac44926
Source1:	http://www.mif.pg.gda.pl/homepages/ankry/man-PLD/%{name}-non-english-man-pages.tar.bz2
# Source1-md5:	1f664b832aee8282bc50f54635b98130
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
dekompresj� plik�w zgodnym z oryginalnym *niksowym narz�dziem o nazwie
compress (tworzy pliki z rozszerzeniem .Z). ncompress nie obs�uguje
plik�w .gz (ale gzip potrafi obs�ugiwa� pliki ncompress-a). ncompress
jest raczej przestarza�ym programem - o ile nie potrzebujesz
wymienia� plik�w z naprawd� starymi *niksami, u�ywaj program�w gzip
lub bzip2.

%description -l tr
ncompress, orijinal Un*X compress uygulamas� ile uyumlu (.Z uzant�l�)
h�zl� s�k��t�rma ve a�ma i�lemleri yap�lmas�n� sa�lar. ncompress gzip
ile s�k��t�r�lm�� dosyalarla i�lem yapamaz. (gzip compress ile
s�k��t�r�lm�� dosyalar �zerinde �al��abilir)

%prep
%setup -q -a1
%patch -p1

%build
%ifarch %{ix86}
%{__make} OPT="%{rpmcflags}" ENDIAN=4321
%endif

%ifarch sparc sparc64 m68k armv4l ppc s390
%{__make} OPT="%{rpmcflags}" ENDIAN=1234
%endif

%ifarch alpha ia64 amd64
%{__make} OPT="%{rpmcflags} -DNOALLIGN=0" ENDIAN=4321
%endif

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT{%{_bindir},%{_mandir}/man1}

install compress $RPM_BUILD_ROOT%{_bindir}
ln -sf compress $RPM_BUILD_ROOT%{_bindir}/uncompress

install compress.1 $RPM_BUILD_ROOT%{_mandir}/man1
echo ".so compress.1" > $RPM_BUILD_ROOT%{_mandir}/man1/uncompress.1

for a in de it pl ; do
	install -d $RPM_BUILD_ROOT%{_mandir}/$a/man1
	install $a/man1/* $RPM_BUILD_ROOT%{_mandir}/$a/man1/
	echo ".so compress.1" > $RPM_BUILD_ROOT%{_mandir}/$a/man1/uncompress.1
done

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc LZW.INFO README
%attr(755,root,root) %{_bindir}/*
%{_mandir}/man1/*
%lang(de) %{_mandir}/de/man1/*
%lang(it) %{_mandir}/it/man1/*
%lang(pl) %{_mandir}/pl/man1/*
