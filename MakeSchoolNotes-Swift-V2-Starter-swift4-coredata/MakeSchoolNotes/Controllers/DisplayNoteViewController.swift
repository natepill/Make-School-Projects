//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {
    
     var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 1
        if let note = note {
            // 2
            titleTextField.text = note.title
            contentTextView.text = note.content
        } else {
            // 3
            titleTextField.text = ""
            contentTextView.text = ""
        }
    }
//    In our viewWillAppear() method, we check for an existing note in the note property to determine whether the user is displaying an existing note or creating a new one.
//
//    Check the note property for an existing note using if-let optional binding.
//    If the note property is non-nil, then our DisplayNoteViewController populates the text field and text view with the content of the existing note.
//    If the note property is nil, then our DisplayNoteViewController clear the storyboard's lorem ipsum filler text so the user can quickly begin taking notes.
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier
            else{return}

        
        switch identifier {
            
        case "save" where note != nil:
            note?.title = titleTextField.text ?? ""
            note?.content = contentTextView.text ?? ""
            note?.modificationTime = Date()
            
            CoreDataHelper.saveNote()
            
        case "save" where note == nil:
            let note = CoreDataHelper.newNote()
            note.title = titleTextField.text ?? ""
            note.content = contentTextView.text ?? ""
            note.modificationTime = Date()
            
            CoreDataHelper.saveNote()
            
        case "cancel":
            print("cancel bar tapped")
        default:
            print("unindentified segue")
        }
        
    }

}

