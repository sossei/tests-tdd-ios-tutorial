//
//  LeilaoTests.swift
//  LeilaoTests
//
//  Created by Ândriu Coelho on 27/04/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class LeilaoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    func testDeveReceberUmLnace(){
        let leilao = Leilao(descricao: "Macbook Pro")
        let steveJobs = Usuario(nome: "Steve Jobs")
        XCTAssertEqual(0, leilao.lances?.count)
        leilao.propoe(lance: Lance(steveJobs,4000.0))
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(4000.0, leilao.lances?.first?.valor)
    }
    func testeDeveReceberVaiorsLances(){
        let leilao = Leilao(descricao: "Macbook Pro")
        let steveJobs = Usuario(nome: "Steve Jobs")
        let billGates = Usuario(nome: "Bill Gates")
        XCTAssertEqual(0, leilao.lances?.count)
        leilao.propoe(lance: Lance(steveJobs,5500.0))
        leilao.propoe(lance: Lance(billGates,4500.0))
        XCTAssertEqual(2, leilao.lances?.count)
        XCTAssertEqual(5500.0,leilao.lances?[0].valor)
        XCTAssertEqual(4500.0,leilao.lances?[1].valor)
    }
    func testDeveIgnorarDoisLancesSeguidosMesmoUsuario(){
        let leilao = Leilao(descricao: "Macbook Pro")
        let steveJobs = Usuario(nome: "Steve Jobs")
        XCTAssertEqual(0, leilao.lances?.count)
        leilao.propoe(lance: Lance(steveJobs,4500.0))
        leilao.propoe(lance: Lance(steveJobs,5500.0))
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(4500.0,leilao.lances?.first?.valor)
        
    }
    func testDeveIgnorarMaisDoQue5LancesDoMesmoUsuario(){
        let leilao = Leilao(descricao: "Macbook Pro")
        let steveJobs = Usuario(nome: "Steve Jobs")
        let billGates = Usuario(nome: "Bill Gates")
        leilao.propoe(lance: Lance(steveJobs,2000.0))
        leilao.propoe(lance: Lance(billGates,3000.0))
        
        leilao.propoe(lance: Lance(steveJobs,4000.0))
        leilao.propoe(lance: Lance(billGates,5000.0))
        
        leilao.propoe(lance: Lance(steveJobs,6000.0))
        leilao.propoe(lance: Lance(billGates,7000.0))
        
        leilao.propoe(lance: Lance(steveJobs,8000.0))
        leilao.propoe(lance: Lance(billGates,9000.0))
        
        leilao.propoe(lance: Lance(steveJobs,10000.0))
        
        // ultimo valor a ser considerado:
        leilao.propoe(lance: Lance(billGates,11000.0))
        
        // deve ignorar:
        leilao.propoe(lance: Lance(steveJobs,12000.0))
        
        XCTAssertEqual(10, leilao.lances?.count)
        XCTAssertEqual(11000.0, leilao.lances?.last?.valor)
    }
}
