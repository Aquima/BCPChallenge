//
//  BrokerView.swift
//  BCPChallenge
//
//  Created by Raul Quispe on 27/11/21.
//

import UIKit

protocol BrokerViewDelegate: AnyObject {
    func goToNext()
}
class BrokerView: UIViewController,
                  BrokerViewModelDelegate {
    static let identifier = "homeView"
    weak var delegate: BrokerViewDelegate?
    let imageBanner = UIImageView()
    let listExchangeOptions = ListView()
    let textInfo = UILabel()
    var viewModel = BrokerViewModel()
    private var data: [ItemExchange] = [ItemExchange]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        viewModel.delegate = self
    }
    func setupUI() {
        self.view.backgroundColor = .white
        createImageBanner()
        createListView()
        createTextInfo()
        createOperationButton()
    }
    func createImageBanner() {
        let image = UIImage.init(named: "banner")
        imageBanner.image = image
        self.view.addSubview(imageBanner)
        imageBanner.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.height.equalTo(50)
            make.width.equalTo(140)
            make.centerX.equalToSuperview()
        }
        imageBanner.contentMode = .scaleAspectFit

    }
    func createTextInfo() {
        textInfo.backgroundColor = .clear
        textInfo.text = "Compra: 3.25 | Venta: 3.29"
        textInfo.textColor = .black
        self.view.addSubview(textInfo)
        textInfo.snp.makeConstraints{ make in
            make.top.equalTo(600)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    func createListView() {
        self.view.addSubview(listExchangeOptions)
        listExchangeOptions.delegate = self
        HomeConstraints.dashboardListView(
                                       listExchangeOptions, self.imageBanner, self.view.safeAreaLayoutGuide)
        listExchangeOptions.numberSections = 1
        listExchangeOptions.rowHeightSizes = [HomeTableViewCell.heightSize
                                            ]
        listExchangeOptions.register(
            cellClass: [HomeTableViewCell.self
                        ],
            identifiers: [HomeTableViewCell.identifierCell
                          ])
        setData()
        listExchangeOptions.backgroundColor = .clear
    }
    func createOperationButton() {
        let button = UIButton()
        button.setTitle("Empieza tu operacion", for: .normal)
        button.backgroundColor = .blue
        self.view.addSubview(button)
        button.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(60)
            make.bottom.equalTo(-20)
        }
        button.addTarget(self, action: #selector(reduce), for: .touchUpInside)
    }
    @objc func reduce(){
        viewModel.reduce(self.data)
    }
    func setData() {
        let title1 = "Tu envias: "
        self.data.append(
            ItemExchange.init(title1, "0.0", .USD))
        let title2 = "Tu Recibes: "
        self.data.append(
            ItemExchange.init( title2, "0.0", .PEN))
        let sectionsRows = [self.data.count]
        listExchangeOptions.sectionsRows = sectionsRows
        listExchangeOptions.deactivateScroll()
        listExchangeOptions.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let indexpath = StoreMemory.shared.currentIndex,
              let typeMoney = StoreMemory.shared.currentSelectTypeMoney,
              let amount = StoreMemory.shared.amount else {
                    return   
                }
            
            if indexpath.row == 0 {
                data[0] = ItemExchange("Tu envias: ", amount, typeMoney)
            }
            self.listExchangeOptions.reloadData()
    }
    // MARK- : BrokerViewModelDelegate
    func reduceUpdate(_ data: [ItemExchange]) {
        self.data = data
        listExchangeOptions.reloadData()
    }
}
extension BrokerView: ListViewDelegate {
    fileprivate func createHomeTableViewCell(
        _ tableView: UITableView) -> HomeTableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifierCell) as? HomeTableViewCell
            cell!.didTouchUpInside = { item, indexpath in
                print(item.typeMoney)
                StoreMemory.shared.currentIndex = indexpath
                self.delegate?.goToNext()
            }
        return cell!
    }
    func listView(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = createHomeTableViewCell(tableView)
        cell.load(data[indexPath.row], indexPath)
        return cell
    }
    func listViewDidSelect(_ indexPath: IndexPath) {
        
    }
}
