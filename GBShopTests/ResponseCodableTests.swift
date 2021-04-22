//
//  ResponseCodableTests.swift
//  GBShopTests
//
//  Created by Alexandr Evtodiy on 15.04.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ResponseCodableTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download")
    
    let requestFactory = RequestFactory()
    var auth: AuthRequestFactory!
    var userData: UserDataRequestFactory!
    var productsData: ProductsDataRequestFactory!
    var reviewsData: ReviewsDataRequestFactory!
    
    override func setUpWithError() throws {
        auth = requestFactory.makeAuthRequestFactory()
        userData = requestFactory.makeUserDataRequestFactory()
        productsData = requestFactory.makeProductsDataRequestFactory()
        reviewsData = requestFactory.makeReviewsDataRequestFactory()
    }

    override func tearDownWithError() throws {
        auth = nil
        userData = nil
        productsData = nil
        reviewsData = nil
    }
    
    func testLoginShouldDownloadAndParse() {
        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLogoutShouldDownloadAndParse() {
        auth.logout(idUser: 123) { response in
            switch response.result {
            case .success(let logout):
                print (logout)
            case .failure(let error):
                print (error.localizedDescription)
                XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRegistrationShouldDownloadAndParse() {
        userData.registration (idUser: 123,
                            username: "Somebody",
                            password: "mypassword",
                            email: "some@some.ru",
                            gender: "m",
                            creditCard: "9872389-2424-234224-234",
                            bio: "This is good! I think I will switch to another language") { response in
            switch response.result {
            case .success(let registration):
                print (registration)
            case .failure(let error):
                print (error.localizedDescription)
                XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testChangeUserDataShouldDownloadAndParse() {
        userData.changeUserData (idUser: 123,
                            username: "Somebody",
                            password: "mypassword",
                            email: "some@some.ru",
                            gender: "m",
                            creditCard: "9872389-2424-234224-234",
                            bio: "This is good! I think I will switch to another language") { response in
            switch response.result {
            case .success(let changeUser):
                print (changeUser)
            case .failure(let error):
                print (error.localizedDescription)
                XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDownCatalogDataShouldDownloadAndParse() {
        productsData.downloadCatalogData(pageNumber: 1, idCategory: 1) { (response) in
            switch response.result {
            case .success(let productsData):
                print (productsData)
            case .failure(let error):
                print (error.localizedDescription)
                XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDownGoodByIdShouldDownloadAndParse() {
        productsData.downloadGoodById(idProduct: 123) { (response) in
            switch response.result {
            case .success(let goodById):
                print (goodById)
            case .failure(let error):
                print (error.localizedDescription)
                XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testAddReviewShouldDownloadAndParse() {
        reviewsData.addReview(idUser: 123, text: "Текст отзыва") { (response) in
            switch response.result {
            case .success(let addReview):
                print (addReview)
            case .failure(let error):
                print (error.localizedDescription)
                XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRemoveReviewShouldDownloadAndParse(){
        reviewsData.removeReview(idComment: 1234) { (response) in
            switch response.result {
            case .success(let removeReview):
                print (removeReview)
            case .failure(let error):
                print (error.localizedDescription)
                XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCatalogReviewsShouldDownloadAndParse(){
        reviewsData.catalogReviews(idProduct: 12, pageNumber: 1) { (response) in
            switch response.result {
            case .success(let catalogReviews):
                print (catalogReviews)
            case .failure(let error):
                print (error.localizedDescription)
                XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
