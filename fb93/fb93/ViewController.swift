import FirebaseDatabase
import UIKit

class ViewController: UIViewController {
    
    private let database = Database.database().reference()
    private let textField = UITextField()
    private let label = UILabel()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.frame = CGRect(x: 10, y: 100, width: view.frame.size.width - 40, height: 40)
        textField.placeholder = "Input data"
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        
        let saveButton = UIButton(frame: CGRect(x: 10, y: 200, width: view.frame.size.width - 40, height: 50))
        saveButton.setTitle("Insert into Database", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .darkGray
        view.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveTextToDatabase), for: .touchUpInside)
        
        
        label.frame = CGRect(x: 10, y: 300, width: view.frame.size.width - 40, height: 40)
        label.textColor = .purple
        label.textAlignment = .center
        label.text = "Last inserted data will be shown"
        view.addSubview(label)
        
        let fetchDataButton = UIButton(frame: CGRect(x: 10, y: 400, width: view.frame.size.width - 40, height: 50))
        fetchDataButton.setTitle("View Data", for: .normal)
        fetchDataButton.setTitleColor(.white, for: .normal)
        fetchDataButton.backgroundColor = .darkGray
                view.addSubview(fetchDataButton)
        fetchDataButton.addTarget(self, action: #selector(fetchDataFromDatabase), for: .touchUpInside)
        
    }
    
    @objc private func saveTextToDatabase() {
            // Get the text from the UITextField
            if let text = textField.text, !text.isEmpty {
                let object: [String: Any] = [
                    "text": text
                ]
                // Save the text to the database
                database.child("user_name").setValue(object)
                // Clear the text field
                textField.text = ""
            }
    }
    
    @objc private func fetchDataFromDatabase() {
        let nameRef = database.child("user_name")

            nameRef.observeSingleEvent(of: .value) { (snapshot) in
                if let value = snapshot.value as? [String: Any] {
                    let text = value["text"] as? String

                    // Update the label with the retrieved text
                    self.label.text = text ?? "No data found"
                } else {
                    self.label.text = "No data found"
                }
            }
    }

}
