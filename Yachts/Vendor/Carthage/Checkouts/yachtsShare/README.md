YachtsShare
===

Evaluation demo for using Isomorphic swift model structs on the server and the client.

- Companion Swift Server [https://github.com/mschmulenyachtsServer](https://github.com/mschmulen/yachtsServer)
- Companion iOS App [https://github.com/mschmulen/yachtsApp](https://github.com/mschmulen/yachtsApp)
- Common shared Swift package for isomorphic models [https://github.com/mschmulen/yachtsShare](https://github.com/mschmulen/yachtsShare)

###Workflow

After modifying common shared code increment the repos version tag 

1. verify current version `git tag` 
1. incriment the version `git tag 0.0.5`
1. push the tag `git push origin --tags`
1. update the dependecies in [yachtServer Package.swift](https://github.com/mschmulen/yachtsServer/blob/master/Package.swift) repo [https://github.com/mschmulenyachtsServer](https://github.com/mschmulen/yachtsServer) for `.Package(url: "https://github.com/mschmulen/yachtsShare.git", Version(0, 0, 5))`
1. update the [Cartfile dependecies in the iOS App](https://github.com/mschmulen/yachtsApp/blob/master/Yachts/Vendor/Cartfile) in the [yachtsApp](https://github.com/mschmulen/yachtsApp) for yachtShare `github "mschmulen/yachtsShare" == 0.0.5`

### Build models

1. git clone git@github.com:mschmulen/yachtsShare.git
1. generate: `swiftyjsonaccelerator generate -p Definitions`
1. swift build


Update the  config file `Definitions\.config.json` to modify the model scheme
add `import SwiftyJSON` to new files

####SwiftyJSONAccelerator

Install

1. `git clone https://github.com/insanoid/SwiftyJSONAccelerator.git && cd SwiftyJSONAccelerator`
1. `make install`
1. `cd ..`
1. `rm -rf SwiftyJSONAccelerator`
