# Front-End Test (Vista)

Flutter app for managing companies and their services. It connects to the REST API in the [back-end-test-vista](https://github.com/khalisahamani/back-end-test-vista) repository.

## Features

- List all companies (name + registration number) with their services
- Create a company (validated: non-empty fields)
- Create a service under a company (validated: non-empty fields, numeric price, company dropdown)
- Loading indicators, error messages and pull-to-refresh
- Responsive layout (content is centered with a max width on wide screens)

## Tech

- Flutter
- `http` for API requests
- `provider` for state management

## Prerequisites

- Flutter SDK installed (`flutter doctor` should show no blocking issues)
- The backend running on `http://localhost:3000` (see the backend README)

## Setup

1. Clone the repository and install dependencies:

   ```
   flutter pub get
   ```

2. Start the backend first (MySQL running, then `npm run dev` in the backend project).

3. Check the API URL in `lib/services/api_service.dart`:

   | Target                    | Base URL                |
   |---------------------------|-------------------------|
   | Chrome / Windows desktop  | `http://localhost:3000` |
   | Android emulator          | `http://10.0.2.2:3000`  |
   | Physical phone            | `http://<your-pc-ip>:3000` |

   Android emulator and web are handled automatically. Change the code only if your backend uses a different port or you test on a physical device.

## Run

```
flutter run -d chrome
```

Or run `flutter run` and pick a device from the list.

## Project structure

```
lib/
├── main.dart
├── models/          Company and Service models
├── services/        ApiService (HTTP calls)
├── providers/       CompanyProvider (state management)
└── screens/
    ├── company_list_screen.dart
    ├── create_company_screen.dart
    └── create_service_screen.dart
```

## API endpoints used

| Method | Path        | Used for                           |
|--------|-------------|------------------------------------|
| GET    | /companies  | List companies with their services |
| POST   | /companies  | Create a company                   |
| POST   | /services   | Create a service under a company   |