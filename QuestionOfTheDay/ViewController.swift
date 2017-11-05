 import UIKit

class ViewController: UIViewController {
    // Test connection on this view controller
    let APPLICATION_ID = "4D3FD244-8F00-858C-FF1B-B0DB5F95C000"
    let API_KEY = "44D4173F-E674-F658-FF51-5334102EB900"
    let SERVER_URL = "https://api.backendless.com"
    let backendless = Backendless.sharedInstance()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        backendless.hostURL = SERVER_URL
        backendless.initApp(APPLICATION_ID, apiKey: API_KEY)
        
        // Saving test object in the test table
        let testObject = ["foo" : "bar"];
        let dataStore = backendless.data.ofTable("TestTable")
        dataStore?.save(testObject,
                        response: {
                            (result) -> () in
                            print("Object is saved in Backendless. Please check in the console.")
        },
                        error: {
                            (fault : Fault?) -> () in
                            print("Server reported an error: \(String(describing: fault))")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
        
