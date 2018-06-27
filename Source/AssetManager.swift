import UIKit

/// Used to load assets from Lightbox bundle
@objc class AssetManager {

  @objc static func image(_ named: String) -> UIImage? {
    let bundle = Bundle(for: AssetManager.self)
    return UIImage(named: "Lightbox.bundle/\(named)", in: bundle, compatibleWith: nil)
  }
}
