@echo off
set SRC_DIR=%~dp0..\..
pushd %SRC_DIR%

call :perlcommand insnsb.c insns.pl -b insns.dat
call :perlcommand insnsa.c insns.pl -a insns.dat
call :perlcommand insnsd.c insns.pl -d insns.dat
call :perlcommand insnsi.h insns.pl -i insns.dat
call :perlcommand insnsn.c insns.pl -n insns.dat

call :perlcommand2 regs.pl c regs.dat regs.c
call :perlcommand2 regs.pl h regs.dat regs.h
call :perlcommand2 regs.pl fc regs.dat regflags.c
call :perlcommand2 regs.pl dc regs.dat regdis.c
call :perlcommand2 regs.pl dh regs.dat regdis.h
call :perlcommand2 regs.pl vc regs.dat regvals.c

call :perlcommand3 -Iperllib tokhash.pl c insns.dat regs.dat tokens.dat tokhash.c
call :perlcommand3 -Iperllib tokhash.pl h insns.dat regs.dat tokens.dat tokens.h

call :perlcommand4 version.pl h version version.h
call :perlcommand4 version.pl mac version version.mac

call :perlcommand5 -Iperllib pptok.pl h pptok.dat pptok.h
call :perlcommand5 -Iperllib pptok.pl c pptok.dat pptok.c
call :perlcommand5 -Iperllib pptok.pl ph pptok.dat pptok.ph

call :perlcommand6 iflaggen.h insns.pl -fh insns.dat
call :perlcommand6 iflag.c insns.pl -fc insns.dat

call :perlcommand5 -Iperllib directiv.pl h directiv.dat directiv.h
call :perlcommand5 -Iperllib directiv.pl c directiv.dat directiv.c

:: macros.c
if exist macros.c (
	echo File macros.c exists, skipping
) else (
  echo Creating macros.c...
	perl -Iperllib macros.pl standard.mac version.mac macros\altreg.mac macros\fp.mac macros\ifunc.mac macros\smartalign.mac output\outaout.mac output\outas86.mac output\outbin.mac output\outcoff.mac output\outelf.mac output\outmacho.mac output\outobj.mac output\outrdf.mac output\outrdf2.mac
)


popd
goto :eof

:execcommandtest 
echo %1 %2 %3 %4 %5 %6 %7 %8 %9
goto :eof

:perlcommand 
if exist %1 (
  echo File %1 exists, skipping
) else (
	echo Creating %1...
	perl %2 %3 %4 
)
goto :eof

:perlcommand2 
if exist %4 (
  echo File %4 exists, skipping
) else (
	echo Creating %4...
	perl %1 %2 %3 > %4
)
goto :eof

:perlcommand3 
if exist %7 (
  echo File %7 exists, skipping
) else (
	echo Creating %7...
	perl %1 %2 %3 %4 %5 %6 > %7 
)
goto :eof

:perlcommand4 
if exist %4 (
  echo File %4 exists, skipping
) else (
	echo Creating %4...
	perl %1 %2 < %3 > %4 
)
goto :eof

:perlcommand5 
if exist %5 (
  echo File %5 exists, skipping
) else (
	echo Creating %5...
	perl %1 %2 %3 %4 %5 
)
goto :eof

:perlcommand6 
if exist %1 (
  echo File %1 exists, skipping
) else (
	echo Creating %1...
	perl %2 %3 %4 %5 %6 
)
goto :eof

