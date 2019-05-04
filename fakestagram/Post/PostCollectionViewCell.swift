//
//  PostCollectionViewCell.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "postViewCell"
    public var post: Post? {
        didSet { updateView() }
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorView: PostAuthorView!
    @IBOutlet weak var titleLbl: UITextView!
    @IBOutlet weak var likesCountLbl: UILabel!
    @IBOutlet weak var commentsCountLbl: UILabel!

    @IBOutlet weak var likeBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }

    private func updateView() {
        guard let post = self.post else { return }
        post.load { [weak self] img in
            self?.imageView.image = img
        }
        authorView.author = post.author
        titleLbl.text = post.title
        likesCountLbl.text = "\(post.likesCount) likes"
        commentsCountLbl.text = "\(post.commentsCount) comments"
        print ("->\(post.liked) - \(String(describing: post.author?.name))")
        if post.liked {
            likeBtn.titleLabel?.text = "unLike"
        }
        else {
            likeBtn.titleLabel?.text = "Like"
        }
    }
    let client = LikeUpDaterClient()
    
    @IBAction func tapLike(_ sender: UIButton) {
        guard let post = post else {return}
        
        if post.swapLiked() {
            post.likesCount = client.like(post: post)
        }else {
            post.likesCount = client.dislike(post: post)
        }
        likesCountLbl.text = "\(post.likesCount) likes"
        
    }
}
