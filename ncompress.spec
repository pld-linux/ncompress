Summary:	a fast compress utility
Summary(de):	ein schnelles Komprimierungs-Dienstprogramm
Summary(fr):	Utilitaire rapide de compression
Summary(pl):	Narzêdzie do szybkiego kompresowania plików
Summary(tr):	Hýzlý bir sýkýþtýrma aracý
Name:		ncompress
Version:	4.2.4
Release:	23
License:	Distributable
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
ncompress ist ein Utility zur Durchführung schneller Komprimierungen
und Dekomprimierungen, das zu dem Original *nix-Komprimierungs-Utility
(.Z- Erweiterungen) kompatibel ist. gzip-Grafikdateien (.gz) können
damit nicht verarbeitet werden (obwohl gzip mit compress-Dateien
arbeiten kann).

%description -l fr
ncompress est un utilitaire qui effectue une compression et une
décompression rapide avec l'utilitaire de compression *nix original
(extension .Z). Il ne gère pas les images gzippées (.gz) (bien que
gzip puisse gérer les images compress).

%description -l pl
ncompress jest narzêdziem umo¿liwiaj±cym szybk± kompresjê i
dekompresjê plików zgodnym z orginalnym *nixowym narzêdziem o nazwie
compress (tworzy pliki z rozszerzeniem .Z). ncompres nie obs³uguje
plików .gz (ale gzip potrafi obs³ugiwaæ pliki ncompress-a).

%description -l tr
ncompress, orijinal Un*X compress uygulamasý ile uyumlu (.Z uzantýlý)
hýzlý sýkýþtýrma ve açma iþlemleri yapýlmasýný saðlar. ncompress gzip
ile sýkýþtýrýlmýþ dosyalarla iþlem yapamaz. (gzip compress ile
sýkýþtýrýlmýþ dosyalar üzerinde çalýþabilir)

%prep
%setup -q
%patch -p1

%build
%ifarch %{ix86}
%{__make} OPT="%{rpmcflags}" ENDIAN=4321
%endif

%ifarch sparc sparc64 m68k armv4l ppc s390
%{__make} OPT="%{rpmcflags}" ENDIAN=1234
%endif

%ifarch alpha ia64
make OPT="%{rpmcflags} -DNOALLIGN=0" ENDIAN=4321
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
