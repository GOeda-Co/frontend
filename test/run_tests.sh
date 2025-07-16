#!/bin/bash

echo "🧪 Running All Flutter Tests..."
echo "================================"

# Run unit tests first
echo "📦 Running Unit Tests..."
flutter test test/unit/ --coverage

# Run widget tests
echo "🎨 Running Widget Tests..."
flutter test test/widget/ --coverage

# Run all tests with coverage and randomization
echo "🔄 Running All Tests with Coverage..."
flutter test --coverage --test-randomize-ordering-seed random

# Check if tests passed
if [ $? -eq 0 ]; then
    echo "✅ All tests passed!"
    
    # Generate coverage report if lcov is available
    if command -v genhtml &> /dev/null; then
        echo "📊 Generating coverage report..."
        genhtml coverage/lcov.info -o coverage/html
        echo "📁 Coverage report generated at coverage/html/index.html"
    else
        echo "📊 Coverage data available at coverage/lcov.info"
        echo "💡 Install lcov to generate HTML coverage reports"
    fi
    
    echo ""
    echo "📋 Test Files Covered:"
    echo "Unit Tests:"
    echo "- Storage Tests: ✅"
    echo "- Theme Tests: ✅"
    echo "- Element Colors Tests: ✅"
    echo ""
    echo "Widget Tests:"
    echo "- Landing Page Tests: ✅"
    echo "- Decks Page Tests: ✅"
    echo "- Deck Info Tests: ✅"
    echo "- Create Deck Tests: ✅"
    echo "- Login Screen Tests: ✅"
    echo "- Signup Screen Tests: ✅"
    echo "- App Shell Tests: ✅"
else
    echo "❌ Some tests failed!"
    exit 1
fi 