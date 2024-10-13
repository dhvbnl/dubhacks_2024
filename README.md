# Stills App - README

## Overview

**Stills** is a personal media application that provides users with a daily creative prompt to encourage mindfulness and creativity. The user takes a photo each day based on the prompt, such as "something with red" or "shadows," building a unique gallery of personal photos over time. Unlike traditional social media, Stills emphasizes wellness and personal reflection by disconnecting from the external world and focusing on individual creativity without the pressure of social comparison.

The app is being developed for a hackathon under the health and wellness track, aiming to help users foster a sense of calm, creativity, and personal growth.

## Table of Contents

1. [Features](#features)
2. [Technology Stack](#technology-stack)
3. [File Structure](#file-structure)
4. [Installation](#installation)
5. [Usage](#usage)
6. [Main Components](#main-components)
    - Still Model
    - Camera Page
    - HomePage
    - History Page
    - Data Storage
7. [Future Enhancements](#future-enhancements)
8. [Contributing](#contributing)
9. [License](#license)

---

## Features

- **Daily Prompts**: The app generates a creative prompt each day to inspire the user to take a photo.
- **Photo Gallery**: Over time, users build a collection of photos based on daily prompts.
- **Secure Local Storage**: Photos and data are stored locally and securely, using encryption to ensure privacy.
- **Camera Functionality**: The app uses the phone's camera to capture photos within the app.
- **Simple and Minimalistic UI**: A clean and distraction-free interface to help users focus on creativity and self-expression.

---

## Technology Stack

- **Frontend**: Flutter (with Material and Cupertino widgets)
- **Local Database**: Hive for secure data storage
- **Backend Services**: Local storage only (no external servers)
- **Security**: Flutter Secure Storage, Hive AES Encryption
- **Plugins/Packages**:
  - `camera`: For camera functionality
  - `path_provider`: For accessing file paths in the local system
  - `flutter_secure_storage`: For securely storing the encryption keys
  - `hive_flutter`: For local data storage with encryption

---

## File Structure

```
├── lib
│   ├── models
│   │   └── still.dart        # Defines the Still object and its properties
│   ├── views
│   │   ├── camera.dart       # Manages camera functionality
│   │   ├── homepage.dart     # The main landing page displaying the daily prompt
│   │   ├── history.dart      # Displays the history of past photos
│   └── main.dart             # Initializes the app and manages secure storage setup
└── pubspec.yaml              # Lists dependencies and configurations
```

---

## Installation

### Prerequisites

- **Flutter SDK**: Ensure Flutter is installed. Follow the official [Flutter installation guide](https://flutter.dev/docs/get-started/install).
- **Dart**: Dart comes bundled with Flutter but ensure it's available on your machine.

### Steps to Set Up

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   ```

2. **Navigate to the project directory**:
   ```bash
   cd stills-app
   ```

3. **Install dependencies**:
   ```bash
   flutter pub get
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

---

## Usage

1. **Daily Prompt**: Each day, the app presents a creative prompt. Users can take a photo based on the prompt using the built-in camera.
2. **Gallery**: The photos are stored locally and can be viewed at any time through the app's history page.
3. **Secure Storage**: All photos are stored in an encrypted Hive database, ensuring that personal photos remain private.

---

## Main Components

### 1. **Still Model (`still.dart`)**

The `Still` class represents a photo taken by the user with the following attributes:
- `id`: A unique identifier for the still.
- `prompt`: The daily prompt associated with the photo.
- `date`: The date the photo was taken.
- `photo`: The image itself, stored as an `AssetImage`.

The `Still.create()` factory method is used to create new `Still` objects with unique IDs and timestamps.

### 2. **Camera Page (`camera.dart`)**

The camera page is responsible for the following:
- Initializing and controlling the device camera.
- Capturing photos.
- Saving photos to the local file system.
- Handling potential errors in the camera setup and operation.

### 3. **HomePage (`homepage.dart`)**

The HomePage is the first screen the user sees. It features:
- The current daily prompt (e.g., "a pop of red").
- A button to open the camera and capture a photo.
- A button to view the user's history of past photos.

### 4. **History Page (`history.dart`)**

This page will display all the user's previous photos, giving them the ability to look back at their personal gallery. Currently, this is a placeholder for future implementation.

### 5. **Main App (`main.dart`)**

The `main.dart` file is the entry point of the app. It:
- Initializes the Hive local database and the secure storage for encryption keys.
- Registers the `StillAdapter` for Hive so that `Still` objects can be serialized and deserialized.
- Provides the app's theme and basic layout structure using Flutter's platform-adaptive widgets (Material/Cupertino).

---

## Future Enhancements

- **Enhanced History Page**: Allow users to browse through their photo history with a better UI and additional functionality like filtering photos by prompt or date.
- **Cloud Syncing**: Provide an option to sync photos to cloud storage for backup.
- **Notification System**: Remind users to take a daily photo based on the prompt.
- **Customization of Prompts**: Allow users to set their own prompts or choose from a larger pool of predefined prompts.

---