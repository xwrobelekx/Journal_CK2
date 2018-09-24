//
//  Entry Controller.swift
//  JournalCK2
//
//  Created by Kamil Wrobel on 9/24/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation
import CloudKit


class EntryController {
    
    
    //MARK: - Shared Instance
    static let shared = EntryController()
    private init() {}
    
    
    //MARK: - Source Of Truth
    var entries : [Entry] = []
    
    
    //MARK: - iCloud Save Method
    func saveToiCloud(entry: Entry){
        
        let record = entry.cloudKitRecord
        
        CKContainer.default().publicCloudDatabase.save(record) { (record, error) in
            if let error = error {
                    print("There was an error on \(#function): \(error) \(error.localizedDescription)")
                    return
            }
            if let record = record {
                guard let entry = Entry.init(cloudKitRecord: record) else {return}
                self.entries.append(entry)
            }
        }
    }
    
    
    //MARK: - Fetch From iCloud Method
    func fetchRecordsFromiCloud() {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Entry.TypeKey, predicate: predicate)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (record, error) in
            if let error = error {
                print("There was an error on \(#function): \(error) \(error.localizedDescription)")
                return
            }
            
            //i think i need to unpack the record here
            guard let record = record else {return}
            let entries = record.compactMap{ Entry.init(cloudKitRecord: $0)}
            self.entries = entries
        }
    }
}
