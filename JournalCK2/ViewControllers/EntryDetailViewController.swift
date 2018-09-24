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
    
    //MARK: - Properties
    var entry: Entry?{
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    
    //MARK: - LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = entryTitleTextField.text,
            title != "" else {return}
        
        if self.entry != nil {
            //update existing entry
        } else {
        let entry = Entry(title: title, notes: entryNotesTextField.text)
        EntryController.shared.saveToiCloud(entry: entry)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK: - Helper Methods
    func updateViews(){
        guard let entry = entry else {return}
        
        entryTitleTextField.text = entry.title
        entryNotesTextField.text = entry.notes
        dateLabel.text = entry.date.dateAsString()
    }
}
