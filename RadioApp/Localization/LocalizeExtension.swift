import Foundation
import Combine
import SwiftUI

extension Bundle {

    private static var bundle: Bundle!

    static var currentLanguage: String {
        get {
            return UserDefaults.standard.string(forKey: "app_lang") ?? "en"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "app_lang")
            setLanguage(lang: newValue)
        }
    }

    static var localizedBundle: Bundle {
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            return Bundle(path: path)!
        } else {
            return Bundle.main
        }
    }

    public static func setLanguage(lang: String) {
        UserDefaults.standard.set(lang, forKey: "app_lang")
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChangedNotification"), object: nil)
    }
}

class LanguageManager: ObservableObject {
    @Published var currentLanguage: String = Bundle.currentLanguage {
        didSet {
            Bundle.setLanguage(lang: currentLanguage)
        }
    }
}
