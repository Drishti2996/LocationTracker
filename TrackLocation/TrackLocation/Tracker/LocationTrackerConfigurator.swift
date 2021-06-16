import UIKit

struct LocationTrackerConfigurator {
    // create Location Tracker view controller
    static func createViewController() -> LocationTrackerViewController {
        let viewController = LocationTrackerViewController()
        let presenter = LocationTrackerPresenter()
        let interactor = LocationTrackerInteractor(presenter: presenter)
        let router = LocationTrackerRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
