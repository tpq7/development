::
:: Ovobot
::

@echo off

:: Get the source path
set /p path_to_source=Enter the file:
:: a method for removing the surrounding quotes when spaces are used
::  in the path of a passed directory
set path_to_source=%path_to_source:"=%
:: and the types of files to format
set cpp=*.cpp
set cc=*.cc
set c=*.c
set h=*.h
set hh=*.hh
set hh=*.hpp

echo.
echo formating files of type:
echo %path_to_source%
echo.

AStyle --options=style_no_recursive.txt "%path_to_source%"

pause