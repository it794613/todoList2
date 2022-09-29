//
//  ViewController.swift
//  todolist2
//
//  Created by 최진용 on 2022/09/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    var models = [TodoList]()
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        
        
        
        // cell xib파일 연결해줌
        let nib = UINib(nibName: "MyTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "reusableCell")
        
        //코어데이터에 있는 데이터 가져오고, 화면 업로드해줌
        getAllItem()
        
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
        if textField.text == "" {
            makeAlert()
        }else{
            createNewItem()
            textField.text = ""
            textField.endEditing(true)
        }
    }
    
//MARK: - make alert func
    func makeAlert(){
        let alert = UIAlertController(title: "경고", message: "텍스트를 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
        let defaultAlert = UIAlertAction(title: "ok", style: UIAlertAction.Style.default)
        alert.addAction(defaultAlert)
        self.present(alert, animated: false)
    }
    
    
    
//MARK: -CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func getAllItem(){
        do{
            models = try context.fetch(TodoList.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{
            print("error occured")
        }
    }
    
    func createNewItem(){
        let newItem = TodoList(context: context)
        newItem.todo = textField.text
        do{
            try context.save()
            getAllItem()
            print("add item")
        }catch{
            print("can not make new item")
        }
    }
    
    func deleteItem(item : TodoList){
        print("item \(item)")
        context.delete(item)
        do{
            try context.save()
            print("deleted")
            getAllItem()
        }catch{
            print("can not delete item")
        }
    }
}

    
    


//MARK: - UITextFieldDelegate
extension ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            makeAlert()
            return true
        }else{
            createNewItem()
            textField.text = ""
            textField.endEditing(true)
            return true
        }
    }
}

//MARK: - UITableViewCell
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! MyTableViewCell
        cell.cellLabel.text = models[indexPath.row].todo
        cell.deleteLine = { [weak self] in
            guard let self = self else { return }
            self.deleteItem(item: self.models[indexPath.row])
        }
        cell.selectionStyle = .none
        
        return cell
        
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
}

extension ViewController : UITableViewDelegate{
    
}


// 텍스트필드 작성 델리게이트 하기
// 센드버튼 action걸어주기 = 델리게이트랑 동일한 역할
// tableView = datasource, delegate
// tableView = datasource, cell;
// nib 파일 연결
