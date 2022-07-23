//
//  WriteDiaryViewController.swift
//  Diary
//
//  Created by 이선재 on 2022/07/20.
//

import UIKit

enum DiaryEditorMode {
    case new
    case edit(IndexPath, Diary)
}

protocol WriteDiaryViewDelegate: AnyObject {
    func didSelectRegister(diary: Diary)
}

class WriteDiaryViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    weak var delegate: WriteDiaryViewDelegate?
    var diaryEditorMode: DiaryEditorMode = .new
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureInputField()
        self.configureEditMode()
        self.confirmButton.isEnabled = false

    }
    
    private func configureEditMode() {
        switch self.diaryEditorMode {
        case let .edit(_, diary):
            self.titleTextField.text = diary.title
            self.confirmButton.title = "수정"
            
        default:
            break
        }
    }
    
    private func configureInputField(){
//        self.contentsTextView.delegate = self
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text else { return }
//        let diary = Diary(title: title, isStar: false)
        
        switch self.diaryEditorMode {
        case .new:
            let diary = Diary(
                uuidString: UUID().uuidString,
                title: title,
                isStar: false
            )
            self.delegate?.didSelectRegister(diary: diary)
            
        case let .edit(indxPath, diary):
            let diary = Diary(
                uuidString: diary.uuidString,
                title: title,
                isStar: diary.isStar
            )
            NotificationCenter.default.post(
                name: NSNotification.Name("editDiary"),
                object: diary,
                userInfo: nil
            )
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField){
        self.validateInputField()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func validateInputField(){
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true)
    }
}

extension WriteDiaryViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView){
        self.validateInputField()
    }
}
