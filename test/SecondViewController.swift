//
//  SecondViewController.swift
//  test
//
//  Created by arisa isshiki on 2018/02/19.
//  Copyright © 2018年 alisa. All rights reserved.
//

import UIKit
import Accounts

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var filter1: Float = 0.5
    
    @IBOutlet var cameraImageView: UIImageView!
    
    //画像加工するための元となる画像
    var originalImage: UIImage!
    //画像加工するフィルターの宣言
    var filter: CIFilter!
    
    
    //スタンプ画像の名前が入った配列
    var imageNameArray: [String] = ["1.png", "2.png", "3.png","4.png","5.png","6.png","7.png","8.png"]
    
    //選択しているスタンプ画像の番号
    var imageIndex: Int = 0
    
    //スタンプ画像が入るImageView
    var ImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //image受け渡し
        cameraImageView.image = originalImage
        
    }
    
    
    //表示している画像にフィルター加工
    @IBAction func applyFilter(){
        
        let filterImage: CIImage = CIImage(image: originalImage)!
        
        filter = CIFilter(name: "CIFalseColor")
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
        
    }
    @IBAction func applyFilter2(){
        
        let filterImage: CIImage = CIImage(image: originalImage)!
    
        filter = CIFilter(name: "CISepiaTone", withInputParameters: ["inputIntensity": 1.0])
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
        
    }
    @IBAction func applyFilter3(){
        
        let filterImage: CIImage = CIImage(image: originalImage)!
        
        filter = CIFilter(name: "CIColorMonochrome")
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
        
    }
    @IBAction func applyFilter4(){
        
        let filterImage: CIImage = CIImage(image: originalImage)!
        
        filter = CIFilter(name: "CIColorInvert")
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
        
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
        //明度の調整
        filter.setValue(0.5, forKey: "inputBrightness")
        //コントラストの調整
        filter.setValue(2.5, forKey: "inputContrast")
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //タッチされた位置を取得
        let touch:UITouch = touches.first!
        let location: CGPoint = touch.location(in: self.view)
        
        //もし,imageIndexが0でない　（押すスタンプが選ばれていない）とき
        if imageIndex != 0 {
            //スタンプサイズを指定
            ImageView = UIImageView(frame: CGRect(x: 0, y:0, width: 100, height: 70))
            
            //押されたスタンプの画像を指定
            let image: UIImage = UIImage(named: imageNameArray[imageIndex - 1])!
            ImageView.image = image
            
            
            //タッチされた位置に画像を置く
            
            if (location.x <= 320 && location.y <= 320){
                
                //画像を表示する
                self.view.addSubview(ImageView)
                
                ImageView.center = CGPoint(x: location.x ,y: location.y)
            }
            else{
                // print("error")
            }
            
        }
    }
    
    @IBAction func selectedFirst() {
        imageIndex = 1
    }
    
    @IBAction func selectedSecond() {
        imageIndex = 2
    }
    
    @IBAction func selectedThird() {
        imageIndex = 3
    }
    
    @IBAction func selectedFourth() {
        imageIndex = 4
    }
    
    @IBAction func selectedFifth() {
        imageIndex = 5
    }
    
    @IBAction func selectedSixth() {
        imageIndex = 6
    }
    
    @IBAction func selectedSeventh() {
        imageIndex = 7
    }
    
    @IBAction func selectedEight() {
        imageIndex = 8
    }
    
    //編集した画像保存
    @IBAction func save() {
        //画面上のスクリーンショットを取得
        let rect:CGRect = CGRect(x: 0, y: 30, width: 320, height: 320)
        UIGraphicsBeginImageContext(rect.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //フォトライブラリに保存
        UIImageWriteToSavedPhotosAlbum(capture!,nil, nil, nil)
        
        //UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, nil, nil, nil)
        
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
    
    
    @IBAction func back() {
//       self.presentingViewController?.presentationController?
//        .dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
