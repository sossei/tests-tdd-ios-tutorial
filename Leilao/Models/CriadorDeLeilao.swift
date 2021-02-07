//
//  CriadorDeLeialo.swift
//  Leilao
//
//  Created by Vinicius SosseiSakugawa on 07/02/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import Foundation
class CriadorDeLeilao {
    private var leilao: Leilao!
    func para(descricao: String) -> CriadorDeLeilao{
        leilao = Leilao(descricao: descricao)
        return self
    }
    func lance(_ usuario: Usuario, _ valor: Double) -> CriadorDeLeilao{
        leilao.propoe(lance: Lance(usuario,valor))
        return self
    }
    func constroi() -> Leilao {
        return leilao
    }
}
