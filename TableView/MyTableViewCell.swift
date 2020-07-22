
import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var nhan: UILabel!
    var data = ""
    
    weak var delegate: Click! // weak chi dung cho class, k cho struct enum
    // action button ben trong view
    @IBAction func bamNut(_ sender: Any) {
        delegate.onClick(data)
        print("click")
    }
    // chay luc new ra cell
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(_ str: String,_ onClick: Click) {
        data = str
        delegate = onClick
    }
    // chay sau khi rowForCell
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        nhan.text = data
    }
    
}
protocol Click : class{
    func onClick(_ str: String)
}
