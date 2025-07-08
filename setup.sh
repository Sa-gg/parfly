#!/bin/bash

# Parfly Development Setup Script
# This script automates the initial setup for Parfly development environment

echo "🚀 Starting Parfly Development Setup..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed. Please install Node.js v18 or higher."
    exit 1
fi

# Check Node.js version
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    print_error "Node.js version 18 or higher is required. Current version: $(node -v)"
    exit 1
fi

print_success "Node.js version: $(node -v)"

# Check if PostgreSQL is installed
if ! command -v psql &> /dev/null; then
    print_warning "PostgreSQL is not installed or not in PATH. Please install PostgreSQL."
fi

# Check if Expo CLI is installed
if ! command -v expo &> /dev/null; then
    print_status "Installing Expo CLI..."
    npm install -g @expo/cli
    print_success "Expo CLI installed"
else
    print_success "Expo CLI is already installed"
fi

# Install backend dependencies
print_status "Installing backend dependencies..."
cd Parfly-Backend
if [ ! -f ".env" ]; then
    cp .env.example .env
    print_warning "Created .env file from .env.example. Please update with your credentials."
fi
npm install
print_success "Backend dependencies installed"

# Install admin panel dependencies
print_status "Installing admin panel dependencies..."
cd ../Parfly-Admin
npm install
print_success "Admin panel dependencies installed"

# Install customer app dependencies
print_status "Installing customer app dependencies..."
cd ../Parfly-Customer-App
if [ ! -f ".env" ]; then
    cp .env.example .env
    print_warning "Created .env file from .env.example. Please update with your API keys."
fi
npm install
print_success "Customer app dependencies installed"

# Install driver app dependencies
print_status "Installing driver app dependencies..."
cd ../Parfly-Driver-App
if [ ! -f ".env" ]; then
    cp .env.example .env
    print_warning "Created .env file from .env.example. Please update with your API keys."
fi
npm install
print_success "Driver app dependencies installed"

cd ..

echo ""
print_success "🎉 Setup completed successfully!"
echo ""
print_status "Next steps:"
echo "1. Update environment variables in each .env file"
echo "2. Set up your PostgreSQL database"
echo "3. Obtain API keys for TomTom and Google Maps"
echo "4. Start the development servers:"
echo ""
echo "   Backend:      cd Parfly-Backend && npm run dev"
echo "   Admin Panel:  cd Parfly-Admin && npm run dev"
echo "   Customer App: cd Parfly-Customer-App && npx expo start"
echo "   Driver App:   cd Parfly-Driver-App && npx expo start"
echo ""
print_status "Happy coding! 🚀"
