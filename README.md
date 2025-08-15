# 🌦️ Flutter Weather App

> **A Flutter application that displays current weather conditions and an hourly forecast for a specified city using the OpenWeatherMap API.**

---

## ✨ Features

-   **Current Weather:** Shows current temperature, sky condition (with corresponding icon), atmospheric pressure, wind speed, and humidity.
-   **Hourly Forecast:** Displays a 5-slot hourly forecast including time, weather icon, and temperature.
-   **Dynamic Time Calculation:** Accurately calculates and displays forecast times based on the city's timezone.
-   **API Integration:** Fetches weather data from the [OpenWeatherMap API](https://openweathermap.org/api).
-   **Custom UI Components:** Uses custom widgets for `HourlyForecastItem` and `AdditionalInfoItem` for a clean and modular UI.
-   **Refresh Functionality:** Allows users to manually refresh the weather data.
-   **Error Handling:** Displays error messages if the API call fails or returns an error.


---

## 🛠️ Tech Stack & Dependencies

-   **Framework:** Flutter (`sdk: ^3.8.1`)
-   **Language:** Dart
-   **Core Flutter Packages:**
    -   `flutter/material.dart`
-   **External Packages:**
    -   `http: ^1.5.0` (for making API requests)
    -   `intl: ^0.19.0` (for date/time formatting)
    -   `cupertino_icons: ^1.0.8` (though Material Icons seem to be primarily used)
-   **API:** OpenWeatherMap

---

## 📁 Project Structure (Key Files)


```
weatherapp/
├── lib/
│   ├── main.dart                 # Main application entry point
│   ├── weather_screen.dart       # Main UI for displaying weather
│   ├── hourly_forecast_item.dart # Widget for individual hourly forecast
│   ├── additional_info_item.dart # Widget for additional info (humidity, wind, pressure)
│   └── apikeysofwether.dart      # IMPORTANT: Contains the OpenWeatherMap API key (You should add yours)
├── pubspec.yaml                # Project dependencies and metadata
└── README.md                   # This file
```


---

## ⚙️ Setup & Configuration

1.  **Clone the Repository:**
    
```
    git clone https://github.com/surajpsk12/WeatherAppFlutter.git
    cd WeatherAppFlutter
```


2.  **Get an OpenWeatherMap API Key:**
    *   Sign up at [OpenWeatherMap](https://openweathermap.org/appid).
    *   Create a file named `apikeysofwether.dart` inside the `lib` directory.
    *   Add your API key to this file like so:
        
```dart
        // lib/apikeysofwether.dart
        const String openWeatherapikey = 'YOUR_ACTUAL_API_KEY';
```


3.  **Ensure `apikeysofwether.dart` is in `.gitignore`:**
    *   To prevent your API key from being committed to version control, add the following line to your `.gitignore` file:
        
```
        /lib/apikeysofwether.dart
```


4.  **Install Dependencies:**
    
```
    flutter pub get
```


5.  **Run the App:**
    
```
    flutter run
```


---

## 📝 Notes

-   The city is currently hardcoded to "Durgapur" in `weather_screen.dart`.
-   API key management is crucial. Ensure `apikeysofwether.dart` is correctly configured and gitignored.

---

## ✨ Future Enhancements

-   Allow users to search for and select different cities.
-   Implement location services to get weather for the user's current location.
-   Add more detailed weather information (e.g., UV index, visibility).
-   Improve UI/UX with animations and more polished visuals.
-   Store API key more securely (e.g., using environment variables via `flutter_dotenv`).
-   Implement state management for better data flow (e.g., Provider, BLoC).

---

## 🤝 Contribution

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change or improve.

---

## 📜 License

MIT © 2024 [Suraj Kumar](https://github.com/surajpsk12)

---

## 🌐 Connect With Me

*   🔗 [LinkedIn - Suraj Kumar](https://www.linkedin.com/in/surajvansh12/)
*   💻 [GitHub - surajpsk12](https://github.com/surajpsk12)
