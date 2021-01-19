import UIKit
import CoreLocation

class LocationTrackerViewController: UIViewController {
    
    let locationManager: CLLocationManager = {
        let location = CLLocationManager()
        return location
    }()
    
    lazy var displayDataLabel: UILabel = {
        let label = UILabel()
        label.text = "Total updates will be shown here"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lastUpdatedTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Last updated Time will be shown here"
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var startTime: Date?
    private var initialLocation: CLLocation?
    private var updatedDataCount: Int = 0
    var interactor: LocationTrackerBusinessLogic?
    var router: LocationTrackerRouterLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatedDataCount = UserDefaults.standard.integer(forKey: LocalKeys.uploadCount)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        setUpView()
        
        if let date = UserDefaults.standard.object(forKey: LocalKeys.day) as? Date {
            showDataToUser(uploadCount: updatedDataCount,
                           time: date.convertToString())
        }
    }
    
    /*
     1. stored values in userDefault to maintain previous date and count after app removed from background
     2. if date not same as current date, updated count to 0 i.e. reset value at midnight
     */
    // MARK: - reset number of data updated value (at midnight)
    func resetCountValue() {
        guard let date = UserDefaults.standard.object(forKey: LocalKeys.day) as? Date else {
            UserDefaults.standard.set(Date(), forKey: LocalKeys.day)
            return
        }
        let dateString = date.convertToString().split(separator: " ").first
        let currentDateString = Date().convertToString().split(separator: " ").first
        if currentDateString != dateString {
            updatedDataCount = 0
            UserDefaults.standard.set(updatedDataCount, forKey: LocalKeys.uploadCount)
            UserDefaults.standard.set(Date(), forKey: LocalKeys.day)
        }
    }
}

// Location Manager delegate extension
extension LocationTrackerViewController: CLLocationManagerDelegate {
    
    //MARK: - user authorization for location data collection
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else {return}
        let time = loc.timestamp
        guard let startTime = startTime else {
            self.startTime = time
            return
        }
        
        guard let startLocation = initialLocation else {
            initialLocation = locations.first
            return
        }
        resetCountValue()
        let distanceTraveled = loc.distance(from: startLocation)
        let elapsed = time.timeIntervalSince(startTime)
        if elapsed > 30 || distanceTraveled > 200 {
            let location = CLLocationCoordinate2D(latitude: loc.coordinate.latitude,
                                                  longitude: loc.coordinate.longitude)
            self.startTime = time
            initialLocation = loc
            updatedDataCount += 1
            UserDefaults.standard.setValue(updatedDataCount, forKey: LocalKeys.uploadCount)
            UserDefaults.standard.setValue(startTime, forKey: LocalKeys.day)
            
            let data = UserLocationData(latitude: location.latitude, longitude: location.longitude, updatedCount: updatedDataCount, time: time)
            interactor?.saveDataInCloud(userLocationData: data)
        }
    }
}

// view update extension
extension LocationTrackerViewController: LocationTrackerDisplayLogic {
    
    // MARK: - show DB upload count value and time of upload
    func showDataToUser(uploadCount: Int, time: String) {
        DispatchQueue.main.async {
            self.displayDataLabel.text = "Total \(uploadCount) uploads today"
            self.lastUpdatedTimeLabel.text = "last updated: \(time)"
        }
    }
    
    // MARK: - show error message if DB failed to upload data
    func genericErrorMessage(){
        DispatchQueue.main.async {
            self.displayDataLabel.text = "Couldn't upload data."
            self.lastUpdatedTimeLabel.isHidden = true
        }
    }
    
    // MARK: - to set up view constraints
    func setUpView() {
        view.addSubview(displayDataLabel)
        view.addSubview(lastUpdatedTimeLabel)
        NSLayoutConstraint.activate([
            displayDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            displayDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            lastUpdatedTimeLabel.topAnchor.constraint(equalTo: displayDataLabel.bottomAnchor),
            lastUpdatedTimeLabel.leadingAnchor.constraint(equalTo: displayDataLabel.leadingAnchor),
            lastUpdatedTimeLabel.trailingAnchor.constraint(equalTo: displayDataLabel.trailingAnchor),
        ])
    }
}
