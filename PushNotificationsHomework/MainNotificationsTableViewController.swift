
import UIKit
import UserNotifications
import CoreData

class MainNotificationsTableViewController: UITableViewController {
    
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    let notificationNibName = "NotificationTableViewCell"
    fileprivate let cellIdentefier = "NotificationTableViewCellIdentefier"
    var refresher: UIRefreshControl!
    var notificationItems = [Notification]()
    
    var notificationModels: [NotificationModel] = []
    let notificationName = "name"
    let notificationContent = "text"
    let notificationImage = #imageLiteral(resourceName: "hello")
    var moc: NSManagedObjectContext!
    
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        moc = appDelegate?.persistentContainer.viewContext
        registrateNib()
        creatingNotification()
        saveNotificationToDatabase()
        creatingRefresh()
        loadData()
        creatingNotification()
    }
    
    func creatingNotification() {
        let content = UNMutableNotificationContent()
        content.title = notificationName
        content.body = notificationContent
        content.sound = UNNotificationSound.default()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        guard let path = Bundle.main.path(forResource: "3441", ofType: "jpg") else {return}
        let url = URL(fileURLWithPath: path)
        do {
            let attachment = try UNNotificationAttachment(identifier: "logo", url: url, options: nil)
            content.attachments = [attachment]
        } catch {
            print("something gone wrong")
            
        }
        let request = UNNotificationRequest(identifier: "testIdentefier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        let notificationItem = Notification(context: (appDelegate?.persistentContainer.viewContext)!)
        
        notificationItem.name = notificationName
        notificationItem.text = notificationContent
        appDelegate?.saveContext()
        
    }
    func loadData() {
        let notificationRequest: NSFetchRequest<Notification> = Notification.fetchRequest()
        let notificationName = NSSortDescriptor(key: "name", ascending: false)
        let notificationText = NSSortDescriptor(key: "text", ascending: false)
        
        notificationRequest.sortDescriptors = [notificationName,notificationText]
        
        do {
            try notificationItems = moc.fetch(notificationRequest)
        } catch{
            print("Could not load data")
        }
        self.tableView.reloadData()
        
        
    }
    
    func registrateNib() {
        let nib = UINib(nibName: notificationNibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentefier)
    }
    
    @objc func refresh(){
        loadData()
        self.tableView.reloadData()
        self.refresher.endRefreshing()
        
    }
    func creatingRefresh() {
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(MainNotificationsTableViewController.refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refresher)
    }
    
    func saveNotificationToDatabase() {
        let notificationItem = Notification(context: moc)
        notificationItem.name = notificationName
        notificationItem.text = notificationContent
        appDelegate?.saveContext()
        loadData()
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentefier, for: indexPath) as? NotificationTableViewCell
        
        let notificationItem = notificationItems[indexPath.row]
        
        
        cell?.prepareCell(with: notificationItem)
        return cell!
        
    }
    
}
