//
//  CoreDataHelper.swift
//  MakeSchoolNotes
//
//  Created by Nathan Pillai on 7/6/18.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation
import UIKit
import CoreData


struct CoreDataHelper {
    
    
    static func newNote()  -> Note{
        
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        return note
    }
    
    static func saveNote(){
        
        do{
            try context.save()
        }
        catch let error{
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(note: Note){
        
        context.delete(note)
        saveNote()
    }
    
    static func retrieveNotes() -> [Note] {
    
        do{
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            let results = try context.fetch(fetchRequest)
        return results
        } catch let error{
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
    
    
    static let context: NSManagedObjectContext = {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        return context
    }()
}
//class variable that gets a reference to our app delegate's managed object context. We can use our reference to our NSManagedObjectContext to create, edit and delete NSManagedObject objects.
