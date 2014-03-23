@echo off
set SRC_DIR=%~dp0..\..
pushd %SRC_DIR%

call :command insnsb.c
call :command insnsa.c
call :command insnsd.c
call :command insnsi.h
call :command insnsn.c

call :command regs.c
call :command regs.h
call :command regflags.c
call :command regdis.c
call :command regdis.h
call :command regvals.c

call :command tokhash.c
call :command tokens.h

call :command version.h
call :command version.mac

call :command pptok.h
call :command pptok.c
call :command pptok.ph

call :command iflaggen.h
call :command iflag.c

call :command directiv.h
call :command directiv.c

call :command macros.c

popd
goto :eof

:command 
if exist %1 (
  del %1 
	echo File %1 deleted
) else (
	echo File %1 does not exist, skipping
)
goto :eof

