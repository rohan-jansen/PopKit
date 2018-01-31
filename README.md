# PopKit

[![CI Status](http://img.shields.io/travis/rohan-jansen/PopKit.svg?style=flat)](https://travis-ci.org/rohan-jansen/PopKit)
[![Version](https://img.shields.io/cocoapods/v/PopKit.svg?style=flat)](http://cocoapods.org/pods/PopKit)
[![License](https://img.shields.io/cocoapods/l/PopKit.svg?style=flat)](http://cocoapods.org/pods/PopKit)
[![Platform](https://img.shields.io/cocoapods/p/PopKit.svg?style=flat)](http://cocoapods.org/pods/PopKit)

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/PopKit?style=flat-square)](https://cocoapods.org/pods/PopKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PopKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PopKit"
```

### Example side menu with a UIViewController as popup view



```swift

var sideMenu: PopKit {
return PopKitBuilder() {
$0.constraints = [.edges(left: 0, right: nil, top: 0, bottom: 0), .width(275)]
$0.inAnimation = .bounceFromLeft(damping: 0.82, velocity: 2, animationOption: .curveEaseInOut)
$0.outAnimation = .bounceFromRight(damping: 0.72, velocity: 2, animationOption: .curveEaseInOut)
$0.backgroundEffect = .blurDark
$0.popupViewController = SideMenuViewController.fromStoryboard()
}
}

sideMenu.show()

```

To dismiss the popup, simply call Popkit.dismiss() from anywhere

### Example top notification pop down view


```swift

var topNotification: PopKit {
return PopKitBuilder() {
$0.constraints = [.edges(left: 0, right: 0, top: 0, bottom:nil), .height(90)]
$0.inAnimation = .bounceFromTop(damping: 0.9, velocity: 2, animationOption: .curveEaseInOut)
$0.outAnimation = .bounceFromBottom(damping: 0.86, velocity: 2, animationOption: .curveEaseInOut)
$0.backgroundEffect = .blurDark
$0.transitionSpeed = 0.3
$0.popupView = NotificationView.loadView()
}
}

```

### Example menu moving up from bottom

```swift

var bottomMenu: PopKit {
return PopKitBuilder() {
$0.constraints = [.edges(left: 0, right: 0, top: nil, bottom:0), .height(400)]
$0.inAnimation = .bounceFromBottom(damping: 0.86, velocity: 2, animationOption: .curveEaseInOut)
$0.outAnimation = .bounceFromTop(damping: 0.72, velocity: 2, animationOption: .curveEaseInOut)
$0.backgroundEffect = .transparentOverlay(0.5)
$0.transitionSpeed = 0.3
$0.popupView = TestView(radius: 0)
}
}

```
### Example popup bouncing in from the top

```swift

var bounceFromTop: PopKit {
return PopKitBuilder() {
$0.constraints = [.center(x: 0, y: 0), .width(300), .height(350)]
$0.inAnimation = .bounceFromTop(damping: 0.72, velocity: 2, animationOption: .curveEaseInOut)
$0.outAnimation = .bounceFromBottom(damping: 0.86, velocity: 2, animationOption: .curveEaseInOut)
$0.backgroundEffect = .blurDark
$0.popupView = CenterModalView.loadView()
}
}

```

### Example popup sliding in from the bottom

```swift


var slideFromBottom: PopKit {
return PopKitBuilder() {
$0.constraints = [.center(x: 0, y: 0), .width(300), .height(300)]
$0.inAnimation = .slideFromBottom(animationOption: .curveEaseOut)
$0.outAnimation = .slideFromTop(animationOption: .curveEaseInOut)
$0.backgroundEffect = .blurDark
$0.transitionSpeed = 0.3
$0.popupView = TestView()
}
}

```

### Example popup zooming in

```swift

var zoomIn: PopKit {
return PopKitBuilder() {
$0.constraints = [.center(x: 0, y: 0), .width(300), .height(300)]
$0.inAnimation = .zoomOut(1.2, animationOption: .curveEaseInOut)
$0.outAnimation = .bounceFromBottom(damping: 0.86, velocity: 2, animationOption: .curveEaseInOut)
$0.backgroundEffect = .blurDark
$0.transitionSpeed = 0.46
$0.popupView = TestView()
}
}
```

# Contributing

There's still a lot of work to do here! We would love to see you involved!

# Get in touch

If you have any questions, you can find the core team on twitter:

- [@rohan_jansen](https://twitter.com/rohan_jansen)
- [Andreas ] (andreas409@gmail.com)

## Author

rohan-jansen, rohanjansen@gmail.com

## License

PopKit is available under the MIT license. See the LICENSE file for more info.
