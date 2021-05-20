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
    var authRequestFactory: AuthRequestFactory!
    var userRequestFactory: UserDataRequestFactory!
    var productsRequestFactory: ProductsDataRequestFactory!
    var reviewsRequestFactory: ReviewsDataRequestFactory!
    var basketRequestFactory: BasketDataRequestFactory!
    
    override func setUpWithError() throws {
        authRequestFactory = requestFactory.makeAuthRequestFactory()
        userRequestFactory = requestFactory.makeUserDataRequestFactory()
        productsRequestFactory = requestFactory.makeProductsDataRequestFactory()
        reviewsRequestFactory = requestFactory.makeReviewsDataRequestFactory()
        basketRequestFactory = requestFactory.makeBasketDataRequestFactory()
    }

    override func tearDownWithError() throws {
        authRequestFactory = nil
        userRequestFactory = nil
        productsRequestFactory = nil
        reviewsRequestFactory = nil
        basketRequestFactory = nil
    }
    
    func testLoginShouldDownloadAndParse() {
        authRequestFactory.login(userName: "Somebody", password: "mypassword") { response in
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
        authRequestFactory.logout(idUser: 123) { response in
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
        userRequestFactory.registration (idUser: 123,
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
        userRequestFactory.changeUserData (idUser: 123,
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
        productsRequestFactory.downloadCatalogData(pageNumber: 1, idCategory: 1) { (response) in
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
        productsRequestFactory.downloadGoodById(idProduct: 123) { (response) in
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
        reviewsRequestFactory.addReview(idUser: 123, text: "Текст отзыва") { (response) in
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
        reviewsRequestFactory.removeReview(idComment: 1234) { (response) in
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
        reviewsRequestFactory.catalogReviews(idProduct: 12, pageNumber: 1) { (response) in
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
    
    func testAddToBasketShouldDownloadAndParse(){
        basketRequestFactory.addToBasket(idProduct: 12, quantity: 21) { (response) in
            switch response.result {
            case .success(let addToBasket):
                print (addToBasket)
            case .failure(let error):
                print (error.localizedDescription)
                XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDeleteFromBasketShouldDownloadAndParse(){
        basketRequestFactory.deleteFromBasket(idProduct: 12) { (response) in
            switch response.result {
            case .success(let deleteFromBasket):
                print (deleteFromBasket)
            case .failure(let error):
                print (error.localizedDescription)
                XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPayBasketShouldDownloadAndParse(){
        basketRequestFactory.payBasket(idUser: 54) { (response) in
            switch response.result {
            case .success(let payBasket):
                print (payBasket)
            case .failure(let error):
                print (error.localizedDescription)
                XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetBasketShouldDownloadAndParse(){
        basketRequestFactory.getBasket(idUser: 78) { (response) in
            switch response.result {
            case .success(let getBasket):
                print (getBasket)
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
