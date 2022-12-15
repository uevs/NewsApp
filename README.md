# NewsApp

<div align="center">

<img width="128" alt="mac256" src="https://user-images.githubusercontent.com/36189306/203593440-c5884c30-043b-43e6-ab5c-4961733e45f6.png">
  
![GitHub](https://img.shields.io/github/license/uevs/NewsApp) [![Requires SwiftUI](https://img.shields.io/badge/requires-SwiftUI-orange?style=flat&logo=Swift)](https://developer.apple.com/documentation/swiftui) [![Requires Combine](https://img.shields.io/badge/requires-Combine-orange?style=flat&logo=Swift)](https://developer.apple.com/documentation/combine)  ![Requires iOS14](https://img.shields.io/badge/requires-iOS14-orange?style=flat&logo=Swift) ![Built with Swift 5](https://img.shields.io/badge/Built%20with-Swift%205-informational?style=flat&logo=Swift) ![Built with Xcode14](https://img.shields.io/badge/Built%20with-Xcode%2014-informational?style=flat&logo=Xcode) ![Tested on iPhone 14 Pro](https://img.shields.io/badge/Tested%20on-iPhone%2014%20Pro-informational?style=flat&logo=Apple)

</div>

A **SwiftUI** app that connects to a mock news API. The app uses Combine to handle networking and follows the MVVM pattern. 

Custom SwfitUI components implemented:
* **StickyHeaderScrollView**: a ScrollView wth a sticky header along with an optional sticky title section.
* **ExpandableNewsCardView**: an animated card that can expand to fullscreen, inspired by the cards on App Store.
* **AsyncImageView**: a View that asyncronously loads an image, since the project targets iOS14 and the native component is not available.


## Animations Demo
<div align="center">  


https://user-images.githubusercontent.com/36189306/207840835-e73022ce-497b-4b11-9027-baed417cda82.mov


</div>


## Screenshots

<div align="center">
<img width="250" alt="app_l" src="https://user-images.githubusercontent.com/36189306/207839948-c74ab105-6022-4a7e-8873-87dde60c2910.png">
<img width="250" alt="app_d" src="https://user-images.githubusercontent.com/36189306/207839969-d86e5995-7f44-453e-b533-307fa6a3a221.png">
</div>

## Available on TestFlight

The app is available for download on TestFlight at [this link](https://testflight.apple.com/join/oOv5AQ1M).
