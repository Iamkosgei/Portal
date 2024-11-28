![example workflow](https://github.com/github/docs/actions/workflows/flutter_tests.yml/badge.svg)
**Portal** is a Flutter application designed to help users save questions with answers, respond to them, and receive feedback on their answers by indicating the correct responses. This app is built using a clean architecture approach, making it modular, testable, and scalable.

## SCREENSHOTS

<p float="left">
  <img src="https://github.com/user-attachments/assets/47590a5c-7271-40bb-843d-50dd4e98d62c" width="250" />
  <img src="https://github.com/user-attachments/assets/83d4d199-5559-4608-832b-c1ce820ea2e7" width="250" />
</p>
*Left: Android Interface | Right: iOS Interface*

## Demo Video

[![Watch the video](https://github.com/user-attachments/assets/c0a74568-1c7f-4d39-b49e-625caea9b245)](https://github.com/user-attachments/assets/c0a74568-1c7f-4d39-b49e-625caea9b245)

## Features

- **Question Creation**: Save questions along with their answers.
- **Answering**: Respond to questions and check the correct answers.
- **State Management**: Efficient state handling using `flutter_bloc`.
- **Local Database**: Persistent storage powered by `floor` and `sqflite`.
- **Navigation**: Smooth navigation using `go_router`.

## Dependencies

Here is a list of dependencies used in the project:

- **State Management**: `flutter_bloc`
- **Service Locator**: `injectable`, `get_it`
- **Fonts**: `google_fonts`
- **Routing**: `go_router`
- **Functional Programming**: `dartz`
- **JSON Serialization**: `freezed_annotation`, `json_annotation`
- **Database**: `floor`, `sqflite`
- **ID Generation**: `uuid`
- **Animations**: `lottie`
- **Audio**: `audioplayers`
- **Collection Utilities**: `collection`

### Complete Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_bloc: ^8.1.6
  injectable: ^2.1.2
  get_it: ^7.6.0
  google_fonts: ^6.1.0
  go_router: ^10.2.0
  dartz: ^0.10.1
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  floor: ^1.4.2
  sqflite: ^2.3.0
  uuid: ^4.5.1
  collection: ^1.18.0
  lottie: ^2.1.0
  audioplayers: ^6.1.0
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
  injectable_generator: ^2.1.6
  build_runner: ^2.3.3
  freezed: ^2.4.1
  json_serializable: ^6.7.1
  floor_generator: ^1.4.2
```

## Folder Structure

The project follows the Clean Architecture pattern, dividing the codebase into well-defined layers for easier maintenance and testing.

```
lib/
 ├── core/                   # Core functionalities (e.g., utilities, shared components)
 ├── features/               # Feature-based structure
 │    ├── questions/         # Question-related logic
 │    │    ├── data/         # Data sources, models, repositories
 │    │    ├── domain/       # Entities, use cases, repository interfaces
 │    │    └── presentation/ # UI (pages, widgets, controllers)
 │    ├── question_details/  # Feature to handle question details
 │    ├── submission/        # Submission functionality
 │    └── add_question/      # Add question feature
 └── main.dart               # Entry point of the application
```

## Getting Started

To run the application locally, follow these steps:

### Prerequisites

Ensure you have Flutter installed. For installation instructions, visit [flutter.dev](https://flutter.dev/docs/get-started/install).

### Running the App

1. Clone the repository:
   ```bash
   git clone git@github.com:Iamkosgei/Portal.git
   ```
2. Navigate to the project directory:
   ```bash
   cd portal
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```

## Contributing

Contributions are welcome! Please follow these steps for any improvements or bug fixes:

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.

## License

## This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
