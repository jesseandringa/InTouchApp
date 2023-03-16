//
//  SettingsViewController.swift
//  InTouch
//
//  Created by jesse andringa on 3/12/23.
//

import UIKit
import SafariServices

struct settingCellModel{
    let title: String
    let handler: (() -> Void)
}

public enum SettingsURLType{
    case terms, privacy, help
}

final class SettingsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView( frame: .zero,
                                   style: .grouped )
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[settingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSettingModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
   
    private func configureSettingModels(){
        data.append([
            settingCellModel(title: "Edit Profile"){ [weak self] in
                self?.didTapEditProfile()
            },
            settingCellModel(title: "Invite Friends"){ [weak self] in
                self?.didTapInviteFriends()
            },
            settingCellModel(title: "Save Original Posts"){ [weak self] in
                self?.didTapSaveOriginalPosts()
            }])
        data.append([
            settingCellModel(title: "Terms of Service"){ [weak self] in
                self?.openURL(type: .terms)
            },
            settingCellModel(title: "Privacy Policy"){ [weak self] in
                self?.openURL(type: .privacy)
            },
            settingCellModel(title: "Help/ Feedback"){ [weak self] in
                self?.openURL(type: .help)
            }])
        data.append([
            settingCellModel(title: "Log Out"){ [weak self] in
                self?.didTapLogOut()
            }])
    }
    private func openURL(type: SettingsURLType){
        let urlString : String
        switch type{
            case .terms: urlString = "https://help.instagram.com/581066165581870"
            case .privacy: urlString = "https://privacycenter.instagram.com/policy"
            case .help: urlString = "https://help.instagram.com/"
        }
        guard let url = URL(string: urlString) else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    private func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let NavVC = UINavigationController(rootViewController: vc)
        NavVC.modalPresentationStyle = .fullScreen
        present(NavVC, animated: true)
    }
    
    private func didTapInviteFriends(){
        //show share sheet to invite friends
    }
    
    private func didTapSaveOriginalPosts(){
        
    }
    private func didTapLogOut(){
        let verifyDisplay = UIAlertController(title: "Log Out",
                                              message: "Are you sure you want to log out?",
                                              preferredStyle: .actionSheet)
        verifyDisplay.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        verifyDisplay.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            AuthManager.shared.logOut(completion: {success in
                DispatchQueue.main.async {
                    if success{
                        //present log in screen
                        let logInVC = LoginViewController()
                        logInVC.modalPresentationStyle = .fullScreen
                        self.present(logInVC, animated: true){
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }
                    else{
                        //present error display
                        fatalError("Couldn't log out user")
                    }
                }
               
            })
        }))
        verifyDisplay.popoverPresentationController?.sourceView = tableView
        verifyDisplay.popoverPresentationController?.sourceRect = tableView.bounds
        
        present(verifyDisplay, animated: true)
        
        
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:  indexPath)
        //textLabel will be deprecated at somepoint
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        //this is the arrows on each settings tab
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //handle cell selection
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
}
