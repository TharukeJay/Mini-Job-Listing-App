# Job Listing App

A simple **Job Listing Mobile Application** built with **Flutter** for the Software Engineer Flutter Assessment Test.

The app demonstrates:
- Material 3 UI & responsiveness
- REST API integration
- State management with Provider
- Local storage for favorites
- Error handling
- Clean architecture

---

## Features

- **Job List Page**
    - Fetches jobs from a mock REST API (https://68b6869573b3ec66cec1ceef.mockapi.io/api/v1/job).
    - Displays job title, company, location, and type.
    - Includes a search bar to filter jobs by **title** or **location**.
    - Favorite jobs with a heart button.

- **Job Details Page**
    - Shows full job details (description, salary etc.).
    - "Apply" button.
    - Favorite toggle in AppBar.

- **Favorites Page**
    - Displays list of favorite jobs.
    - Data is persisted using **SharedPreferences**.

- **Bonus Features**
    - Theme toggle (**light / dark **).
    - Animated favorite icons with **scale transition**.
    - Page transitions with **fade animations**.

---

## Setup Instructions

1. **Clone Repository**
   ```bash
   git clone https://github.com/TharukeJay/Mini-Job-Listing-App.git
   cd job_listing_app
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the App**
   ```bash
   flutter run
   ```

4. **Tested On**
    - Flutter 3.22+
    - Android Emulator

---

## Architecture

This app follows a **layered clean architecture approach**:

- **Data Layer** → Fetches and parses job data from REST API.
- **Domain Layer** → Business logic (state management via Provider).
- **Presentation Layer** → UI screens and Material 3 widgets.

---

## State Management

- Used **Provider** (`ChangeNotifier`) to manage:
    - Jobs fetching from API
    - Favorites (with persistence)
    - Search functionality
    - Theme switching

---
