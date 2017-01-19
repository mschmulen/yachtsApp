YachtsApp
===

Evaluation demo for using Isomorphic swift model structs on the server and the client.

- Companion Swift Server [https://github.com/mschmulen/yachtsServer](https://github.com/mschmulen/yachtsServer)
- Companion iOS App [https://github.com/mschmulen/yachtsApp](https://github.com/mschmulen/yachtsApp)
- Common shared Swift package for isomorphic models [https://github.com/mschmulen/yachtsShare](https://github.com/mschmulen/yachtsShare)


###Building and Running 

1. Clone this repo `git@github.com:mschmulen/yachtsApp.git`
1. Install carthage dependencies `cd Yachts/Vendor; carthage install`
1. Open and build the xCode project `open Yachts/Yachts.xcodeproj` , then build and run with `⌘ + r`

Currently the application is expecting the companion server to be running on localhost

###Workflow

When Share code is updated [git@github.com:mschmulen/yachtsShare.git](git@github.com:mschmulen/yachtsShare.git) bump the version `github "mschmulen/yachtsShare" == 0.0.5` in the Yachts/Vendor/Cartfile and update the dependencies `carthage update --no-build`.


