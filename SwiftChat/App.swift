
import UIKit

let app = App()
class App: NSObject {

    let apiKey = "24829374892348972980137409821407210839472890317"

    var phone: String = "+7(923)323-32-32" {
        didSet {
            UserDefaults.standard.set(phone, forKey: "phone")
        }
    }

    func sendSMSCode(phone: String) {
        
        let randomCode = Int.random(in: 2000...9999)
        let text = "Kод для входа:\n \(randomCode)"

        Just.get("https://smspilot.ru/api.php",
                 params: ["send": text,
                          "to" : phone,
                          "apikay" : apiKey]) { response in
            print(response.statusCode)
        }
    }
}
