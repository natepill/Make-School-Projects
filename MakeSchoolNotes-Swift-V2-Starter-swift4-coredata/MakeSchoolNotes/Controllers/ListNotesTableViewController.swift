//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notes = CoreDataHelper.retrieveNotes() //retrieve and display all of the user's existing notes
        
    }
    
   var notes = [Note]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let noteToDelete = notes[indexPath.row]
            CoreDataHelper.delete(note: noteToDelete)
            
            notes.remove(at: indexPath.row)
        }
//        table view's built-in slide-to-delete functionality. Within the tableView(_:commit:forRowAt:) method, we check for the delete editing mode and delete the note at the corresponding index path.
// we retrieve the note to be deleted corresponding to the selected index path. Then we use our Core Data helper to delete the selected note. Last we update our notes array to reflect the changes in our NSManagedObjectContext.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
        
        // 2
        let note = notes[indexPath.row]
        cell.noteTitleLabel.text = note.title
        // 3
        cell.noteModificationTimeLabel.text = note.modificationTime?.convertToString() ?? "unknown"
        
        return cell
    }
    
//   Dynamically return the number of notes in the notes array.
//    Retrieve the correct note based on the index path row and set the note cell's labels with the corresponding data.
//    We use the method convertToString() that was included in our project to convert our modification time from type Date to String.
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "displayNote":
            // 1
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            // 2
            let note = notes[indexPath.row]
            // 3
            let destination = segue.destination as! DisplayNoteViewController
            // 4
            destination.note = note
            
        case "addNote":
            print("create note bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
    
//    Get a reference to the index path of the selected row in the table view using the UITableView property named indexPathForSelectedRow. We'll use this next to retrieve the correct note in our notes array.
//    Retrieve the selected note using the index path from the previous step.
//    Get a reference and type cast our segue's destination view controller. This will allow us to set the note property of the DisplayNoteViewController in the next step.
//    Using the reference to destination view controller, set the note property to the selected note.
    
    
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
        notes = CoreDataHelper.retrieveNotes() //update our unwind segue to retrieve our updated notes.
        
        //Now, each time the user taps the save or cancel bar button item in DisplayNoteViewController, we update our notes array in ListNotesTableViewController. Our didSet property observer will take care of reloading our table view. In combination, we can be sure our table view data is always synced with our NSManagedObjectContext.
        
    }
    

    
    
    
}
