//
//  LocationTrackerPresenterTest.swift
//  TrackLocationTests
//
//  Created by Local User on 02/04/21.
//

@testable import TrackLocation
import XCTest

class LocationTrackerPresenterTest: XCTestCase {
    var presenter: LocationTrackerPresenter!
    var mockDisplay: MockLocationTrackerDisplayLogic!
    
    override func setUp() {
        super.setUp()
        presenter = LocationTrackerPresenter()
        mockDisplay = MockLocationTrackerDisplayLogic()
        presenter.viewController = mockDisplay
    }
    
    override func tearDown() {
        super.tearDown()
        presenter = nil
        mockDisplay = nil
    }
    
    func testUpdateUserdata() {
        presenter.updateUserLocationData(uploadCount: 1,
                                         time: "")
        XCTAssertTrue(mockDisplay.showDataToUserCalled)
    }
    
    func testErrroScreen() {
           
        presenter.genericErrorScreen()
        XCTAssertTrue(mockDisplay.showGenericerrorMessageCalled)
    }
}
