@echo off
setlocal
cd /d "d:\Eder\workspace\hop_excel"
set FILTER_BRANCH_SQUELCH_WARNING=1

echo === 0) Stash cambios locales (incluye untracked) ===
git stash push -u -m "temp before secret purge"
if errorlevel 1 (
  echo WARN: stash fallo o no habia nada; sigo
)

echo.
echo === 1) Estado ===
git status -sb
git log --oneline -8

echo.
echo === 2) Purgar secreto del historial ===
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch proud-research-465822-a4-f5c16d908f08.json" --prune-empty -- --all
if errorlevel 1 (
  echo FAIL filter-branch
  git stash pop
  exit /b 1
)

git reflog expire --expire=now --all
git gc --prune=now --aggressive

echo.
echo === 3) Verificar (debe salir vacio) ===
git log --all --full-history -- "proud-research-465822-a4-f5c16d908f08.json"

echo.
echo === 4) Restaurar stash ===
git stash pop

echo.
echo === 5) Commit gitignore + script si hace falta ===
git add .gitignore scripts/fix_secret_and_push.bat
git status --porcelain | findstr /R "." >nul
if not errorlevel 1 (
  git commit -m "chore: ignore GCP credential files; add secret purge script"
)

echo.
echo === 6) Push ===
git push origin master
if errorlevel 1 (
  echo Regular push failed. Trying --force-with-lease...
  git push --force-with-lease origin master
  if errorlevel 1 (
    echo FAIL push
    exit /b 1
  )
)

echo.
echo === OK ===
git log --oneline -8
git status -sb
endlocal
