@echo off
cd /d "%~dp0\.."
java -cp h2-2.4.240.jar org.h2.tools.RunScript -url "jdbc:h2:tcp://localhost:9092/~/test" -user sa -password "" -script "sql\create_LISTA_MA_4.sql" -showResults
if errorlevel 1 (
  echo FAIL: H2 server down? Start with: java -cp h2-2.4.240.jar org.h2.tools.Server -tcp -web
  exit /b 1
)
echo OK: LISTA_MA_4 created
