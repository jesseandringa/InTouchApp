//
//  EditProfileViewController.swift
//  InTouch
//
//  Created by jesse andringa on 3/14/23.
//

import UIKit

struct EditProfileFormModel{
    let label: String
    let placeHolder: String
    var value: String?
     
}
final class EditProfileViewController: UIViewController, UITableViewDataSource {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [[EditProfileFormModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeaderView()
        view.addSubview(tableView)
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapCancel))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels(){
        //name, username, website, bio
        let section1Labels = ["Name", "Username","Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels{
            let model = EditProfileFormModel(label: label,
                                             placeHolder: "Enter \(label)...",
                                             value: nil)
            section1.append(model)
        }
        models.append(section1)
        
        
        let section2Labels = ["Email", "Phone","Gender"]
        var section2 = [EditProfileFormModel]()
        for label in section2Labels{
            let model = EditProfileFormModel(label: label,
                                             placeHolder: "Enter \(label)...",
                                             value: nil)
            section2.append(model)
        }
        models.append(section2)
        //email, phone, gender
    }
    
    //Mark- TableView
    private func createTableHeaderView() ->UIView{
        let header = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.width,
                                          height: view.height/4).integral)
        let size = header.height/1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (header.width - size)/2,
                                                        y: (header.height - size)/2,
                                                        width: size,
                                                        height: size))
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2.0
        profilePhotoButton.tintColor = .label
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.fill"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        
        return header
    }
    
    
    
    @objc private func didTapProfilePhotoButton(){
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier,
                                                 for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else  {
            return nil
        }
        return "Private Information"
    }
    //MARK- Action
    
     @objc private func didTapSave(){
        //save info to database
         dismiss(animated: true, completion: nil)
    }
     @objc private func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }
    
     @objc private func didTapChangeProfilePic(){
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "Change profile picture",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        //make sure it won't crash on ipad
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        actionSheet.popoverPresentationController?.sourceView = view
        //present it
        present(actionSheet, animated: true)
    }

}

extension EditProfileViewController: FormTableViewCellDelegate{
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
        //print("Field updated to: \(value ?? "nil" ) ")
        //update model
        print(updatedModel.value ?? "nil" )
    } 
    
    
}
