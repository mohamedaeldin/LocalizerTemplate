import Foundation

// MARK: - LocalizationModel

struct LocalizationModel: BaseAPIRequestResponseProtocol {
    let results: [LocalizationResult]
}

// MARK: - Result

struct LocalizationResult: BaseAPIRequestResponseProtocol {
    let screen: String
    let items: [Item]
}

// MARK: - Item

struct Item: Codable {
    let key, ar, en: String
}
