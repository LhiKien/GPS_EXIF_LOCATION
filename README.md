# GPS_EXIF_LOCATION
Show the way to get GPS loation from Image File.
- From PHAsset (UIImagePicker) Most simple way.
```swift
if let asset = PHAsset.fetchAssetsWithALAssetURLs([url], options: nil).lastObject as? PHAsset{
     txtInfo.text = "\(asset.location)"
}
```

- From File (Bundle or Document jpg file)
```swift
//unsafeAddressOf AND unsafeBitCast are the tricks!
        if let imageURL = NSBundle.mainBundle().URLForResource("20160228_130116", withExtension: "jpg"){
            let opts = [kCGImageSourceShouldCache as String: kCFBooleanFalse]
            if let imageSource = CGImageSourceCreateWithURL(imageURL, opts) {
                
                if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, opts) {
                    let gps = CFDictionaryGetValue(imageProperties, unsafeAddressOf(kCGImagePropertyGPSDictionary))
                    if gps != nil {
                        let gpsDict = unsafeBitCast(gps, CFDictionaryRef.self)
                        let gpsLat = CFDictionaryGetValue(gpsDict, unsafeAddressOf(kCGImagePropertyGPSLatitude))
                        let gpsLong = CFDictionaryGetValue(gpsDict, unsafeAddressOf(kCGImagePropertyGPSLongitude))
                        let gpsLatStr = unsafeBitCast(gpsLat, CFString.self)
                        let gpsLongStr = unsafeBitCast(gpsLong, CFString.self)
                        txtInfo.text = "Lat:\(gpsLatStr) / Lon:\(gpsLongStr)"
                    }
                }
            }
        }
```
