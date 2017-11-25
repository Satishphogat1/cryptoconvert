//
//  ViewController.swift
//  Crypto Convert
//
//  Created by Crownstack on 25/11/17.
//  Copyright © 2017 Crownstack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(cellType: collectCurrencyCollectionCell.self)
        }
    }
    @IBOutlet weak var cryptoButton: UIButton! 
    @IBOutlet weak var commonButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField?
    var search = ""
    
    var currencyInfoObjectArray = [CurrencyInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func cryptoButtonAction(_ sender: UIButton) {
        if (sender.isSelected) {
            return
        }
        sender.isSelected = true
        sender.backgroundColor = .blue
        sender.setTitleColor(.white, for: .selected)
        cryptoButton.isSelected = true
        commonButton.isSelected = false
        commonButton.backgroundColor = .clear
        
        
    }
    
    @IBAction func commonButtonAction(_ sender: UIButton) {
        if (sender.isSelected) {
            return
        }
        sender.backgroundColor = UIColor.blue
        sender.setTitleColor(.white, for: .selected)
        cryptoButton.isSelected = false
        cryptoButton.backgroundColor = .clear
        sender.isSelected = true
        
        getCurrencyDetail()

    }
    
    func getCurrencyDetail() {
        
        let urlPath = "https://www.cryptocompare.com/api/data/coinlist/"
        guard let url = URL(string: urlPath) else { return }
        LoaderView.showIndicator(view)
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self]
            (data, response, error) in
            guard let _self = self else { return }
            LoaderView.remove(_self.view)
            if(error != nil){
                print("error")
            } else {
                do {
                    var currencyArray = [NSDictionary]()
                    if let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? NSDictionary {
                        let response = json.value(forKey: "Response") as? String
                        let baseImageUrl = json.value(forKey: "BaseImageUrl") as? String
                        if response == "Success" {
                            UserDefaults.standard.set(baseImageUrl, forKey: "baseImageUrl")
                            currencyArray = ((json.value(forKey: "Data") as? NSDictionary)?.allValues as? [NSDictionary])!
                            for currency in currencyArray {
                                print(currency)
                                self?.currencyInfoObjectArray.append(CurrencyInfo.parseCurrency(currency, baseImageUrl: baseImageUrl!))
                                self?.currencyInfoObjectArray =   (self?.currencyInfoObjectArray.sorted(by: {$0.code < $1.code}))!
                            }
                            dispatch {
                                _self.collectionView.reloadData()
                            }
                        }
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
    }
    
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencyInfoObjectArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: collectCurrencyCollectionCell.self)
        var currencyInfoObject = CurrencyInfo()
        currencyInfoObject = currencyInfoObjectArray[indexPath.item]
        cell.cellLabel.text = currencyInfoObject.code
        let imageUrl = UserDefaults.standard.value(forKey: "baseImageUrl") as? String
        cell.cellImageView.loadImageUsingCache(withUrl: imageUrl! + currencyInfoObject.imageUrl)
        return cell
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = searchTextField?.text ?? ""
        search = string.isEmpty ? String(search.dropLast()) : text + string
        return true
    }
}

