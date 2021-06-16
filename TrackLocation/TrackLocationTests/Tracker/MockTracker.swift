//
//  MockTracker.swift
//  TrackLocationTests
//
//  Created by Local User on 02/04/21.
//
@testable import TrackLocation

class MockLocationTrackerPresenter: LocationTrackerPresentationLogic {
    var updateUserLocationDataCalled = false
    var genericErrorScreenCalled = false
    
    func updateUserLocationData(uploadCount: Int, time: String) {
        updateUserLocationDataCalled = true
    }
    
    func genericErrorScreen() {
        genericErrorScreenCalled = true
    }
}


class MockLocationTrackerDisplayLogic: LocationTrackerDisplayLogic {
    var showDataToUserCalled = false
    var showGenericerrorMessageCalled = false
    
    func showDataToUser(uploadCount: Int, time: String) {
        showDataToUserCalled = true
    }
    
    func genericErrorMessage() {
        showGenericerrorMessageCalled = true
    } 
}
