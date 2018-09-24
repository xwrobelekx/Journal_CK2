//
//  EntryDetailViewController.swift
//  JournalCK2
//
//  Created by Kamil Wrobel on 9/24/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var entryNotesTextField: UITextField!
    
    
    //MARK: - LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = entryTitleTextField.text,
            title != "" else {return}
        let entry = Entry(title: title, notes: entryNotesTextField.text)
        
        EntryController.shared.saveToiCloud(entry: entry)
        navigationController?.popViewController(animated: true)
    }
}
