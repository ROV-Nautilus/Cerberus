@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xelab  -wto 7ff7f3ecbce64f9c94b7116b3313bb40 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot Cerberus_tb_behav xil_defaultlib.Cerberus_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
