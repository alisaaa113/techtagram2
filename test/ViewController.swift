//
//  ViewController.swift
//  test
//
//  Created by arisa isshiki on 2018/02/18.
//  Copyright © 2018年 alisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //画像加工するための元となる画像
    var originalImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //撮影する時のメゾット
    @IBAction func useCamera(){
        //カメラが使えるかの確認
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //カメラ起動
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }else{
            //カメラが使えないときはエラーがコンソールに
            print("error")
        }
    }
    //カメラ、カメラロールを使った時に選択した画像をアプリ内に表示する為のメゾット
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //cameraImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        //cameraImageViewにはカメラで撮った画像か、カメラロールの画像のどちらかが表示されている
        //表示されているものをUIImageに移動させる
        originalImage = info[UIImagePickerControllerEditedImage] as? UIImage
        
        //secondに、imageとimageview送る
        
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "toSecondView", sender: nil)
        
    }
   
    
    //カメラロールにある画像を読み込む
    @IBAction func openAlbum(){
        
        //カメラロールを使えるか
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //カメラロールの画像を選択して画像を表示
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
            
            
        }
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toSecondView") {
            let secondViewController = segue.destination as! SecondViewController
            secondViewController.originalImage = self.originalImage
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

