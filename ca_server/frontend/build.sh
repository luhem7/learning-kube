#!/bin/bash

# CA Server Frontend Production Build Script
# This script builds the compressed production version of the React frontend

set -e  # Exit on any error

echo "🚀 Building CA Server Frontend for Production..."
echo "=================================================="

# Clean previous build
if [ -d "dist" ]; then
    echo "🧹 Cleaning previous build..."
    rm -rf dist/
fi

# Run the build
echo "📦 Building application..."
npm run build

# Display build results
if [ -d "dist" ]; then
    echo "✅ Build completed successfully!"
    echo ""
    echo "📊 Build Summary:"
    echo "=================="
    
    # Show size of key files
    if [ -f "dist/index.html" ]; then
        echo "📄 index.html: $(ls -lh dist/index.html | awk '{print $5}')"
    fi
    
    if [ -d "dist/assets" ]; then
        echo "📁 Assets directory:"
        ls -lah dist/assets/ | tail -n +2 | while read line; do
            echo "   $line"
        done
    fi
    
    echo ""
    echo "🎯 Production build is ready in ./dist/"
    echo "💡 You can serve it with: npm run preview"
    echo "🐳 Or copy ./dist/ contents to your web server"
else
    echo "❌ Build failed - no dist directory created"
    exit 1
fi