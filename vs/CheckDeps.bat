::
:: Usage: CheckDeps.bat
::
:: This script is used to verify that all the dependencies required to build Marian are available.
:: The Cuda SDK and the Intel MKL must be installed beforehand by the user.
:: The Boost and OpenSSH libraries, if not found, will be installed by this script using vcpkg
::
::
@echo off

set ROOT=%~dp0


:: The vcpkg library manager can be used to manage your dependencies in CMake.
::
:: If you already have a working vcpkg installation, this script can use it.
:: If vcpkg is in your PATH variable, the script will use it automatically.
:: Otherwise, please set the VCPKG_ROOT variable to the directory that contains the vcpkg.exe
::
:: eg: set VCPKG_ROOT=D:\Perso\Dev\vcpkg
::----------------------------------------------------------------------------------------------
::set VCPKG_ROOT=


:: If you prefer to manage yourself the dependencies, please set the following variables
:: to the respective paths. These variable can also be already set in your environment.
::----------------------------------------------------------------------------------------------
::set BOOST_INCLUDEDIR=
::set BOOST_LIBRARYDIR=
::set OPENSSL_ROOT_DIR=


:: If all the variables are empty and vcpkg is found in a known path, the script will download and
:: install vcpkg and will use it to manage the dependencies.


:: The MKL library can be automatically found by CMake. However, if you installed it in a custom
:: directory, please set the MKLROOT to this directory path.
:: Default is c:\ProgramFiles (x86)\IntelSWTools\compilers_and_libraries\windows\mkl
::----------------------------------------------------------------------------------------------
::set MKLROOT=



if "%BOOST_INCLUDEDIR%" == "" goto :needVcPkg
if "%OPENSSL_ROOT_DIR%" == "" goto :needVcPkg

goto :checkDeps


:: -------------------------------------------------------
:: Download or update vcpkg
:needVcPkg
:: -------------------------------------------------------

:: First look if vcpkg is in a known path
if "%VCPKG_ROOT%" == "" for /f "delims=" %%p in ('where vcpkg 2^>nul') do set VCPKG_ROOT=%%~dpp

:: Otherwise install it in a subdirectory
if "%VCPKG_ROOT%" == "" set VCPKG_ROOT=%ROOT%deps\vcpkg

if not exist %VCPKG_ROOT% (

    echo --- Cloning vcpkg...
    git clone https://github.com/Microsoft/vcpkg.git %VCPKG_ROOT%

    set BOOTSTRAP_VCPKG=1

) else (

    pushd %VCPKG_ROOT%

    echo --- Updating vcpkg...
    for /f "delims=" %%p in ('git pull') do (
        if not "%%p" == "Already up to date." (
            set BOOTSTRAP_VCPKG=1
        )
    )

    popd
)

if "%BOOTSTRAP_VCPKG%"=="1" (
    pushd %VCPKG_ROOT%
    call bootstrap-vcpkg.bat
    popd
)

set VCPKG_DEFAULT_TRIPLET=x64-windows-static
set VCPKG_INSTALL=%VCPKG_ROOT%\installed\%VCPKG_DEFAULT_TRIPLET%
set VCPKG=%VCPKG_ROOT%\vcpkg



:: -------------------------------------------------------
:: Check dependencies and configure CMake
:checkDeps
:: -------------------------------------------------------

echo.
echo --- Checking dependencies...

set CMAKE_OPT=


:: -------------------------
:: The CUDA_PATH env variable should normally be set by the CUDA SDK installer
::
echo.
echo ... CUDA
if "%CUDA_PATH%"=="" (
    echo The CUDA_PATH environment variable is not defined: this will compile only the CPU version.
)
else (
    echo Found Cuda SDK in %CUDA_PATH%
)

:: -------------------------
:: The MKL setup does not set any environment variable to the installation path.
:: The script look into the standard default installation dir
:: If you installed MKL in a custom directory, please set the variable MKLROOT at the top of this file.
::
echo.
echo ... Intel MKL
if "%MKLROOT%" == "" ( 
    set "MKLROOT=C:\Program Files (x86)\IntelSWTools\compilers_and_libraries\windows\mkl"
)
if not exist "%MKLROOT%" (
    echo MKLROOT is set to a non existing path:
    echo "%MKLROOT%"
    echo Please make sure the Intel MKL libraries are installed and set MKLROOT to the installation path.
    exit /b 1
)
if not exist "%MKLROOT%\include\mkl_version.h" (
    echo MKL header files were not found in this folder:
    echo    "%MKLROOT%"
    echo Please make sure Intel MKL is properly installed.
    exit /b 1
)
if not exist "%MKLROOT%\lib\intel64\mkl_core.lib" (
    echo MKL library files were not found in this folder:
    echo    "%MKLROOT%"
    echo Please make sure Intel MKL is properly installed.
    exit /b 1
)

echo Found Intel MKL library in %MKLROOT%

:: -------------------------
:: BOOST_INCLUDEDIR and BOOST_LIBRARYDIR can be both set to an existing Boost installation.
:: If not, we use vcpkg to install the required Boost packages
::
echo.
echo ... Boost (1.58+)
if "%BOOST_INCLUDEDIR%" == "" (
    "%VCPKG%" install boost-chrono boost-filesystem boost-iostreams boost-program-options boost-regex boost-system boost-thread boost-timer boost-asio
    set BOOST_INCLUDEDIR=%VCPKG_INSTALL%\include
    set BOOST_LIBRARYDIR=%VCPKG_INSTALL%\lib
)

if not exist "%BOOST_INCLUDEDIR%" (
    echo BOOST_INCLUDEDIR is set to a non existing path:
    echo    "%BOOST_INCLUDEDIR%"
    echo Please set BOOST_INCLUDEDIR and BOOST_LIBRARYDIR to the installation path of the Boost library.
    exit /b 1
)
if not exist "%BOOST_INCLUDEDIR%\boost\version.hpp" (
    echo Boost header files were not found in this folder:
    echo    "%BOOST_INCLUDEDIR%"
    echo Please make sure Boost is correctly installed.
    exit /b 1
)

if not exist "%BOOST_LIBRARYDIR%" (
    echo BOOST_LIBRARYDIR is set to a non existing path:
    echo    "%BOOST_LIBRARYDIR%"
    echo Please set BOOST_INCLUDEDIR and BOOST_LIBRARYDIR to the installation path of the Boost library.
    exit /b 1
)
if not exist "%BOOST_LIBRARYDIR%\boost_*.lib" (
    echo Boost library files were not found in this folder:
    echo    "%BOOST_LIBRARYDIR%"
    echo Please make sure Boost is correctly installed.
    exit /b 1
)

echo Found Boost headers in "%BOOST_INCLUDEDIR%" and libs in "%BOOST_LIBRARYDIR%"

:: -------------------------
:: OPENSSL_ROOT_DIR can be set to an existing OpenSSL installation.
:: If not, we use vcpkg to install the library
::
echo.
echo ... OpenSSL
if "%OPENSSL_ROOT_DIR%"=="" (
    %VCPKG% install openssl
    set OPENSSL_ROOT_DIR=%VCPKG_INSTALL%
)

if not exist "%VCPKG_INSTALL%/bin/protoc.exe" (
mkdir build
cd build
git clone https://github.com/protocolbuffers/protobuf
cd protobuf
git checkout v3.6.1
cd cmake
cmake . -A x64 -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_INSTALL_PREFIX=%VCPKG_INSTALL%
cmake --build . --config Release --target install
cd ..\..\..

)

set CMAKE_PREFIX_PATH=%VCPKG_INSTALL%

echo.
echo.
echo --------------------------------------------------
echo           CUDA_PATH ^| %CUDA_PATH%
echo             MKLROOT ^| %MKLROOT%
echo          VCPKG_ROOT ^| %VCPKG_ROOT%
echo    BOOST_INCLUDEDIR ^| %BOOST_INCLUDEDIR%
echo    BOOST_LIBRARYDIR ^| %BOOST_LIBRARYDIR%
echo    OPENSSL_ROOT_DIR ^| %OPENSSL_ROOT_DIR%
echo   CMAKE_PREFIX_PATH ^| %CMAKE_PREFIX_PATH%
echo --------------------------------------------------
echo.
echo.
exit /b 0
