//
//  commentViewController.swift
//  Instagram
//
//  Created by 小野真 on 2021/03/20.
//

import UIKit
import Firebase

class commentViewController: UIViewController,UITextFieldDelegate {
    
    var postDataID = ""
    
    @IBOutlet weak var commentfield: UITextField!
    
    //投稿ボタンを押したら起動
    @IBAction func commentsend(_ sender: Any) {
        // commentを更新する
       
        let commenttext = commentfield.text
        //新たにコメントfield追加
            let updateValue = FieldValue.arrayUnion([commenttext])
            // commentに更新データを書き込む
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postDataID)
            postRef.updateData(["comment":  updateValue])
        
        //投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    
    }
    
    
    
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
    //キーボード起動
    override func viewWillAppear(_ animated: Bool) {
        print(postDataID)
        commentfield.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
         print("DEBUG_PRINT: 画面遷移できました")
        
        
        
    

        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
