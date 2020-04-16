//
//  QuizCategoryCell.swift
//  WorldQuiz
//
//  Created by TOUALBI Amine  on 14/04/2020.
//  Copyright © 2020 ToualbiApps. All rights reserved.
//

import UIKit

class QuizCategoryCell: UITableViewCell {
    
    var countryFlag : UIImageView!
    var countryLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        countryFlag = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        countryFlag.translatesAutoresizingMaskIntoConstraints = false
        countryFlag.contentMode = .scaleAspectFill
        countryFlag.clipsToBounds = true
        contentView.addSubview(countryFlag)
        
        countryLabel = UILabel()
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.isUserInteractionEnabled = false
        countryLabel.contentMode = .scaleAspectFill
        countryLabel.clipsToBounds = true
        countryLabel.textColor = .black
        countryLabel.font = countryLabel.font.withSize(15)
        countryLabel.adjustsFontSizeToFitWidth = false
        countryLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(countryLabel)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
           NSLayoutConstraint.activate([
               countryFlag.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 12),
               countryFlag.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
               countryFlag.widthAnchor.constraint(equalToConstant: 60),
               countryFlag.heightAnchor.constraint(equalToConstant: 60)
           ])
           
           NSLayoutConstraint.activate([
               countryLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 12),
               countryLabel.leadingAnchor.constraint(equalTo: countryFlag.trailingAnchor, constant: 12),
               countryLabel.trailingAnchor.constraint(equalTo: countryFlag.trailingAnchor, constant: 200),
               countryLabel.heightAnchor.constraint(equalToConstant: 16)
           ])
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }
       
       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
           self.accessoryType = selected ? .checkmark : .none
       }
    
}
