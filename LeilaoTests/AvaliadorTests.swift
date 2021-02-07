//
//  AvaliadorTests.swift
//  LeilaoTests
//
//  Created by Vinicius SosseiSakugawa on 07/02/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import XCTest
@testable import Leilao
class AvaliadorTests: XCTestCase {

    private var joao: Usuario!
    private var maria: Usuario!
    private var jose: Usuario!
    
    private var leiloeiro: Avaliador!
    override func setUp() {
        super.setUp()
        joao = Usuario(nome: "Joao")
        jose = Usuario(nome: "Jose")
        maria = Usuario(nome: "Maria")
        
        leiloeiro = Avaliador()
    }
    func testDeveEntenderLancesEmOrdemCrescent(){
        // Cenario
        
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4")
            .lance(maria, 250.0)
            .lance(joao, 300.0)
            .lance(jose, 400.0)
            .constroi()
        
        // Acao
        
        try? leiloeiro.avalia(leilao: leilao)
        
        // Validacao
        XCTAssertEqual(250.0, leiloeiro.menorLance())
        XCTAssertEqual(400.0, leiloeiro.maiorLance())
    }

    func testDeveEntenderLeilaoComValorUnico(){

        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4")
            .lance(maria, 1000.0)
            .constroi()
                
        try? leiloeiro.avalia(leilao: leilao)
        
        XCTAssertEqual(1000.0, leiloeiro.maiorLance())
        XCTAssertEqual(1000.0, leiloeiro.menorLance())
    }
    func testDeveEntenderMaioresTresLances(){
        // Cenario
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4")
            .lance(maria, 250.0)
            .lance(joao, 300.0)
            .lance(jose, 400.0)
            .lance(maria, 500.0)
            .lance(joao, 450.0)
            .lance(jose, 600.0)
            .constroi()
        
        // Acao
        
        try? leiloeiro.avalia(leilao: leilao)
        
        XCTAssertEqual(3, leiloeiro.maioresTresLances().count)
        
        XCTAssertEqual(600.0, leiloeiro.maioresTresLances()[0].valor)
        XCTAssertEqual(500.0, leiloeiro.maioresTresLances()[1].valor)
        XCTAssertEqual(450.0, leiloeiro.maioresTresLances()[2].valor)
        
    }
    func testDeveIgnorarLeilaoSemNenhumLnace(){
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4").constroi()
        
        XCTAssertThrowsError(try leiloeiro.avalia(leilao: leilao), "Não é possível avaliar leilão sem lances") { (error) in
            print(error.localizedDescription)
        }
    }
}
