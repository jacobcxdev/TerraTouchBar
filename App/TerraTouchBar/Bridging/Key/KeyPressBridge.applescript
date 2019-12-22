#
#  KeyPressBridge.applescript
#  TerraTouchBar
#
#  Created by Jacob Clayden on 15/12/2019.
#  Copyright © 2019 JacobCXDev. All rights reserved.
#

script KeyPressBridge
    property parent: class "NSObject"
    to send:keyCode
        tell application "System Events" to key code keyCode as integer
    end send
end script
