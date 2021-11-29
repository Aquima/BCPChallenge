//
//  OperationTableViewCell.swift
//  BCPChallenge
//
//  Created by Raul Quispe on 27/11/21.
//

import UIKit

class OperationTableViewCell: UITableViewCell {
    public static let heightSize: CGFloat = 100.00
    public static let identifierCell = "OperationTableViewCell"
    var contentInputsView = UIView()
    let titleText = UILabel()
    let amountText = UILabel()
    let imageFlag = UIImageView()
    let slashBottom = UIView()
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: OperationTableViewCell.identifierCell)
        createContentView()
        createTitle()
        createAmount()
        createImageFlag()
        createSlashView()
        self.selectionStyle = .none
        self.backgroundColor = .clear
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

        // Configure the view for the selected state
    }
    func load(_ data: OperationModel) {
        imageFlag.image = data.icon
        titleText.text = data.title
        amountText.text = data.amount
    }
    // MARK: Drawing Inputs
    func createContentView() {
        self.contentInputsView.backgroundColor = .clear
        self.contentView.layer.masksToBounds = true
        self.addSubview(contentInputsView)
        self.contentInputsView.snp.makeConstraints { make in
            make.top.equalTo(2)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
        }
    }
    func createImageFlag() {
        self.contentInputsView.addSubview(imageFlag)
        imageFlag.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(30)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }
    func createTitle() {
        titleText.backgroundColor = .clear
        titleText.textColor = .black
        self.contentInputsView.addSubview(titleText)
        titleText.snp.makeConstraints { make in
            make.leading.equalTo(127)
            make.top.equalTo(10)
            make.height.equalTo(20)
        }
    }
    func createAmount() {
        amountText.backgroundColor = .clear
        amountText.textColor = .lightGray
        self.contentInputsView.addSubview(amountText)
        amountText.snp.makeConstraints { make in
            make.leading.equalTo(127)
            make.top.equalTo(35)
            make.height.equalTo(17)
        }
    }
    func createSlashView() {
        slashBottom.backgroundColor = .lightGray
        self.contentInputsView.addSubview(slashBottom)
        slashBottom.snp.makeConstraints{ make in
            make.top.equalTo(70)
            make.height.equalTo(1)
            make.width.equalTo(200)
            make.trailing.equalTo(-38)
        }
    }
}
