@echo off

rem Installation script for the English-Vietnamese dataset from
rem 2015 International Workshop on Spoken Language Translation (IWSLT'15)
rem The script installs all training, validation and testing sets
rem
rem See CK LICENSE.txt for licensing details.
rem See CK COPYRIGHT.txt for copyright details.
rem
rem Developer(s):
rem - Hongyu Zhu, serailhydra@cs.toronto.edu, 2018

rem PACKAGE_DIR
rem INSTALL_DIR

set DATASET_ROOT=$(cd $(dirname $0) && pwd)/dataset
set DOWNLOAD_TAR=iwslt15_en-vi.tar.gz

rem #####################################################################
echo.
echo Downloading archive ...

wget "https://www.cs.toronto.edu/~bojian/Downloads/iwslt15_en-vi.tar.gz" -O "%DATASET_ROOT%"

if %errorlevel% neq 0 (
 echo.
 echo Error: Failed downloading archive ...
 goto err
)

rem #####################################################################

echo.
echo Unpacking %DOWNLOAD_NAME% ...

cd /D %DATASET_ROOT%

tar xvf %DOWNLOAD_TAR%

rem if EXIST "%DOWNLOAD_TAR%" (
rem   del /Q /S %DOWNLOAD_TAR%
rem )

rem #####################################################################
echo.
echo Successfully installed the IWSLT'15 train/val/test dataset ...

exit /b 0

:err
exit /b 1
