//
//  ThirdViewController.swift
//  test
//
//  Created by arisa isshiki on 2018/02/26.
//  Copyright © 2018年 alisa. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var filter1: Float = 1.0
    var filter2: Float = 1.0
    var filter3: Float = 1.0
    var filter4: Float = 0.5
    var filter5: Float = 1.0
    
    @IBOutlet var cameraImageView: UIImageView!
    
    //画像加工するフィルターの宣言
    var filter: CIFilter!
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
        cameraImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        originalImage = cameraImageView.image
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filter1Slider(sender: UISlider){
        filter1 = sender.value
        print(filter1)
        let filterImage: CIImage = CIImage(image: originalImage)!
        //フィルターの設定
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        //彩度の調整
        filter.setValue(filter1, forKey: "inputSaturation")
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)    
    }
    
    @IBAction func filter1Slider2(sender: UISlider){
        filter2 = sender.value
        print(filter2)
        let filterImage: CIImage = CIImage(image: originalImage)!
        //フィルターの設定
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        //明度の調整
        filter.setValue(filter2, forKey: "inputBrightness")
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
    }
    
    @IBAction func filter1Slider3(sender: UISlider){
        filter3 = sender.value
        print(filter3)
        let filterImage: CIImage = CIImage(image: originalImage)!
        //フィルターの設定
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        //コントラストの調整
        filter.setValue(filter3, forKey: "inputContrast")
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
    }
    
    /*
    @IBAction func filter1Slider4(sender: UISlider){
        sender.minimumValue = 0
        sender.maximumValue = 2
        sender.isContinuous = true
        print(filter4)
        let filterImage: CIImage = CIImage(image: originalImage)!
        //フィルターの設定
        filter = CIFilter(name: "CIBoxBlur")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
    }
 */
    
    @IBAction func filter1Slider5(sender: UISlider){
        filter5 = sender.value
        print(filter5)
        let filterImage: CIImage = CIImage(image: originalImage)!
        //フィルターの設定
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        //彩度の調整
        filter.setValue(filter5, forKey: "inputSaturation")
        //明度の調整
        filter.setValue(0.5, forKey: "inputBrightness")
        //コントラストの調整
        filter.setValue(2.5, forKey: "inputContrast")
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
    }
    
    
    //編集した画像保存
    @IBAction func save(){
        
        UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, nil, nil, nil)
        
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
    //編集した画像をシェアする
    @IBAction func share(){
        
        //投稿する時、一緒に載せるコメント
        let shareText = "写真加工できた"
        //投稿する画像の選択
        let shareImage = cameraImageView.image!
        //投稿するコメントと画像の準備
        let activityItems: [Any] = [shareText, shareImage]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        let excludeActivityTypes = [UIActivityType.postToVimeo, .saveToCameraRoll, .print]
        activityViewController.excludedActivityTypes = excludeActivityTypes
        present(activityViewController, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
