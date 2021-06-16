//
//  LocationTrackerConfiguratorTest.swift
//  TrackLocationTests
//
//  Created by Local User on 02/04/21.
//
/*
 NOTE:-
  When we add @testable attribute to an import statement for module complied with testing enabled, we activate elevated access for that module in that scope. Classes and class members marked as public behave as if they were marked open. Other entities marked as internal act as if they were declared public.
 
 @testable provides access only for internal functions; fileprivate and private declarations are not visible outside of their usual scope when using testable.
 */
@testable import TrackLocation
import XCTest
class LocationTrackerConfiguratorTest: XCTestCase {
    func testCreateViewController() {
        let controller = LocationTrackerConfigurator.createViewController()
        XCTAssertNotNil(controller)
        
        guard let interactor = controller.interactor as? LocationTrackerInteractor else {
            XCTFail("interactor not present")
            return
        }
        
        guard let router = controller.router as? LocationTrackerRouter else {
                 XCTFail("router not present")
                 return
             }
        
        guard let presenter = interactor.presenter as? LocationTrackerPresenter else {
                       XCTFail("presenter not present")
                       return
                   }
        
        guard let presenterViewController = presenter.viewController as? LocationTrackerViewController, router.viewController == presenterViewController else {
            XCTFail()
            return
        }
    }
}
