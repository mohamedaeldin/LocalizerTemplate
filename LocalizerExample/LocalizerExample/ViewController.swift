//
//  ViewController.swift
//  LocalizerExample
//
//  Created by Mohamed Alaa El-Din on 28/02/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var localizeText: UILabel!
    @IBOutlet weak var changeLanguageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localizeText.text = Localizer.isCurrentApp(language: .engligh) ? "Change Language" : "كتابة عربي"
        Localizer.isCurrentApp(language: .engligh) ? changeLanguageButton.setTitle("Change Language", for: .normal) : changeLanguageButton.setTitle("تغيير اللغة", for: .normal)
    }

    @IBAction func changeLanguagePressed(_ sender: Any) {
        Localizer.isCurrentApp(language: .engligh) ? Localizer.setAppLanguage(language: .arabic) :Localizer.setAppLanguage(language: .engligh)
    }
    
}

