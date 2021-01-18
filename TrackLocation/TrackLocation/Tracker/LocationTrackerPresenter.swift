import UIKit

class LocationTrackerPresenter: LocationTrackerPresenterLogic {
    weak var viewController: LocationTrackerDisplayLogic?
    
    // MARK: - to show upload count and time data
    func updateUserLocationData(uploadCount: Int, time: String) {
        viewController?.showDataToUser(uploadCount: uploadCount, time: time)
    }
    
    //MARK: - to handle error during upload of data
    func genericErrorScreen() {
        viewController?.genericErrorMessage()
    }
}
