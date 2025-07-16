#!/bin/bash

# Unit Tests Runner Script
# This script runs all unit tests in the project

echo "🧪 Running Unit Tests..."
echo "================================"

# Run storage tests
echo "📦 Testing Storage Classes..."
flutter test test/unit/storage_test.dart

# Run theme tests
echo "🎨 Testing Theme Classes..."
flutter test test/unit/theme_test.dart

# Run element colors tests
echo "🎨 Testing Element Colors..."
flutter test test/unit/element_colors_test.dart

echo "================================"
echo "✅ Unit tests completed!" 