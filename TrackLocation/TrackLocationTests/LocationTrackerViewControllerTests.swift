//
//  TrackLocationTests.swift
//  TrackLocationTests
//
//  Created by Drishti Sharma on 18/01/21.
//

import XCTest
@testable import TrackLocation

class LocationTrackerViewControllerTests: XCTestCase {
    //MARK: - Subject under test
    var viewController: LocationTrackerViewController!
    var window: UIWindow!
    var userLocationDataMock: UserLocationData!
    
    //MARK: - Test case setup
    override func setUp() {
         super.setUp()
        window = UIWindow()
        setupViewController()
    }
    
    //MARK: - to return nil to objects after use
    override func tearDown() {
        super.tearDown()
        window = nil
        viewController = nil
    }
    
    //MARK: - to set values
    func setupViewController() {
        viewController = LocationTrackerConfigurator.createViewController() as! LocationTrackerViewController    
        userLocationDataMock = UserLocationData(latitude: 3545.00, longitude: 8383.00, updatedCount: 6, time: Date())
    }
    
    func loadView() {
    window.addSubview(viewController.view)
    }
    
    class LocationTrackerBusinessLogicMock: LocationTrackerBusinessLogic {
        var saveDataInCloudCalled = false
        var storeDataCalled = false
        
        func saveDataInCloud(userLocationData: UserLocationData) {
            saveDataInCloudCalled = true
        }
        
         func storeData(userLocationData: UserLocationData)  {
            storeDataCalled = true
         }
        
        //Mark: - tests
        func testSaveToCloud() {
            let mock = LocationTrackerBusinessLogicMock()
            viewController.interactor = mock
            loadView()
            viewController.interactor?.saveDataInCloud(userLocationData: userLocationDataMock)
            XCAssertTrue(mock.saveDataInCloudCalled)
        }
        
          func testStoreData() {
            let mock = LocationTrackerBusinessLogicMock()
            viewController.interactor = mock
            loadView()
            viewController.interactor?.storeData(userLocationData: userLocationDataMock)
            XCAssertTrue(mock.storeDataCalled)
        }
    }
}
