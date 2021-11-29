//
//  HomeTableViewCell.swift
//  BCPChallenge
//
//  Created by Raul Quispe on 27/11/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    typealias DidTapButton = (ItemExchange, IndexPath) -> ()
    var didTouchUpInside: DidTapButton?
    public static let heightSize: CGFloat = 80.00
    public static let identifierCell = "HomeTableViewCell"
    var contentInputsView = UIView()
    var contentTypeMoney = UIView()
    let titleText = UILabel()
    let amountText = UITextField()
    let typeMoney = UILabel()
    private var currentItemExchange: ItemExchange!
    private var currentIndexPath: IndexPath!
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: HomeTableViewCell.identifierCell)
        createContentView()
        createTitle()
        createAmount()
        createContentTypeMoney()
        createTypeMoney()
        self.selectionStyle = .none
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red:150/255, green:150/255, blue:150/255, alpha: 1).cgColor
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
    func load(_ item: ItemExchange,_ indexPath: IndexPath) {
        currentIndexPath = indexPath
        currentItemExchange = item
        titleText.text = item.title
        if item.amount == "0.0" {
            amountText.placeholder = "0.0"
        }else{
            amountText.text = item.amount
        }
        if indexPath.row == 1 {
            self.amountText.isUserInteractionEnabled = false
        }
        typeMoney.text = ItemExchange.convertToString(typeMoney: item.typeMoney)
    }
    // MARK: Drawing Inputs
    func createContentView() {
        self.contentInputsView.backgroundColor = .clear
        self.contentView.layer.masksToBounds = true
        self.addSubview(contentInputsView)
        self.contentInputsView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }
    }
    func createTitle() {
        titleText.backgroundColor = .clear
        titleText.textColor = .lightGray
        self.contentInputsView.addSubview(titleText)
        titleText.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.top.equalTo(12)
            make.height.equalTo(17)
        }
    }
    func createAmount() {
        amountText.keyboardType = .decimalPad
        amountText.textColor = .black
        self.contentInputsView.addSubview(amountText)
        amountText.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.top.equalTo(32)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        amountText.addTarget(
            self,
            action: #selector(textFieldDidChange),
            for: .editingChanged
        )
    }
    @objc func textFieldDidChange(textField: UITextField){
        
        StoreMemory.shared.amount = textField.text

    }
    func createContentTypeMoney() {
        contentTypeMoney.backgroundColor = .black
        self.contentInputsView.addSubview(contentTypeMoney)
        contentTypeMoney.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.trailing.equalTo(0)
            make.width.equalTo(150)
            make.bottom.equalTo(0)
            make.height.equalTo(80)
        }
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.minimumPressDuration = 0.5
        self.contentTypeMoney.addGestureRecognizer(tap)
        self.contentTypeMoney.isUserInteractionEnabled = true
    }
    func createTypeMoney() {
        typeMoney.backgroundColor = .clear
        typeMoney.textColor = .white
        self.contentTypeMoney.addSubview(typeMoney)
        typeMoney.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.top.equalTo(22)
        }
    }
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .began && self.currentIndexPath!.row == 0 {
            self.didTouchUpInside?(self.currentItemExchange, self.currentIndexPath!)
        }
    }
}

