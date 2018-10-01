# CNCitySelector

[![CI Status](https://img.shields.io/travis/Enix Yu/CNCitySelector.svg?style=flat)](https://travis-ci.org/Enix Yu/CNCitySelector)
[![Version](https://img.shields.io/cocoapods/v/CNCitySelector.svg?style=flat)](https://cocoapods.org/pods/CNCitySelector)
[![License](https://img.shields.io/cocoapods/l/CNCitySelector.svg?style=flat)](https://cocoapods.org/pods/CNCitySelector)
[![Platform](https://img.shields.io/cocoapods/p/CNCitySelector.svg?style=flat)](https://cocoapods.org/pods/CNCitySelector)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS  9.0

## Installation

CNCitySelector is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CNCitySelector'
```

## Usage

1. 初始化CNCitySelectController

```objc
CNCitySelectController *vc = [CNCitySelectController alloc] initWithFrame:frame];
```

2. 设置城市数据database, 本repo自带GB2260的城市数据库，如果你需要使用自己的数据库，可以实现`CNCityDatabase`的数据接口

```objc
// GB2260实现了CNCityDatabase协议
vc.datasource = [GB2260 shardInstance];
// self遵循CNCitySelectDelegate协议
vc.delegate = self;
```

3. 选择城市后回调 `CNCitySelectDelegate`

```objc
- (void)didSelectRegion:(CNRegion *)region {
    NSLog(@"Select city: %@", region.name);
}
```

That's all

## Author

Enix Yu, enixyu@cloudesk.top

## License

CNCitySelector is available under the MIT license. See the LICENSE file for more info.
