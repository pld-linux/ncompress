Summary:     a fast compress utility
Summary(de): ein schnelles Komprimierungs-Dienstprogramm
Summary(fr): Utilitaire rapide de compression
Summary(pl): Narz�dzie do szybkiego kompresowania plik�w
Summary(tr): H�zl� bir s�k��t�rma arac�
Name:        ncompress
Version:     4.2.4
Release:     11
Copyright:   unknown
Group:       Utilities/Archiving
Source:      ftp://sunsite.unc.edu/pub/Linux/utils/compress/%{name}-%{version}.tar.Z
Patch:       ncompress-4.2.4-make.patch
Buildroot:   /tmp/%{name}-%{version}-root

%description
ncompress is a utility that will do fast compression and decompression
compatible with the original *nix compress utility (.Z extensions).  It will 
not handle gzipped (.gz) images (although gzip can handle compress images).

%description -l de
ncompress ist ein Utility zur Durchf�hrung schneller Komprimierungen und 
Dekomprimierungen, das zu dem Original *nix-Komprimierungs-Utility (.z-
Erweiterungen) kompatibel ist. gzip-Grafikdateien (.gz) k�nnen damit nicht 
verarbeitet werden (obwohl gzip mit compress-Dateien arbeiten kann). 

%description -l fr
ncompress est un utilitaire qui effectue une compression et une d�compression
rapide avec l'utilitaire de compression *nix original (extension .Z). Il ne
g�re pas les images gzipp�es (.gz) (bien que gzip puisse g�rer les images
compress).

%description -l pl
ncompress jest narz�dziem umo�liwiaj�cym szybk� kompresj� i dekompresj�
plik�w zgodnym z orginalnym *nixowym narz�dziem o nazwie compress (tworzy
pliki z rozszerzeniem .Z). ncompres nie obs�uguje plik�w .gz (ale gzip
potrafi obs�ugiwa� pliki ncompress-a).

%description -l tr
ncompress, orijinal Un*X compress uygulamas� ile uyumlu (.Z uzant�l�) h�zl�
s�k��t�rma ve a�ma i�lemleri yap�lmas�n� sa�lar. ncompress gzip ile
s�k��t�r�lm�� dosyalarla i�lem yapamaz. (gzip compress ile s�k��t�r�lm��
dosyalar �zerinde �al��abilir)

%prep
%setup -q
%patch -p1

%build
%ifarch i386
make "RPM_OPT_FLAGS=$RPM_OPT_FLAGS" ENDIAN=4321
%endif

%ifarch sparc m68k
make "RPM_OPT_FLAGS=$RPM_OPT_FLAGS" ENDIAN=1234
%endif

%ifarch alpha
make "RPM_OPT_FLAGS=$RPM_OPT_FLAGS -DNOALLIGN=0" ENDIAN=4321
%endif

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT/usr/{bin,man/man1}

install -s compress $RPM_BUILD_ROOT/usr/bin
ln -sf compress $RPM_BUILD_ROOT/usr/bin/uncompress
install compress.1 $RPM_BUILD_ROOT/usr/man/man1

echo ".so compress.1" > $RPM_BUILD_ROOT/usr/man/man1/uncompress.1

%clean
rm -rf $RPM_BUILD_ROOT

%files
%attr(644, root, root, 755) %doc LZW.INFO README
%attr(755, root, root) /usr/bin/*
%attr(644, root,  man) /usr/man/man1/*

%changelog
* Sun Aug 30 1998 Tomasz K�oczko <kloczek@rudy.mif.pg.gda.pl>
  [4.2.4-11]
- added -q %setup parameter,
- spec rewrited for using Buildroot,
- aded pl translation,
- uncompress(1) man page is now maked as nroff include to compress(1)
  instead making sym link to compress.1 (this allow compress man pages
   in future),
- added %attr and %defattr macros in %files (allow build package from
  non-root account).

* Mon Apr 27 1998 Prospector System <bugs@redhat.com>
- translations modified for de, fr, tr

* Wed Oct 21 1997 Cristian Gafton <gafton@redhat.com>
- fixed the spec file

* Mon Jun 02 1997 Erik Troan <ewt@redhat.com>
- built against glibc