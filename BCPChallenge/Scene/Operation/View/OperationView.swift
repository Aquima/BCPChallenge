//
//  OperationView.swift
//  BCPChallenge
//
//  Created by Raul Quispe on 27/11/21.
//

import UIKit

protocol OperationViewDelegate: AnyObject {
    func goToBack()
}
class OperationView: UIViewController,
                     StackExchangeViewModelDelegate {

    static let identifier = "operationView"
    weak var delegate: OperationViewDelegate?
    let listDetailView = ListView()
    var imageBanner = UIImageView()
    private var data: [OperationModel] = [OperationModel]()
    var viewModel = StackExchangeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        viewModel.delegate = self
        viewModel.getStackExchange()
    }
    func setupUI() {
        self.view.backgroundColor = .white
        createImageBanner()
        createListSettings()
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

    func createListSettings() {
        self.view.addSubview(listDetailView)
        listDetailView.delegate = self
        OperationConstraints.dashboardListView(
                                       listDetailView, self.imageBanner, self.view.safeAreaLayoutGuide)
        listDetailView.numberSections = 1
        listDetailView.rowHeightSizes = [OperationTableViewCell.heightSize
                                            ]
        listDetailView.register(
            cellClass: [OperationTableViewCell.self
                        ],
            identifiers: [OperationTableViewCell.identifierCell
                          ])
        setOperationData()
        listDetailView.backgroundColor = .clear
    }

    func setOperationData() {
        for typeMoney in TypeCurrency.allCases {
            let operationModel = OperationModel.init(titleText: ItemExchange.convertToString(typeMoney: typeMoney),
                                                     amountText: "1 EUR = 1.0000 EUR",
                                                     typeMoney: typeMoney,
                                                     rate: Double.random(in: 1.71...3.14).rounded(toPlaces: 2))
            self.data.append(operationModel)
        }

        let sectionsRows = [self.data.count]
        listDetailView.sectionsRows = sectionsRows
        listDetailView.reloadData()
    }

    @IBAction func goToFinish(_ sender: UIButton) {
        delegate?.goToBack()
    }
    // MARK: StackExchangeDelegate
    func updateList(data: StackExchangeUI) {
        self.data = data
        listDetailView.reloadData()
    }
}
extension OperationView: ListViewDelegate {
    fileprivate func createOperationTableViewCell(
        _ tableView: UITableView) -> OperationTableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: OperationTableViewCell.identifierCell) as? OperationTableViewCell
        return cell!
    }
    func listView(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = createOperationTableViewCell(tableView)
        cell.load(data[indexPath.row])
        return cell
    }
    func listViewDidSelect(_ indexPath: IndexPath) {
        StoreMemory.shared.currentSelectTypeMoney = data[indexPath.row].typeMoney
        StoreMemory.shared.rate = data[indexPath.row].rate
        self.delegate?.goToBack()
    }
}

