@echo off
setlocal enabledelayedexpansion

:: Parfly Development Setup Script for Windows
:: This script automates the initial setup for Parfly development environment

echo.
echo 🚀 Starting Parfly Development Setup...
echo.

:: Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js is not installed. Please install Node.js v18 or higher.
    pause
    exit /b 1
)

echo [SUCCESS] Node.js version: 
node --version

:: Check if PostgreSQL is installed
psql --version >nul 2>&1
if errorlevel 1 (
    echo [WARNING] PostgreSQL is not installed or not in PATH. Please install PostgreSQL.
)

:: Check if Expo CLI is installed
expo --version >nul 2>&1
if errorlevel 1 (
    echo [INFO] Installing Expo CLI...
    npm install -g @expo/cli
    echo [SUCCESS] Expo CLI installed
) else (
    echo [SUCCESS] Expo CLI is already installed
)

:: Install backend dependencies
echo [INFO] Installing backend dependencies...
cd Parfly-Backend
if not exist ".env" (
    copy .env.example .env
    echo [WARNING] Created .env file from .env.example. Please update with your credentials.
)
call npm install
echo [SUCCESS] Backend dependencies installed

:: Install admin panel dependencies
echo [INFO] Installing admin panel dependencies...
cd ..\Parfly-Admin
call npm install
echo [SUCCESS] Admin panel dependencies installed

:: Install customer app dependencies
echo [INFO] Installing customer app dependencies...
cd ..\Parfly-Customer-App
if not exist ".env" (
    copy .env.example .env
    echo [WARNING] Created .env file from .env.example. Please update with your API keys.
)
call npm install
echo [SUCCESS] Customer app dependencies installed

:: Install driver app dependencies
echo [INFO] Installing driver app dependencies...
cd ..\Parfly-Driver-App
if not exist ".env" (
    copy .env.example .env
    echo [WARNING] Created .env file from .env.example. Please update with your API keys.
)
call npm install
echo [SUCCESS] Driver app dependencies installed

cd ..

echo.
echo [SUCCESS] 🎉 Setup completed successfully!
echo.
echo [INFO] Next steps:
echo 1. Update environment variables in each .env file
echo 2. Set up your PostgreSQL database
echo 3. Obtain API keys for TomTom and Google Maps
echo 4. Start the development servers:
echo.
echo    Backend:      cd Parfly-Backend ^&^& npm run dev
echo    Admin Panel:  cd Parfly-Admin ^&^& npm run dev
echo    Customer App: cd Parfly-Customer-App ^&^& npx expo start
echo    Driver App:   cd Parfly-Driver-App ^&^& npx expo start
echo.
echo [INFO] Happy coding! 🚀
echo.
pause
