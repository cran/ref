@echo off

set R_HOME=c:\R\rw1090beta
set TMP=C:/TMP
set TEMP=C:/TMP
set TMPDIR=C:/TMP

sh prebuild.sh

cd ..
%R_HOME%\bin\rcmd CHECK %1 %2 %3 %4 %5 ref
cd ref
