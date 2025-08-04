# News App

A Flutter news application using Clean Architecture, Riverpod for state management, and GoRouter for navigation.

## Features

- Fetch news from NewsAPI
- View article details
- Save articles for offline reading
- Search functionality
- Dark/Light theme toggle
- Pagination
- Pull-to-refresh

## Architecture

The app follows Clean Architecture with three main layers:

1. **Presentation Layer**: Contains UI components, widgets, and state management.
2. **Domain Layer**: Contains business logic, entities, and use cases.
3. **Data Layer**: Handles data sources (remote and local) and repositories.

## Setup Instructions

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run the app with `flutter run`

## Dependencies

- flutter_riverpod: State management
- http: For API calls
- sqflite: For local storage
- url_launcher: For opening URLs in browser
- go_router: For navigation
- cached_network_image: For image caching

## Assumptions & Trade-offs

1. Used a simple SQLite database for local storage which might not be optimal for large datasets.
2. Error handling is basic and could be improved with more user-friendly messages.
3. Pagination is implemented with a simple page number increment.
