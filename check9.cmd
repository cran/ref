@echo off

set old_R_HOME=%R_HOME%
set R_HOME=c:\R\rw1091

set TMP=C:/TMP
set TEMP=C:/TMP
set TMPDIR=C:/TMP

sh prebuild.sh

cd ..
%R_HOME%\bin\rcmd CHECK %1 %2 %3 %4 %5 ref
cd ref

set R_HOME=%old_R_HOME%
set old_R_HOME=
