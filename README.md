# LocalizerTemplate
Template to generate VIPER classes on Xcode.

## Swift Version
Swift 5.0

## About Localizer
Localizer is responsible for application's localization as follows:
* **Localizer.swift**
  * Setup application's orientation based on applications'language. (Semantic).
  * Setup Swizzling.
  * Set application's language.
  * Check current language.
* **LocalizerJSON.swift**
  *  Get value for key in specific screen.
  *  Save JSON localization model to local JSON file(localization.json).
  *  Save JSON file(localization.json) to Userdefaults.

## Installation
- Download [Localizer Template](https://github.com/mohamedaeldin/LocalizerTemplate/archive/main.zip) or clone the project.
- Copy the `Localizer.xctemplate` folder.
- Go to Application folder, browse to the Xcode application icon. Right-click it and choose 'Show Package Contents'. 
- Browse to: Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project Templates/iOS/Application
- Paste the `Localizer.xctemplate` folder.

## Prerequisite
* Install [Storage template](https://github.com/mohamedaeldin/StorageTemplate). Then Choose `Userdefaults`
* **OR**
  * You can user by own implementation for Userdefaults by replacing the code inside the following two functions:
    *  `private static func saveLanguage(language: String) {}`
    *  `private static func getSavedLanguage() -> String {}`

## Using the template
- Start Xcode and Create a new file (`File > New > File` or `⌘N`).
- Choose `VIPER`.
- Type in the name of the module you want to create.
- Choose form the drop down list (`Localizer` or `LocalizerJSON`).
- *Not required*: To create Xcode groups, remove the references to the newly created files and add them back to the project

## Created Files
If you choosed from the drop down list:
* **Localizer**
  *  `Localizer.swift`

* **LocalizerJSON**
  *  `LocalizerJSON.swift`  (Prequisit add `Localizer`)

## Contact
[Mohamed Alaa El-Din](https://github.com/mohamedaeldin)
