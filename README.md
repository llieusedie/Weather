# Weather
Stylish weather app made with SwiftUI. The data is provided by [OpenWeatherAPI] (https://openweathermap.org/api). In the build, I've used:
1. Networking with JSON and API;
2. Lottie Animations;
3. MVVM pattern;
4. CoreLocation;

# GIF example
![](https://github.com/llieusedie/Weather/blob/main/WeatherApp.gif)

# Important tips
## UI 
1. I used an **animated gradient as a background** using `.hueRotation()` ;
2. Added a **custom SearchBar** with controls and smooth animation to improve UX;
3. Added a **custom font** to match the design pattern;
4. **I combined Lottie animations and SF symbols.** Lottie is displayed on the Featured Weather while SF Symbols are used in "daily" and "weekly" sections.

## Structure
1. In the project, I took advantage of dividing the whole view into **subviews**. Say each element: Header, Featured Weather, 3 Widgets, Hourly and Daily forecasts. 
2. Instances of hourly and daily forecasts are **created dynamically** using **view-building methods** that return `some View`.  
3. To display Lottie animation according to the fetched weather, I made a `func` with a `switch` statement that reads the weather condition code and returns a name of the Lottie Animation. Same has been done with SF Symbols.
