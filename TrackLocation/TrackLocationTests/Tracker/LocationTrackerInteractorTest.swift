//
//  LocationTrackerInteractorTest.swift
//  TrackLocationTests
//
//  Created by Local User on 02/04/21.
//

@testable import TrackLocation
import XCTest

class LocationTrackerInteractorTest: XCTestCase {
    var interactor: LocationTrackerInteractor!
    var presenter: MockLocationTrackerPresenter!
    var userLocation: UserLocationData!
    
    override func setUp() {
        super.setUp()
        setupInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
        presenter = nil
        userLocation = nil
    }
    func setupInteractor() {
        presenter = MockLocationTrackerPresenter()
        interactor = LocationTrackerInteractor(presenter: presenter)
        userLocation = UserLocationData(latitude: 1.00,
                                        longitude: 1.00,
                                        updatedCount: 1,
                                        time: Date())
    }
    
    // TODO: - mock coreData or API store data
    func testSaveDataInCloud() {
        interactor.storeData(userLocationData: userLocation)
        XCTAssertTrue(presenter.updateUserLocationDataCalled)
    }
}
