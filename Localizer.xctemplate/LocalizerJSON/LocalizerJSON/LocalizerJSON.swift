import UIKit

extension Localizer {
    fileprivate static let localizationObjectKey = "localizationObject"
    fileprivate static let jsonFileName = "localization"
    fileprivate static let jsonType = "json"

    // MARK: - Get value for key in specific screen

    static func getValue(forKey key: String, screenName: String) -> String {
        guard let model: LocalizationModel = StorageUserDefaultsManager.shared.get(objectForKey: localizationObjectKey, type: LocalizationModel.self), let item = model.results.first(where: { $0.screen == screenName })?.items.first(where: { $0.key == key }) else {
            return ""
        }

        return Localizer.isCurrentApp(language: .arabic) ? item.ar : item.en
    }

    // MARK: - Save JSON localization model to local JSON file(localization.json) & Userdefaults.

    // You should get JSON response from endpoint API and parse to LocalizationModel
    // Then pass it to this method to save it to local JSON file & Userdefaults.

    static func saveJsonLocalizationModelToJsonFile(model: LocalizationModel) {
        // Save to JSON file
        guard let path = Bundle.main.path(forResource: jsonFileName, ofType: jsonType) else {
            return
        }

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: model.toJSON(), options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
            try jsonString?.write(to: URL(fileURLWithPath: path), atomically: true, encoding: String.Encoding.utf8)
        } catch {}

        // Save to Userdefaults
        saveJsonLocalizationsModelToUserdefaults(model: model)
    }

    // MARK: - Save JSON localization File to Userdefaults.

    // If endpoint API failed to provide the JSON response then you need to add at least one time
    // your app json localization in JSON file "localization.json".
    // Then use this function to save this bundled file "localization.json" to Userdefaults

    static func saveLocalJsonLocalizationsFileToUserdefaults() {
        let model = getLocalJsonFileInModelType()
        saveJsonLocalizationsModelToUserdefaults(model: model)
    }

    // MARK: - Private functions

    private static func getLocalJsonFileInModelType() -> LocalizationModel {
        guard let path = Bundle.main.path(forResource: jsonFileName, ofType: jsonType), let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)), let model = try? JSONDecoder().decode(LocalizationModel.self, from: jsonData) else {
            let mockupModel = LocalizationModel(results: [LocalizationResult(screen: "", items: [Item(key: "", ar: "", en: "")])])
            return mockupModel
        }
        return model
    }

    private static func saveJsonLocalizationsModelToUserdefaults(model: LocalizationModel) {
        StorageUserDefaultsManager.shared.save(object: model, forKey: localizationObjectKey, completion: nil)
    }
}

extension Encodable {
    /// Converting object to postable JSON
    func toJSON(_ encoder: JSONEncoder = JSONEncoder()) -> [String: Any] {
        guard let data = try? encoder.encode(self),
              let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
              let json = object as? [String: Any] else { return [:] }
        return json
    }
}
