//
//  Entry.swift
//  JournalCK2
//
//  Created by Kamil Wrobel on 9/24/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation
import CloudKit
class Entry {
    
    //MARK: - CloudKit Keys
    //#2 create keys
    static let TypeKey = "Entry"
    static let titleKey = "Title"
    static let notesKey = "Notes"
    static let dateKey = "Date"
    
    
    //MARK: - Properties
    let title: String
    let notes: String
    let date: Date
    
    
    //MARK: - Designated Initializer
    init(title: String, notes: String, date: Date = Date()){
        self.title = title
        self.notes = notes
        self.date = date
    }
    
    
    //MARK: - Cloud Kit Record
    //#1 create CKRecord computed property
    var cloudKitRecord : CKRecord = {
        //create record
        let record = CKRecord(recordType: Entry.TypeKey)
        //#3 convert properties to record
        record.setValue("title", forKey: Entry.titleKey)
        record.setValue("notes", forKey: Entry.notesKey)
        record.setValue("date", forKey: Entry.dateKey)
        
        return record
    }()
    
    
    //MARK: - Failable Initializer
    //#4 failble init
    convenience init?(cloudKitRecord: CKRecord) {
        //#5 unpack record, making usre all properties are correct type
        guard let title = cloudKitRecord[Entry.titleKey] as? String,
            let notes = cloudKitRecord[Entry.notesKey] as? String,
            let date = cloudKitRecord[Entry.dateKey] as? Date else {return nil}
        
        self.init(title: title, notes: notes, date: date)
    }
}
