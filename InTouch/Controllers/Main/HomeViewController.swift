//
//  ViewController.swift
//  InTouch
//
//  Created by jesse andringa on 3/8/23.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel{
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {

    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    let tableView : UITableView = {
        let tableView = UITableView()
        //register cells
        tableView.register(FeedPostTableViewCell.self,
                           forCellReuseIdentifier: FeedPostTableViewCell.identifier)
        tableView.register(FeedPostHeaderTableViewCell.self,
                           forCellReuseIdentifier: FeedPostHeaderTableViewCell.identifier)
        tableView.register(FeedPostActionsTableViewCell.self,
                           forCellReuseIdentifier: FeedPostActionsTableViewCell.identifier)
        tableView.register(FeedPostGeneralTableViewCell.self,
                           forCellReuseIdentifier: FeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMockModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func createMockModels(){
        let user = User(username: "JimmyEats",
                        name: (first:"",last:""),
                        birthDate: Date(),
                        gender: .male,
                        bio: "",
                        count: UserCount(followers: 1, following: 1, posts: 1),
                        joinDate: Date(),
                        profilePhoto: URL(string:"https://www.google.com")!)
        
        let post = UserPost(identifier: "",
                            postType: .photo,
                            thumbnailImage: URL(string: "https://www.google.com")!,
                            postURL: URL(string:"https://www.google.com")!,
                            caption: nil,
                            likeCount: [],
                            comments: [],
                            createdDate: Date(),
                            taggedUsers: [],
                            owner: user)
        var comments = [PostComment]()
        for x in 0..<2{
            comments.append(PostComment(identifier: "\(x)",
                                        userName: "@jenny",
                                        text: "I love this post",
                                        createdDate: Date(),
                                        likes: [])
                            )
        }
        
        
        for x in 0..<5 {
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                    post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                    actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                                    comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //check if user is logged in/auth
        checkUserAuthentication()
    }
    
    func checkUserAuthentication(){
        if Auth.auth().currentUser == nil{
            //show log in page
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false )
        }//else do nothing
    
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0{
            model = feedRenderModels[0]
        }
        else{
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
//            print("position: ")
//            print(position)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0{
            //header
            return 1
        }
        else if subSection == 1{
            //posot
            return 1
        }
        else if subSection == 2{
            //actions
            return 1
        }
        else if subSection == 3{
            //comments
            let commentsModel = model.comments
            switch commentsModel.renderType{
            case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            case .header, .actions, .primaryContent: return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0{
            model = feedRenderModels[0]
        }
        else{
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        
        let subSection = x % 4
        
        if subSection == 0{
            //header
            let headerModel = model.header
            switch headerModel.renderType{
                case .header(let user):
                    let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostHeaderTableViewCell.identifier,
                                                             for:indexPath) as! FeedPostHeaderTableViewCell
                    return cell
                case .comments, .actions, .primaryContent: return UITableViewCell()
            }
        }
        else if subSection == 1{
            //posot
            let postModel = model.post
            switch postModel.renderType{
                case .primaryContent(let post):
                    let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.identifier,
                                                             for:indexPath) as! FeedPostTableViewCell
                    return cell
                case .header, .actions, .comments: return UITableViewCell()
            }
        }
        else if subSection == 2{
            //actions
            let actionModel = model.actions
            switch actionModel.renderType{
                case .actions(let provider):
                    let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostActionsTableViewCell.identifier,
                                                             for:indexPath) as! FeedPostActionsTableViewCell
                    return cell
                case .header, .primaryContent, .comments: return UITableViewCell()
            }
        }
        else if subSection == 3{
            //comments
            let commentsModel = model.comments
            switch commentsModel.renderType{
                case .comments(let comments):
                    let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostActionsTableViewCell.identifier,
                                                             for:indexPath) as! FeedPostActionsTableViewCell
                    return cell
                case .header, .actions, .primaryContent: return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        if subSection == 0 {
            //Header
            return 70
        }
        else if subSection == 1 {
            //Post
            return tableView.width
        }
        else if subSection == 2 {
            //Actions
            return 60
        }
        else if subSection == 3 {
            //Comment row
            return 50
        }
        else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        //return padding after every post
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
    
}

