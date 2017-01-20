import PackageDescription

let package = Package(
  name: "yachtsShare",
  dependencies: [
    .Package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", majorVersion: 15)
  ],
  exclude: ["Tools","Definitions"]
)
