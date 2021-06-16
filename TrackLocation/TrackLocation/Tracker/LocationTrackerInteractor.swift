import UIKit
import CoreData

class LocationTrackerInteractor: LocationTrackerBusinessLogic {
    let presenter: LocationTrackerPresentationLogic?
    init(presenter: LocationTrackerPresentationLogic) {
        self.presenter = presenter
    }
    
    //MARK: - store data in DB
    func saveDataInCloud(userLocationData: UserLocationData) {
        LTAPIServices.saveData(userLocationData: userLocationData) { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                // its just 200 success response, no use of response body.
                self.presenter?.updateUserLocationData(uploadCount: userLocationData.updatedCount,
                                                       time: userLocationData.time.convertToString())
            } else {
                self.presenter?.genericErrorScreen()
            }
        }
    }
    
    // save using core data
    func storeData(userLocationData: UserLocationData) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let userLocation = NSEntityDescription.insertNewObject(forEntityName: DataBaseKeys.locationTable, into: context)
        userLocation.setValue(userLocationData.latitude, forKey: DataBaseKeys.latitudeKey)
        userLocation.setValue(userLocationData.longitude, forKey: DataBaseKeys.longitudeKey)
        
        let date = userLocationData.time.convertToString()
        userLocation.setValue(date, forKey: DataBaseKeys.time)
        
        do{
            try context.save()
            presenter?.updateUserLocationData(uploadCount: userLocationData.updatedCount, time: date)
        } catch {
            presenter?.genericErrorScreen()
        }
        
    }
}
