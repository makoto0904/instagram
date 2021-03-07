//
//  LoginViewController.swift
//  Instagram
//
//  Created by 小野真 on 2021/03/04.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    //ログインボタンをタップした時に呼ばれるメソッド
    @IBAction func handleLoginButton(_ sender: Any) {
    }
    //アカウント作成ボタンをタップした時に呼ばれるメソッド
    @IBAction func handleCreateAccountButton(_ sender: Any) {
        if let address = mailAddressTextField.text, let passwaord = passwordTextField.text, let displayName = displayNameTextField.text{
            
            //アドレスとパスワードと表示名のいずれかでも入力されていない時は何もしない
            if address.isEmpty || passwaord.isEmpty || displayName.isEmpty
            {
                print("DEBUG_PRINT: 何かが空文字です。")
                return
            }
            // アドレスとパスワードでユーザー作成。ユーザー作成に成功すると、自動的にログインする
            Auth.auth().createUser(withEmail: address, password: passwaord){ authResult, error in
                if let error = error{
                    //エラーがあったら原因をprintして、returnすることで以降の処理を実行せずに処理を終了する
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    return
                }
                print("DEBUG_PRINT: ユーザー作成に成功しました。")
                
                //表示名を設定する
                let user = Auth.auth().currentUser
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges {error in
                        if let error = error {
                            //プロフィールの更新でエラーが発生
                            print("DEBUG_PRINT: " + error.localizedDescription)
                            return
                        }
                            print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました。")
                        //画面を閉じてタブ画面に戻る
                        self.dismiss(animated: true, completion: nil)
                        }
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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