import UIKit
import Hue
import AVKit
import AVFoundation
import Imaginary

@objc public class LightboxConfig {
  /// Whether to show status bar while Lightbox is presented
  @objc public static var hideStatusBar = true

  /// Provide a closure to handle selected video
  @objc public static var handleVideo: (_ from: UIViewController, _ videoURL: URL) -> Void = { from, videoURL in
    let videoController = AVPlayerViewController()
    videoController.player = AVPlayer(url: videoURL)

    from.present(videoController, animated: true) {
      videoController.player?.play()
    }
  }

  /// How to load image onto UIImageView
  @objc public static var loadImage: (UIImageView, URL, ((UIImage?) -> Void)?) -> Void = { (imageView, imageURL, completion) in

    // Use Imaginary by default
    imageView.setImage(url: imageURL, placeholder: nil, completion: { result in
      switch result {
      case .value(let image):
        completion?(image)
      case .error:
        completion?(nil)
      }
    })
  }

  /// Indicator is used to show while image is being fetched
  @objc public static var makeLoadingIndicator: () -> UIView = {
    return LoadingIndicator()
  }
  
  /// Number of images to preload.
  ///
  /// 0 - Preload all images (default).
  @objc public static var preload = 0

  @objc public struct PageIndicator {
    @objc public static var enabled = true
    @objc public static var separatorColor = UIColor(hex: "3D4757")

    @objc public static var textAttributes: [NSAttributedStringKey: Any] = [
      .font: UIFont.systemFont(ofSize: 12),
      .foregroundColor: UIColor(hex: "899AB8"),
      .paragraphStyle: {
        var style = NSMutableParagraphStyle()
        style.alignment = .center
        return style
      }()
    ]
  }

  @objc public struct CloseButton {
    @objc public static var enabled = true
    @objc public static var size: CGSize?
    @objc public static var text = NSLocalizedString("Close", comment: "")
    @objc public static var image: UIImage?

    @objc public static var textAttributes: [NSAttributedStringKey: Any] = [
      .font: UIFont.boldSystemFont(ofSize: 16),
      .foregroundColor: UIColor.white,
      .paragraphStyle: {
        var style = NSMutableParagraphStyle()
        style.alignment = .center
        return style
      }()
    ]
  }

  @objc public struct DeleteButton {
    @objc public static var enabled = false
    @objc public static var size: CGSize?
    @objc public static var text = NSLocalizedString("Delete", comment: "")
    @objc public static var image: UIImage?

    @objc public static var textAttributes: [NSAttributedStringKey: Any] = [
      .font: UIFont.boldSystemFont(ofSize: 16),
      .foregroundColor: UIColor(hex: "FA2F5B"),
      .paragraphStyle: {
        var style = NSMutableParagraphStyle()
        style.alignment = .center
        return style
      }()
    ]
  }

  @objc public struct InfoLabel {
    @objc public static var enabled = true
    @objc public static var textColor = UIColor.white
    @objc public static var ellipsisText = NSLocalizedString("Show more", comment: "")
    @objc public static var ellipsisColor = UIColor(hex: "899AB9")

    @objc public static var textAttributes: [NSAttributedStringKey: Any] = [
      .font: UIFont.systemFont(ofSize: 12),
      .foregroundColor: UIColor(hex: "DBDBDB")
    ]
  }

  @objc public struct Zoom {
    @objc public static var minimumScale: CGFloat = 1.0
    @objc public static var maximumScale: CGFloat = 3.0
  }
}
