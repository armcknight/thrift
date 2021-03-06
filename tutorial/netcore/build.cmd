@echo off
rem /*
rem  * Licensed to the Apache Software Foundation (ASF) under one
rem  * or more contributor license agreements. See the NOTICE file
rem  * distributed with this work for additional information
rem  * regarding copyright ownership. The ASF licenses this file
rem  * to you under the Apache License, Version 2.0 (the
rem  * "License"); you may not use this file except in compliance
rem  * with the License. You may obtain a copy of the License at
rem  *
rem  *   http://www.apache.org/licenses/LICENSE-2.0
rem  *
rem  * Unless required by applicable law or agreed to in writing,
rem  * software distributed under the License is distributed on an
rem  * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
rem  * KIND, either express or implied. See the License for the
rem  * specific language governing permissions and limitations
rem  * under the License.
rem  */
setlocal

cd Interfaces
thrift  -gen netcore:wcf   -r  ..\..\tutorial.thrift
cd ..

rem * Due to a known issue with "dotnet restore" the Thrift.dll dependency cannot be resolved from cmdline
rem * For details see https://github.com/dotnet/cli/issues/3199 and related tickets
rem * The problem does NOT affect Visual Studio builds.

rem * workaround for "dotnet restore" issue
xcopy ..\..\lib\netcore\Thrift .\Thrift  /YSEI  >NUL

dotnet --info
dotnet restore

dotnet build **/*/project.json -r win10-x64 
dotnet build **/*/project.json -r osx.10.11-x64 
dotnet build **/*/project.json -r ubuntu.16.04-x64 

rem * workaround for "dotnet restore" issue
del .\Thrift\*  /Q /S  >NUL
rd  .\Thrift    /Q /S  >NUL


:eof
