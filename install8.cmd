@echo off

set R_HOME=c:\R\rw1081
set TMP=C:/TMP
set TEMP=C:/TMP
set TMPDIR=C:/TMP

sh prebuild.sh

cd ..
%R_HOME%\bin\rcmd install %1 %2 %3 %4 %5 ref
cd ref