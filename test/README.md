# Tests for Repeatro Frontend

This directory contains comprehensive tests for the Repeatro Flutter application, including both unit tests and widget tests.

## Test Structure

### Unit Tests (`test/unit/`)
- **storage_test.dart**: Tests for storage classes (SecureStorage, TokenStorage, TokenStorageWrapper)
- **theme_test.dart**: Tests for theme generation and color schemes
- **element_colors_test.dart**: Tests for UI color constants and values

### Widget Tests (`test/widget/`)
- **create_deck_test.dart**: Tests for the `CreateDeckPage` widget
- **deck_info_test.dart**: Tests for the `FlashcardPage` widget  
- **decks_page_test.dart**: Tests for the `DecksPage` widget
- **landing_page_test.dart**: Tests for the `LandingPage` widget
- **log_in_screen_test.dart**: Tests for the `LoginScreen` widget
- **sign_up_screen_test.dart**: Tests for the `SignUpScreen` widget
- **app_shell_test.dart**: Tests for the `AppShell` widget

### `create_deck_test.dart`
Comprehensive tests for the `CreateDeckPage` widget covering:

#### 🎯 Initial UI Tests
- Verifies all UI elements are displayed correctly
- Checks initial card count (3 cards by default)
- Validates card structure and numbering

#### 📝 Card Management Tests
- Adding new cards via "Add Card" button
- Removing cards via delete button
- Multiple card additions and removals
- Dynamic UI updates

#### ⌨️ Form Input Tests
- Text input in title and description fields
- Card word and translation input
- Multiple card input handling
- Input validation

#### ✅ Form Validation Tests
- Empty form submission validation
- Partial form completion validation
- Card requirement validation
- Valid data submission

#### 🖱️ UI Interaction Tests
- Keyboard input handling
- Focus management
- Scrolling with many cards
- Touch interactions

#### ♿ Accessibility Tests
- Semantic labels for screen readers
- Proper text field labeling
- Accessibility compliance

#### 🔍 Edge Cases Tests
- Very long text input handling
- Special characters and Unicode support
- Rapid button presses
- Memory stress testing

#### 🧠 Memory Management Tests
- Controller disposal
- Widget lifecycle management
- Memory leak prevention

### `deck_info_test.dart`
Comprehensive tests for the `FlashcardPage` widget covering:

#### 🎯 Initial UI Tests
- App bar title and action buttons
- Loading indicator display
- Study and Delete button presence

#### 📱 Loading State Tests
- Loading indicator while fetching cards
- Proper state transitions

#### 📭 Empty State Tests
- Empty deck message display
- Study button disabled state
- Proper empty state handling

#### 🃏 Card Display Tests
- Card word and translation display
- Card container styling
- Navigation arrow presence

#### 🔄 Card Navigation Tests
- Next/previous card navigation
- Circular navigation (wrap-around)
- Arrow button functionality

#### 🔄 Card Flip Tests
- Tap to flip card functionality
- Word/translation toggle
- Flip state management between cards
- Missing translation handling

#### 📚 Study Mode Tests
- Study button enabling/disabling
- Navigation to learning page
- Study mode activation

#### 🗑️ Delete Functionality Tests
- Delete button presence and functionality
- Error message display on failure
- Delete operation handling

#### 🎨 UI Layout Tests
- Card dimensions and styling
- Proper spacing and layout
- Responsive design testing

#### ♿ Accessibility Tests
- Semantic labels for buttons
- Screen reader support
- Text readability

#### 🔍 Edge Cases Tests
- Single card deck handling
- Long text display
- Rapid navigation and flipping
- Performance under stress

#### 🧠 Memory Management Tests
- Resource disposal
- Widget lifecycle management

#### ⚠️ Error Handling Tests
- API error graceful handling
- Network timeout handling

### `decks_page_test.dart`
Comprehensive tests for the `DecksPage` widget covering:

#### 🎯 Initial UI Tests
- Main page structure verification
- Proper padding configuration (25.0 left padding)
- RecentsSection and StatsSection component display
- Proper spacing between sections (48px)

#### 🏗️ Layout Structure Tests
- Column alignment and children structure
- Responsive design for different screen sizes
- Small screen handling
- Component integration verification

#### 🔗 Component Integration Tests
- RecentsSection integration
- StatsSection integration
- Component loading state handling
- Integration error prevention

#### 📱 Loading State Tests
- Page display during component loading
- Loading state transitions
- Graceful loading handling

#### 🧭 Navigation Tests
- Navigation from RecentsSection
- Navigation context maintenance
- Component navigation handling

#### 📐 Responsive Design Tests
- Different screen orientations (portrait/landscape)
- Tablet screen size handling
- Desktop screen size handling
- Cross-platform compatibility

#### ♿ Accessibility Tests
- Semantic structure verification
- Screen reader support
- Focus management
- Accessibility compliance

#### ⚡ Performance Tests
- Efficient rendering
- Rapid rebuild handling
- Memory efficiency
- Performance optimization

#### 🔍 Edge Cases Tests
- Long content handling
- Rapid user interactions
- Component error handling
- Network error handling

#### 🧠 Memory Management Tests
- Resource disposal
- Widget lifecycle management
- Memory leak prevention

#### 🔧 Integration Tests
- MaterialApp navigation compatibility
- Theme change handling
- Locale change handling
- System integration

#### ⚠️ Error Handling Tests
- Component loading failures
- API errors in components
- Widget tree errors
- Graceful error handling

#### 🔄 State Management Tests
- State maintenance during rebuilds
- Child component state changes
- State synchronization

### `landing_page_test.dart`
Comprehensive tests for the `LandingPage` widget covering:

#### 🎯 Initial UI Tests
- Main landing page structure verification
- App bar title and navigation buttons
- Main heading text display
- Learn more button presence
- Image carousel structure

#### 🧭 App Bar Tests
- App bar styling and configuration
- Button styling and spacing
- Navigation button functionality
- Proper toolbar height (65px)

#### 🧭 Navigation Tests
- Sign up button navigation
- Log in button navigation
- TEMP App Shell button navigation
- Navigation context maintenance
- Route configuration

#### 🖼️ Image Carousel Tests
- Correct number of images (3)
- Carousel structure and components
- Image styling and containers
- Carousel scrolling functionality
- Viewport fraction configuration (0.75)

#### 🔘 Learn More Button Tests
- Carousel navigation functionality
- Button styling verification
- Animation triggering
- State management

#### 📐 Responsive Design Tests
- Different screen sizes handling
- Mobile screen compatibility
- Tablet screen compatibility
- Desktop screen compatibility
- Cross-platform responsiveness

#### 🏗️ Layout Structure Tests
- Row and column structure
- Padding configuration
- Spacing between elements
- Flex configuration
- Expanded widget usage

#### 🎬 Animation Tests
- Carousel animations
- Page transitions
- Scale animations
- Transform effects
- Animation performance

#### 🎨 Theme and Styling Tests
- Theme application
- Text styling verification
- Color scheme implementation
- Visual consistency

#### ♿ Accessibility Tests
- Semantic structure
- Screen reader support
- Focus management
- Accessibility compliance

#### ⚡ Performance Tests
- Efficient rendering
- Rapid interaction handling
- Memory efficiency
- Performance optimization

#### 🔍 Edge Cases Tests
- Very small screen handling
- Rapid carousel scrolling
- Missing image handling
- Navigation error handling

#### 🧠 Memory Management Tests
- PageController disposal
- Widget lifecycle management
- Resource cleanup
- Memory leak prevention

#### 🔧 Integration Tests
- MaterialApp navigation compatibility
- Theme change handling
- Locale change handling
- System integration

#### ⚠️ Error Handling Tests
- Image loading errors
- Navigation errors
- Animation errors
- Graceful error handling

#### 🔄 State Management Tests
- Carousel state maintenance
- State change handling
- Component state synchronization

### `log_in_screen_test.dart`
Comprehensive tests for the `LoginScreen` widget covering:

#### 🎯 Initial UI Tests
- Login screen structure verification
- App bar with white background
- Container styling and layout
- Input field presence and styling
- Button styling and configuration

#### 📝 Form Input Tests
- Email field text input
- Password field text input
- Password visibility toggle
- Delete button functionality for all fields
- Input validation and error handling

#### ✅ Form Validation Tests
- Empty email validation
- Invalid email format validation
- Short password validation
- Empty password validation
- Error dialog display and dismissal

#### 🔐 Authentication Tests
- Successful login flow
- Failed login handling
- API integration testing
- Token storage verification
- Navigation after successful login

#### 🧭 Navigation Tests
- Sign up button navigation
- Login button functionality
- Route handling and transitions

#### ♿ Accessibility Tests
- Semantic labels for input fields
- Screen reader navigation support
- Keyboard navigation testing
- Accessibility compliance

#### 🔍 Edge Cases Tests
- Very long input handling
- Special characters in input
- Rapid button presses
- Rapid text input
- Whitespace handling

#### 🧠 Memory Management Tests
- Text controller disposal
- Widget lifecycle management
- API call interruption handling
- Memory leak prevention

#### ⚠️ Error Handling Tests
- JSON decode errors
- Token storage errors
- Navigation errors
- API exception handling
- Null response handling

#### ⚡ Performance Tests
- Quick rendering
- Efficient state changes
- Rapid interaction handling

### `app_shell_test.dart`
Comprehensive tests for the `AppShell` widget covering:

#### 🎯 Initial UI Tests
- AppShell structure verification
- Navigation rail styling and layout
- Main content area styling
- Navigation items presence and order
- TopBar integration and title display
- Profile avatar styling

#### 🧭 Navigation Tests
- Navigation to Decks page
- Navigation to Cards page
- Navigation to Create Deck page
- Navigation to Profile page
- Conditional Create button display
- Navigation state management

#### 🔄 State Management Tests
- Selected index state maintenance
- Navigation item color updates
- Profile avatar color updates
- Page switching functionality

#### 🖱️ User Interaction Tests
- Create button press handling
- Rapid navigation between pages
- Multiple button press handling
- Snackbar display verification

#### ♿ Accessibility Tests
- Semantic labels for navigation items
- Tooltip presence and functionality
- Keyboard navigation support
- Focus management

#### 🔍 Edge Cases Tests
- Widget disposal during navigation
- Rapid state changes
- Theme changes handling
- Different screen sizes
- Locale changes

#### 🧠 Memory Management Tests
- Resource disposal
- Widget lifecycle management
- Button press interruption handling

#### ⚠️ Error Handling Tests
- Navigation error handling
- Theme error handling
- Graceful error recovery

#### ⚡ Performance Tests
- Quick rendering
- Rapid navigation efficiency
- Button press efficiency

#### 🔧 Integration Tests
- MaterialApp integration
- Theme integration
- Locale integration

### `sign_up_screen_test.dart`
Comprehensive tests for the `SignUpScreen` widget covering:

#### 🎯 Initial UI Tests
- Signup screen structure verification
- App bar with white background
- Container styling and layout
- Three input fields (name, email, password)
- Button styling and configuration

#### 📝 Form Input Tests
- Name field text input
- Email field text input
- Password field text input
- Password visibility toggle
- Delete button functionality for all fields
- Input validation and error handling

#### ✅ Form Validation Tests
- Empty name validation
- Empty email validation
- Invalid email format validation
- Short password validation
- Empty password validation
- Error dialog display and dismissal

#### 🔐 Registration Tests
- Successful registration flow
- Failed registration handling
- API integration testing
- User ID and message handling
- Navigation after successful registration

#### 🧭 Navigation Tests
- Login button navigation
- Registration flow navigation
- Route handling and transitions

#### ♿ Accessibility Tests
- Semantic labels for input fields
- Screen reader navigation support
- Keyboard navigation testing
- Accessibility compliance

#### 🔍 Edge Cases Tests
- Very long input handling
- Special characters in input
- Rapid button presses
- Rapid text input
- Whitespace handling in name field

#### 🧠 Memory Management Tests
- Text controller disposal
- Widget lifecycle management
- API call interruption handling
- Memory leak prevention

#### ⚠️ Error Handling Tests
- JSON decode errors
- Navigation errors
- API exception handling
- Null response handling



## Running Tests

### Running Unit Tests

To run unit tests only:
```bash
# Run all unit tests
flutter test test/unit/

# Run specific unit test
flutter test test/unit/storage_test.dart
flutter test test/unit/theme_test.dart
flutter test test/unit/element_colors_test.dart

# Or use the unit test runner script
chmod +x test/unit/run_unit_tests.sh
./test/unit/run_unit_tests.sh
```

### Running Widget Tests

To run widget tests only:
```bash
# Run all widget tests
flutter test test/widget/

# Run specific widget test
flutter test test/widget/create_deck_test.dart
flutter test test/widget/deck_info_test.dart
flutter test test/widget/decks_page_test.dart
flutter test test/widget/landing_page_test.dart
flutter test test/widget/log_in_screen_test.dart
flutter test test/widget/sign_up_screen_test.dart
flutter test test/widget/app_shell_test.dart

# Or use the widget test runner script
chmod +x test/widget/run_widget_tests.sh
./test/widget/run_widget_tests.sh

### Running All Tests

```bash
# Run all tests (unit + widget)
flutter test

# Run with Coverage
flutter test --coverage

# Run with Verbose Output
flutter test --verbose

# Run Tests in Random Order
flutter test --test-randomize-ordering-seed random

# Using the Test Runner Script
chmod +x test/run_tests.sh
./test/run_tests.sh
```

## Test Coverage

The tests aim to achieve high coverage by testing:

- **UI Rendering**: All widgets display correctly
- **User Interactions**: Button taps, text input, scrolling
- **State Management**: Card addition/removal, form state
- **Validation**: Form validation and error messages
- **Edge Cases**: Unusual inputs and scenarios
- **Accessibility**: Screen reader support
- **Memory**: Proper resource cleanup

## Adding New Tests

When adding new tests:

1. **Group related tests** using `group()` blocks
2. **Use descriptive test names** that explain what is being tested
3. **Test both success and failure scenarios**
4. **Include edge cases** and error conditions
5. **Test accessibility** features
6. **Verify memory management** for complex widgets

### Example Test Structure
```dart
group('Feature Name Tests', () {
  testWidgets('should do something when condition is met', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(createTestWidget());
    
    // Act
    await tester.tap(find.text('Button'));
    await tester.pump();
    
    // Assert
    expect(find.text('Expected Result'), findsOneWidget);
  });
});
```

## Best Practices

1. **Isolate tests**: Each test should be independent
2. **Use meaningful assertions**: Test behavior, not implementation
3. **Test user workflows**: Focus on user interactions
4. **Keep tests fast**: Avoid unnecessary delays
5. **Use proper setup/teardown**: Clean up resources
6. **Test error conditions**: Don't just test happy paths

## Dependencies

The tests use:
- `flutter_test`: Core testing framework
- `mockito`: For mocking dependencies (when needed)
- `network_image_mock`: For mocking network images

## Continuous Integration

These tests are designed to run in CI/CD pipelines and provide:
- Fast feedback on UI changes
- Regression detection
- Code quality assurance
- Documentation of expected behavior 