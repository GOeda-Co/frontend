#!/bin/bash

# Widget Tests Runner Script
# This script runs all widget tests in the project

echo "🎨 Running Widget Tests..."
echo "================================"

# Run all widget tests
flutter test test/widget/ --coverage

# Check if tests passed
if [ $? -eq 0 ]; then
    echo "✅ All widget tests passed!"
    
    # Generate coverage report if lcov is available
    if command -v genhtml &> /dev/null; then
        echo "📊 Generating widget test coverage report..."
        genhtml coverage/lcov.info -o coverage/html
        echo "📁 Coverage report generated at coverage/html/index.html"
    else
        echo "📊 Coverage data available at coverage/lcov.info"
        echo "💡 Install lcov to generate HTML coverage reports"
    fi
    
    echo ""
    echo "📋 Widget Test Files Covered:"
    echo "- Landing Page Tests: ✅"
    echo "- Decks Page Tests: ✅"
    echo "- Deck Info Tests: ✅"
    echo "- Create Deck Tests: ✅"
    echo "- Login Screen Tests: ✅"
    echo "- Signup Screen Tests: ✅"
    echo "- App Shell Tests: ✅"
else
    echo "❌ Some widget tests failed!"
    exit 1
fi 