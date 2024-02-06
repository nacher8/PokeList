//
//  PokeListTests.swift
//  PokeListTests
//
//  Created by IGNACIO HERNAIZ IZQUIERDO on 6/2/24.
//

import XCTest
import SwiftUI
@testable import PokeList

class PokeListTests: XCTestCase {

    var viewModel: PokeViewModel!
    var network: PokeMockNetwork!
    
    // MARK: - Setup
    override func setUpWithError() throws {
        network = PokeMockNetwork(networkResponse: .success(nil))
        viewModel = PokeViewModel(network: network)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Test methods
    // MARK: - GET POKEMON
    func testGetPokemon() {
        let mockData = [PokemonData(name: "Pikachu", url: "https://test.pikachu.com"),
                        PokemonData(name: "Charmander", url: "https://test.charmander.com"),
                        PokemonData(name: "Eeve", url: "https://test.evee.com")]
        
        network = PokeMockNetwork(networkResponse: .success(mockData))
        viewModel = PokeViewModel(network: network)
        
        let expectation = XCTestExpectation(description: "Completion handler called")
        
        viewModel.getPokeData()
        
        XCTAssertEqual(viewModel.pokeList, mockData)
        expectation.fulfill()
    }

    // MARK: - GET POKEMON FAILURE
    func testGetPokemonFailure() {
        let mockError = MockError("Error get Pokemon")
        
        network = PokeMockNetwork(networkResponse: .failure(mockError))
        viewModel = PokeViewModel(network: network)
        
        
        let expectation = XCTestExpectation(description: "Completion handler called")
        
        viewModel.getPokeData()
        
        XCTAssertEqual(viewModel.pokeList, [])
        expectation.fulfill()
    }
    
    func testGetInfo() {
        let mockData = PokemonInfo(id: 1, name: "bulbasaur", height: 7, weight: 20)
        
        network = PokeMockNetwork(networkResponse: .success(mockData))
        viewModel = PokeViewModel(network: network)
        
        let expectation = XCTestExpectation(description: "Completion handler called")
        
        viewModel.getPokeInfo(url: "https://pokeapi.co/api/v2/pokemon/1/")
        
        waitForClosure(waitingTime: 1)
        
        XCTAssertEqual(viewModel.pokeInfo, mockData)
        expectation.fulfill()
    }
    
    func testGetInfoFailure() {
        let mockError = MockError("Error get Info Pokemon")
        
        network = PokeMockNetwork(networkResponse: .failure(mockError))
        viewModel = PokeViewModel(network: network)
        
        
        let expectation = XCTestExpectation(description: "Completion handler called")
        
        viewModel.getPokeInfo(url: "https://pokeapi.co/api/v2/pokemon/1/")
        
        waitForClosure(waitingTime: 1)
        
        XCTAssertEqual(viewModel.pokeInfo, nil)
        expectation.fulfill()
    }
}

extension XCTestCase {
    func waitForClosure(waitingTime: Double = 0.1) {
        let delayExpectation = XCTestExpectation()
        delayExpectation.isInverted = true
        wait(for: [delayExpectation], timeout: waitingTime)
    }
}
