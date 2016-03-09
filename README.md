# GPS_EXIF_LOCATION
Show the way to get GPS loation from Image File.
- From PHAsset (UIImagePicker)
 if let asset = PHAsset.fetchAssetsWithALAssetURLs([url], options: nil).lastObject as? PHAsset{
            txtInfo.text = "\(asset.location)"
        }
- From File (Bundle or Document jpg file)
