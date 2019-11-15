Summary:	A fast compress utility
Summary(de.UTF-8):	ein schnelles Komprimierungs-Dienstprogramm
Summary(fr.UTF-8):	Utilitaire rapide de compression
Summary(pl.UTF-8):	Narzędzie do szybkiego kompresowania plików
Summary(tr.UTF-8):	Hızlı bir sıkıştırma aracı
Name:		ncompress
Version:	4.2.4.5
Release:	1
License:	Public Domain
Group:		Applications/Archiving
Source0:	http://downloads.sourceforge.net/ncompress/%{name}-%{version}.tar.gz
# Source0-md5:	9ab5d54d764d38050e9256b635bf09a9
Source1:	http://www.mif.pg.gda.pl/homepages/ankry/man-PLD/%{name}-non-english-man-pages.tar.bz2
# Source1-md5:	1f664b832aee8282bc50f54635b98130
Patch0:		%{name}-make.patch
Patch1:		%{name}-gcc34.patch
URL:		http://ncompress.sourceforge.net/
BuildRequires:	rpmbuild(macros) >= 1.213
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%description
ncompress is a utility that will do fast compression and decompression
compatible with the original *nix compress utility (.Z extensions). It
will not handle gzipped (.gz) images (although gzip can handle
compress images). It is pretty much obsolete - unless you need to
exchange files with some really odd Unix variants, use gzip or bzip2
instead.

%description -l de.UTF-8
ncompress ist ein Utility zur Durchführung schneller Komprimierungen
und Dekomprimierungen, das zu dem Original *nix-Komprimierungs-Utility
(.Z- Erweiterungen) kompatibel ist. gzip-Grafikdateien (.gz) können
damit nicht verarbeitet werden (obwohl gzip mit compress-Dateien
arbeiten kann).

%description -l fr.UTF-8
ncompress est un utilitaire qui effectue une compression et une
décompression rapide avec l'utilitaire de compression *nix original
(extension .Z). Il ne gère pas les images gzippées (.gz) (bien que
gzip puisse gérer les images compress).

%description -l pl.UTF-8
ncompress jest narzędziem umożliwiającym szybką kompresję i
dekompresję plików zgodnym z oryginalnym *niksowym narzędziem o nazwie
compress (tworzy pliki z rozszerzeniem .Z). ncompress nie obsługuje
plików .gz (ale gzip potrafi obsługiwać pliki ncompress-a). ncompress
jest raczej przestarzałym programem - o ile nie potrzebujesz
wymieniać plików z naprawdę starymi *niksami, używaj programów gzip
lub bzip2.

%description -l tr.UTF-8
ncompress, orijinal Un*X compress uygulaması ile uyumlu (.Z uzantılı)
hızlı sıkıştırma ve açma işlemleri yapılmasını sağlar. ncompress gzip
ile sıkıştırılmış dosyalarla işlem yapamaz. (gzip compress ile
sıkıştırılmış dosyalar üzerinde çalışabilir)

%prep
%setup -q -a1
%patch0 -p1
%patch1 -p1

%build
%ifarch sparc sparc64 m68k %{arm} ppc ppc64 s390
ENDIAN="1234"
%else
ENDIAN="4321"
%endif

%ifarch alpha ia64 %{x8664} ppc64
OPTCFLAGS="-DNOALLIGN=0"
%else
OPTCFLAGS=""
%endif

%{__make} -f Makefile \
	CC="%{__cc} %{rpmcflags} $OPTCFLAGS" \
	ENDIAN="$ENDIAN"

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT{%{_bindir},%{_mandir}/man1}

install compress $RPM_BUILD_ROOT%{_bindir}
ln -sf compress $RPM_BUILD_ROOT%{_bindir}/uncompress

install compress.1 $RPM_BUILD_ROOT%{_mandir}/man1
echo ".so compress.1" > $RPM_BUILD_ROOT%{_mandir}/man1/uncompress.1

for a in de it pl ; do
	install -d $RPM_BUILD_ROOT%{_mandir}/$a/man1
	cp -p $a/man1/* $RPM_BUILD_ROOT%{_mandir}/$a/man1
	echo ".so compress.1" > $RPM_BUILD_ROOT%{_mandir}/$a/man1/uncompress.1
done

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc Acknowleds Changes LICENSE.txt LZW.INFO README.md UNLICENSE
%attr(755,root,root) %{_bindir}/compress
%attr(755,root,root) %{_bindir}/uncompress
%{_mandir}/man1/compress.1*
%{_mandir}/man1/uncompress.1*
%lang(de) %{_mandir}/de/man1/*
%lang(it) %{_mandir}/it/man1/*
%lang(pl) %{_mandir}/pl/man1/*
