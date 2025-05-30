# CPAD_team_07 - Snap Detect

**Snap Detect** is a Flutter-based mobile app that challenges users to find real-world objects using their device's camera and microphone. It runs AI models entirely offline for object detection and keyword matching, ensuring privacy and low-latency performance.

---

## 🚀 Running the App Locally

Follow these steps to set up and run the app on your local machine:

### 1. Clone the Repository

### 2. Install Dependencies

All required packages are listed in the `pubspec.yaml` file.  
To install them:

- Make sure you have Flutter installed on your system.
- Run:  
  `flutter pub get`

### 3. Prepare AI Assets

The app requires pre-trained offline models for object detection and keyword detection:

- Place the YOLOv5 TensorFlow Lite model and label file in the `assets/models` directory.
- Make sure these assets are correctly referenced in the `pubspec.yaml`.

### 4. Run the App

- Connect a physical Android or iOS device (or use an emulator).
- From the terminal, run:  
  `flutter run`

Make sure you grant all required permissions (camera, microphone, storage) when prompted.

---

## 🧩 Key Features

- Offline YOLOv5 object detection on image
- Local history saved using Hive (lightweight local database)
- Gallery screen to view past attempts with playback

---

## 📦 Dependencies

Some of the key Flutter packages used include:

- `camera`
- `tflite_flutter`
- `permission_handler`
- `path_provider`

These are all automatically installed when you run `flutter pub get`.

---

## 📁 Project Structure

- `lib/`: Main source code (UI, logic, etc.)
- `assets/models/`: TFLite models and label files
- `pubspec.yaml`: Project metadata and dependencies
- `README.md`: Project overview and setup instructions

---

## 🛠 Development Notes

- Designed for offline use — no network required
- Optimized for mobile use, especially on Android devices
- You may extend the object list or support more AI models easily

---

## 📜 License

This project is licensed under the MIT License. Feel free to use, modify, and distribute it.

---

# 👨‍💻 Contributors

- [Rachel Negi](https://github.com/RachelNegi)
- [Akshita Dhiman](https://github.com/AkshitaDhim)
- [Sourajit Mandal](https://github.com/Sourajit-812)
