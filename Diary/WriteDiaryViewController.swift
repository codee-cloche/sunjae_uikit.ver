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
    func didSelectRegister(diary: Diary) // 일기가 작성된 diary 객체를 전달함
}

class WriteDiaryViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
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
            self.categoryTextField.text = diary.category
            self.confirmButton.title = "수정"
            
        default:
            break
        }
    }
    
    private func configureInputField(){
//        self.contentsTextView.delegate = self
        
        // Calls the corresponding DidChange method when the input text is edited
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        self.categoryTextField.addTarget(self, action: #selector(categoryTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
        // 등록 버튼을 누를때 diary 객체를 생성하고 delegate에 정의한 DidSelectRegistor method를 호출
        guard let title = self.titleTextField.text else { return }
        guard let category = self.categoryTextField.text else { return }
//        let diary = Diary(title: title, isStar: false)
        
        switch self.diaryEditorMode {
        case .new:
            let diary = Diary(
                uuidString: UUID().uuidString,
                title: title,
                category: category,
                isStar: false
            )
            self.delegate?.didSelectRegister(diary: diary)
            
        case let .edit(indxPath, diary):
            let diary = Diary(
                uuidString: diary.uuidString,
                title: title,
                category: category,
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
    
    
    // DidChange methods are called upon new input into textFields
    @objc private func titleTextFieldDidChange(_ textField: UITextField){
        self.validateInputField()
    }
    
    @objc private func categoryTextFieldDidChange(_ textField: UITextField){
        self.validateInputField()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Determines whether to enable the 등록 button
    private func validateInputField(){
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.categoryTextField.text?.isEmpty ?? true)
    }
}

extension WriteDiaryViewController: UITextViewDelegate{
    // Called upon every new textfield input
    func textViewDidChange(_ textView: UITextView){
        self.validateInputField()
    }
}
