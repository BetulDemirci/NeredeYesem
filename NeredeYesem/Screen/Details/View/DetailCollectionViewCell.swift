//
//  DetailCollectionViewCell.swift
//  NeredeYesem
//
//  Created by Semafor Teknolojı on 25.08.2020.
//  Copyright © 2020 Semafor. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()

     override init(frame: CGRect) {
         super.init(frame: .zero)
         setup()
     }

     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     func setup() {
         contentView.addSubview(imageView)
         imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

         NSLayoutConstraint.activate([
             imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
             imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
             imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
             imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
             ])
     }
}
