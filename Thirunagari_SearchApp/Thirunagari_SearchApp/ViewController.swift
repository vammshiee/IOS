//
//  ViewController.swift
//  Thirunagari_SearchApp
//
//  Created by Thirunagari,Vamshi Krishna on 2/28/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultImage: UIImageView!
        @IBOutlet weak var searchTextField: UITextField!
        @IBOutlet weak var searchBtn: UIButton!
        @IBOutlet weak var moreBtn: UIButton!
        
        @IBOutlet weak var reset: UIButton!
        var Imagesdata = [
            ["book1","book2","book3","book4","book5"]
            ,["cartoon1","cartoon2","cartoon3","cartoon4","cartoon5"],
            ["plant1","plant2","plant3","plant4","plant5"],[
            ]
        ]
        
        var book_Keywords = ["book"]
        var cartoon_Keywords = ["cartoon"]
        var plant_Keywords = ["plant"]
        var bookCount:Int!
        var cartoonCount:Int!
        var plantCount:Int!
        
        
        var type = 0
        
        @IBOutlet weak var topicInfoText: UITextView!
        override func viewDidLoad() {
            super.viewDidLoad()
            resultImage.image = UIImage(named: "search")
            searchBtn.isEnabled = false
            updateImageView()
            moreBtn.isHidden = true
            reset.isHidden = true
            
            
        }
        
        @IBAction func searchButtonAction(_ sender: UIButton) {
            moreBtn.isHidden = false
            topicInfoText.isHidden = true
            reset.isHidden = false
            bookCount = 0
            cartoonCount = 0
            plantCount=0
            
            let searchText = searchTextField.text!
            if book_Keywords.contains(searchText) {
                updateImagesSet(0,bookCount)
                topicInfoText.text = "The results for \(searchText) are cat,dog,parrot and lion. There are different categories. The animals are classifed as omnivores,carnivores and herbivores.This search has \(Imagesdata[0].count) results."
                type = 1
            }
            else if cartoon_Keywords.contains(searchText){
                type = 2
                updateImagesSet(1,cartoonCount)
                topicInfoText.text = "The results for \(searchText) are lapotp,mobile,earpods etc.Electronics include most of the home appliances. Most of these are technology based. This search has \(Imagesdata[1].count) results."
                
            }
            else if plant_Keywords.contains(searchText){
                type = 3
                updateImagesSet(2,plantCount)
                topicInfoText.text = "The results for \(searchText). Collectively flowers are known as 'flora' scientifically.There are few flowers which are floroscents and few are not. This search has \(Imagesdata[2].count) results."
                
            }
            else {
                type = 9
                resultImage.image = UIImage(named: "search")
                searchTextField.text = ""
                sender.isEnabled = false
                moreBtn.isHidden = true
                topicInfoText.isHidden = true
                reset.isHidden = true
                
            }
        }
        @IBAction func startedEditingSearch(_ sender: UITextField) {
            
            searchBtn.isEnabled = true
            
            if sender.text == "" {
                searchBtn.isEnabled = false
            }
        }
        
        @IBAction func showMoreImagesBtn(_ sender: UIButton) {
            
            switch(type) {
            case 1 :
                showingImages(&type,&bookCount)
            case 2 :
                showingImages(&type,&cartoonCount)
            case 3:
                showingImages(&type,&plantCount)
            default:
                print("nothing")
            }
            
        }
        func updateImageView(){
            resultImage.contentMode = .scaleToFill
            
        }
        @IBAction func resetButton(_ sender: Any) {
            resultImage.image = UIImage(named: "search")
            searchTextField.text = ""
            moreBtn.isHidden = true
            topicInfoText.isHidden = true
            reset.isHidden = true
            bookCount = 0
            cartoonCount = 0
            plantCount=0
        }
        
        func updateImagesSet(_ topic:Int,_ topicCounter:Int){
            moreBtn.isEnabled = true
            topicInfoText.isHidden = false
            resultImage.image = UIImage(named: Imagesdata[topic][topicCounter])
            searchTextField.text = ""
            searchBtn.isEnabled =  false
        }
        
        func showingImages(_ topic: inout Int,_ topicCounter:inout Int){
            topicCounter += 1
            if topicCounter < Imagesdata[topic-1].count {
                
                resultImage.image = UIImage(named: Imagesdata[topic-1][topicCounter])
                
            }
            if topicCounter == Imagesdata[topic-1].count-1 {
                moreBtn.isEnabled = false
                topicCounter = 0
            }
        }


}

