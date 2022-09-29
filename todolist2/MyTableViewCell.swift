//
//  MyTableViewCell.swift
//  todolist2
//
//  Created by 최진용 on 2022/09/23.
//

import UIKit



class MyTableViewCell: UITableViewCell {

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    
    var strikeThrough = false
    var deleteLine : ()->() = {}
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressDelete(_ sender: UIButton) {
        self.deleteLine()
    }
    
    
    @IBAction func pressCheck(_ sender: UIButton) {
        strikeThrough.toggle()
        if strikeThrough == true{
            cellLabel.attributedText = cellLabel.text?.addStrikeThrough()
            cellLabel.textColor = UIColor.gray
            checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        }
        else{
            cellLabel.attributedText = cellLabel.text?.removeStrikeThrough()
            cellLabel.textColor = UIColor.black
            checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
//MARK: -reusablequeue
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        if strikeThrough == true{
//            cellLabel.attributedText = cellLabel.text?.addStrikeThrough()
//            cellLabel.textColor = UIColor.gray
//            checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
//        }
//        else{
//            cellLabel.attributedText = cellLabel.text?.removeStrikeThrough()
//            cellLabel.textColor = UIColor.black
//            checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
//        }
//
//
//    }
    
    
    
    
    
}


//MARK: -string strikeThrough
extension String {
    func addStrikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func removeStrikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
        
}
