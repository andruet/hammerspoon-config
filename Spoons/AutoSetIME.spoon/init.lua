--- === AutoSetIME ===
---
--- set input method editor, automatically.
---
--- Download: []

local obj={}
obj.__index = obj

-- Metadata
obj.name = "AutoSetIME"
obj.version = "0.1"
obj.author = "andruet <wht_andrew@163.com>"
obj.homepage = "TODO"
obj.license = "TODO"

--- you can set your SourceID
obj.ChineseSourceID = "com.sogou.inputmethod.sogou.pinyin"
obj.EnglishSourceID = "com.apple.keylayout.ABC"

-- --- you can set Apps IME enable automatically,
-- --- when app in Apps is activated.

obj.ChineseApps = {
    "微信", "WeChat",
    "QQ音乐",
    "QQ"
}

obj.EnglishApps = {
    "Code",
    "iTerm2",
    "Transmit",
    "Alfred 3",
    "聚焦", "Spotlight",
    "终端", "Terminal",
    "访达", "Finder",
    "Hammerspoon"
}

obj.sourceIDs = {
    [obj.ChineseSourceID]=obj.ChineseApps,
    [obj.EnglishSourceID]=obj.EnglishApps
}


function obj.applicationWatcher(currentAppName, eventType, appObject)
    if (eventType == hs.application.watcher.activated and currentAppName) then
        local done = false
        for sourceID, appNames in pairs(obj.sourceIDs) do
            for i, appName in pairs(appNames) do
                if appName == currentAppName then
                    hs.keycodes.currentSourceID(sourceID)
                    done = true
                    break
                end
            end
            if done then
                 break
            end
        end
    end
end

function obj:init()
    appWatcher = hs.application.watcher.new(obj.applicationWatcher)
    appWatcher:start()
end

return obj