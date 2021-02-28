import UIKit

class Localizer: NSObject {
    fileprivate static let languageKey = "language"

    enum AppLanguage: String {
        case none = ""
        case arabic = "ar"
        case engligh = "en"
    }

    // MARK: - public functions

    // MARK: These two methods should be called in AppDelegate

    static func setDefaultLanguage() {
        let savedLanguage = getSavedLanguage()
        if !savedLanguage.isEmpty {
            if savedLanguage == AppLanguage.arabic.rawValue {
                setAppLanguage(language: .arabic)
            } else {
                setAppLanguage(language: .engligh)
            }
        } else {
            setAppLanguage(language: .none)
        }
    }

    static func setupSwizzling() {
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector:
            #selector(Bundle.specialLocalizedString(key:value:table:)))
    }

    // MARK: Change app language

    static func setAppLanguage(language: AppLanguage) {
        var currentLanguage = language.rawValue
        if currentLanguage == .none {
            currentLanguage = Locale.current.languageCode ?? "en"
        }

        saveLanguage(language: currentLanguage)

        UIView.appearance().semanticContentAttribute = language == .arabic ? UISemanticContentAttribute.forceRightToLeft : UISemanticContentAttribute.forceLeftToRight
        reloadApp()
    }

    // MARK: Check current language

    static func isCurrentApp(language: AppLanguage) -> Bool {
        getSavedLanguage() == language.rawValue
    }

    // MARK: This function fires when language is changed

    static func reloadApp() {
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = SplashSceneRouter.createAnModule()
    }

    // MARK: - private functions

    private static func saveLanguage(language: String) {
        StorageUserDefaultsManager.shared.save(value: language, forKey: languageKey, completion: nil)
    }

    private static func getSavedLanguage() -> String {
        (StorageUserDefaultsManager.shared.get(valueForKey: languageKey) as? String) ?? ""
    }
}

extension Bundle {
    @objc func specialLocalizedString(key: String, value: String?, table tableName: String?) -> String? {
        if let currentLanguage = UserDefaults.standard.value(forKey: Localizer.languageKey) as? String {
            var bundle: Bundle!
            if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                bundle = Bundle(path: _path)
            } else {
                if let _path = Bundle.main.path(forResource: "Base", ofType: "lproj") {
                    bundle = Bundle(path: _path)
                }
            }
            return (bundle.specialLocalizedString(key: key, value: value, table: tableName))
        }
        return ""
    }
}

func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    guard let origMethod: Method = class_getInstanceMethod(cls, originalSelector), let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector) else {
        return
    }
    if class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod)) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod))
    } else {
        method_exchangeImplementations(origMethod, overrideMethod)
    }
}
