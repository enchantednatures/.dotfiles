wifiName = ""
lastSSID = hs.wifi.currentNetwork()
wifiWatcher = nil

function ssidChanged()
    newSSID = hs.wifi.currentNetwork()

    if newSSID == wifiName and lastSSID ~= wifiName then
        hs.notify.new({
            title = "WiFi",
            informativeText = "Network connected",
            autoWithdraw = true,
            withdrawAfter = 2
        })
    end


    lastSSID = newSSID
end

wifiWatcher = hs.wifi.watcher.new(ssidChanged)
wifiWatcher:start()
