**Weather Forecast App**

📱**Introduce**

A mobile application built to deliver precise and real-time weather updates with an intuitive dark-themed UI.

✨**Features**

  **Real-Time Weather Data:** Location-based temperature, humidity, wind speed, and condition indicators.
  
  **Hourly Forecast:** Dynamically displays upcoming hour-by-hour data.
  
  **7-Day Forecast:** Provides forward-looking predictions with daily highs/lows.
  
  **Previous 7-Day History:** Displays past weather records for comparison and trend analysis.
  
  **Search Function:** Allows city-based weather lookups.
  
  **Dark Mode Support:** Optimized for night-time readability.

 
📱 **Application interface**
<p align="center">
  <img src="https://github.com/user-attachments/assets/f8ed1269-c01d-40c8-a8e5-26a61c9b8889" alt="splash_screen" width="30%"/>
  <img src="https://github.com/user-attachments/assets/f8f3d7c2-cc19-4592-9ac5-bc31b639045c" alt="home_themedark" width="30%"/>
  <img src="https://github.com/user-attachments/assets/bc39b41c-6dc1-4115-9dec-63cdde6e8e04" alt="detail_themeDark" width="30%"/>
  <img src="https://github.com/user-attachments/assets/170fac3d-d846-4817-925a-6e72deaa5f6c" alt="home_themeLight" width="30%"/>
  <img src="https://github.com/user-attachments/assets/b56ca7b1-9375-4d47-9e86-e1b714ba2104" alt="detail_themeLight" width="30%"/>
</p>



🛠️ **Công nghệ sử dụng**
- **Framework**: Flutter
- **Ngôn ngữ**: Dart
- **State Management**: Riverpod
- **UI Components**: Material Design

📲 **Installation instructions**

 - Đảm bảo bạn đã cài đặt Flutter SDK
   - Clone repository:  
    git clone https://github.com/Tinhdang-AI/Weather-Forecast-App.git
   - Di chuyển vào thư mục dự án:  
    cd weather_app
   - Cài đặt các dependencies:  
    flutter pub get
   - Chạy ứng dụng:  
    flutter run


🧩 **Application Architecture**

```
lib/
├── Provider/                  # Quản lý trạng thái với Riverpod
│   └── theme_provider.dart    # State cho chế độ sáng/tối
│
├── Service/                   # Dịch vụ gọi API hoặc xử lý dữ liệu
│   └── api_service.dart
│
├── Theme/                     # Chủ đề giao diện (ThemeData)
│   └── theme.dart
│
├── Utils/                     # Tiện ích, màu sắc, hằng số
│   └── colors.dart
│
├── View/                      # Giao diện người dùng
│   ├── home_screen.dart
│   ├── splash_screen.dart
│   └── weekly_forecast.dart
│
└── main.dart                  # Điểm khởi đầu của ứng dụng

```
 
