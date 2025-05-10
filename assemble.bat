@echo off
echo Building PCM data...
echo ========================================================================================================================
cd SOUND
cd PCM
if not exist OUT mkdir OUT
"../../TOOL/vasmz80_psi-x.exe" -altlocal -altnum -spaces -maxerrors=0 -Fbin -start=0 -o "OUT/mddr11.bin" -L "OUT/mddr11.lst" -Lall "mddr11.src" 2> _errors.log
type _errors.log
del _errors.log
echo.
echo Building game...
echo ========================================================================================================================
cd ../..
if not exist OUT mkdir OUT
"TOOL/vasmm68k_psi-x.exe" -altlocal -altnum -spaces -m68000 -maxerrors=0 -Fbin -start=0 -o "OUT/SMPS.BIN" -L "OUT/SMPS.LST" -Lall "SRC/MAIN.S" 2> _errors.log
type _errors.log
del _errors.log
pause