//
//  SwifterSwift.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(watchOS)
import WatchKit
#endif

// MARK: - Properties
/// SwifterSwift: Common usefull properties and methods.
public struct SwifterSwift {

	#if !os(macOS)
	/// SwifterSwift: App's name (if applicable).
	public static var appDisplayName: String? {
		// http://stackoverflow.com/questions/28254377/get-app-name-in-swift
		return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
	}
	#endif

	#if !os(macOS)
	/// SwifterSwift: App's bundle ID (if applicable).
	public static var appBundleID: String? {
		return Bundle.main.bundleIdentifier
	}
	#endif

	#if os(iOS)
	/// SwifterSwift: StatusBar height
	public static var statusBarHeight: CGFloat {
		return UIApplication.shared.statusBarFrame.height
	}
	#endif

	#if !os(macOS)
	/// SwifterSwift: App current build number (if applicable).
	public static var appBuild: String? {
		return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
	}
	#endif

	#if os(iOS) || os(tvOS)
	/// SwifterSwift: Application icon badge current number.
	public static var applicationIconBadgeNumber: Int {
		get {
			return UIApplication.shared.applicationIconBadgeNumber
		}
		set {
			UIApplication.shared.applicationIconBadgeNumber = newValue
		}
	}
	#endif

	#if !os(macOS)
	/// SwifterSwift: App's current version (if applicable).
	public static var appVersion: String? {
		return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
	}
	#endif

	#if os(iOS)
	/// SwifterSwift: Current battery level.
	public static var batteryLevel: Float {
		return UIDevice.current.batteryLevel
	}
	#endif

	#if os(iOS) || os(tvOS)
	/// SwifterSwift: Shared instance of current device.
	public static var currentDevice: UIDevice {
		return UIDevice.current
	}
	#elseif os(watchOS)
	/// SwifterSwift: Shared instance of current device.
	public static var currentDevice: WKInterfaceDevice {
		return WKInterfaceDevice.current()
	}
	#endif

	#if !os(macOS)
	/// SwifterSwift: Screen height.
	public static var screenHeight: CGFloat {
		#if os(iOS) || os(tvOS)
			return UIScreen.main.bounds.height
		#elseif os(watchOS)
			return currentDevice.screenBounds.height
		#endif
	}
	#endif

	#if !os(macOS)
	/// SwifterSwift: Current device model.
	public static var deviceModel: String {
		return currentDevice.model
	}
	#endif

	#if !os(macOS)
	/// SwifterSwift: Current device name.
	public static var deviceName: String {
		return currentDevice.name
	}
	#endif

	#if os(iOS)
	/// SwifterSwift: Current orientation of device.
	public static var deviceOrientation: UIDeviceOrientation {
		return currentDevice.orientation
	}
	#endif

	#if !os(macOS)
	/// SwifterSwift: Screen width.
	public static var screenWidth: CGFloat {
		#if os(iOS) || os(tvOS)
			return UIScreen.main.bounds.width
		#elseif os(watchOS)
			return currentDevice.screenBounds.width
		#endif
	}
	#endif

	/// SwifterSwift: Check if app is running in debug mode.
	public static var isInDebuggingMode: Bool {
		// http://stackoverflow.com/questions/9063100/xcode-ios-how-to-determine-whether-code-is-running-in-debug-release-build
		#if DEBUG
			return true
		#else
			return false
		#endif
	}

	#if !os(macOS)
	/// SwifterSwift: Check if app is running in TestFlight mode.
	public static var isInTestFlight: Bool {
		// http://stackoverflow.com/questions/12431994/detect-testflight
		return Bundle.main.appStoreReceiptURL?.path.contains("sandboxReceipt") == true
	}
	#endif

	#if os(iOS)
	/// SwifterSwift: Check if multitasking is supported in current device.
	public static var isMultitaskingSupported: Bool {
		return UIDevice.current.isMultitaskingSupported
	}
	#endif

	#if os(iOS)
	/// SwifterSwift: Current status bar network activity indicator state.
	public static var isNetworkActivityIndicatorVisible: Bool {
		get {
			return UIApplication.shared.isNetworkActivityIndicatorVisible
		}
		set {
			UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
		}
	}
	#endif

	#if os(iOS)
	/// SwifterSwift: Check if device is iPad.
	public static var isPad: Bool {
		return UIDevice.current.userInterfaceIdiom == .pad
	}
	#endif

	#if os(iOS)
	/// SwifterSwift: Check if device is iPhone.
	public static var isPhone: Bool {
		return UIDevice.current.userInterfaceIdiom == .phone
	}
	#endif

	#if os(iOS) || os(tvOS)
	/// SwifterSwift: Check if device is registered for remote notifications for current app (read-only).
	public static var isRegisteredForRemoteNotifications: Bool {
		return UIApplication.shared.isRegisteredForRemoteNotifications
	}
	#endif

	/// SwifterSwift: Check if application is running on simulator (read-only).
	public static var isRunningOnSimulator: Bool {
		// http://stackoverflow.com/questions/24869481/detect-if-app-is-being-built-for-device-or-simulator-in-swift
		#if (arch(i386) || arch(x86_64)) && (os(iOS) || os(watchOS) || os(tvOS))
			return true
		#else
			return false
		#endif
	}

	#if os(iOS)
	/// SwifterSwift: Status bar visibility state.
	public static var isStatusBarHidden: Bool {
		get {
			return UIApplication.shared.isStatusBarHidden
		}
		set {
			UIApplication.shared.isStatusBarHidden = newValue
		}
	}
	#endif

	#if os(iOS) || os(tvOS)
	/// SwifterSwift: Key window (read only, if applicable).
	public static var keyWindow: UIView? {
		return UIApplication.shared.keyWindow
	}
	#endif

	#if os(iOS) || os(tvOS)
	/// SwifterSwift: Most top view controller (if applicable).

    static func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }

	#endif

	#if os(iOS) || os(tvOS)
	/// SwifterSwift: Shared instance UIApplication.
	public static var sharedApplication: UIApplication {
		return UIApplication.shared
	}
	#endif

	#if os(iOS)
	/// SwifterSwift: Current status bar style (if applicable).
	public static var statusBarStyle: UIStatusBarStyle? {
		get {
			return UIApplication.shared.statusBarStyle
		}
		set {
			if let style = newValue {
				UIApplication.shared.statusBarStyle = style
			}
		}
	}
	#endif

	#if !os(macOS)
	/// SwifterSwift: System current version (read-only).
	public static var systemVersion: String {
		return currentDevice.systemVersion
	}
	#endif

	#if !os(macOS)
	/// SwifterSwift: Shared instance of standard UserDefaults (read-only).
	public static var userDefaults: UserDefaults {
		return UserDefaults.standard
	}
	#endif

}
