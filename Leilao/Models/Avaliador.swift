//
//  Avaliador.swift
//  Leilao
//
//  Created by Alura Laranja on 04/05/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import Foundation
enum ErroAvaliador: Error {
    case LeilaoSemLance(String)
}
class Avaliador {
    
    private var maiorDeTodos = Double.leastNonzeroMagnitude
    private var menorDeTodos = Double.greatestFiniteMagnitude
    private var maioreslances:[Lance] = []
    func avalia(leilao:Leilao) throws{
        guard let lances = leilao.lances else { return }
        if lances.count == 0{
            throw ErroAvaliador.LeilaoSemLance("Não é possível avaliar leilões sem lances")
        }
        for lance in lances {
            if lance.valor > maiorDeTodos {
                maiorDeTodos = lance.valor
            }
            if lance.valor < menorDeTodos {
                menorDeTodos = lance.valor
            }
        }
        pegaTresMaioresLances(leilao)
    }
    
    func maiorLance() -> Double {
        return maiorDeTodos
    }
    
    func menorLance() -> Double {
        return menorDeTodos
    }
    func maioresTresLances() -> [Lance] {
        return maioreslances
    }
    
    func pegaTresMaioresLances(_ leilao: Leilao){
        guard var lances = leilao.lances else {
            return
        }
        lances.sort(by: { (lance1, lance2) -> Bool in
            return lance1.valor > lance2.valor
        })
        
        let maiores = lances.prefix(3)
        maioreslances = Array(maiores)
    }
    
}
