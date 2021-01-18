import UIKit

protocol LocationTrackerBusinessLogic {
    func storeData(userLocationData: UserLocationData)
    func saveDataInCloud(userLocationData: UserLocationData)
}

protocol LocationTrackerPresenterLogic {
    func updateUserLocationData(uploadCount: Int, time: String)
    func genericErrorScreen()
}

protocol LocationTrackerDisplayLogic: class {
    func showDataToUser(uploadCount: Int, time: String)
    func genericErrorMessage()
}

protocol LocationTrackerRouterLogic {}
