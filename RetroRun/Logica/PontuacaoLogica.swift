//
//  PontuacaoLogica.swift
//  Mini01
//
//  Created by Kaua Miguel on 13/07/23.
//

import SpriteKit

class PontuacaoLogica {
    var pontuacao:Int = 0
    private var recorde:Int = UserDefaults.standard.integer(forKey: "Recorde")
    
    var numVoltas:Int = 0
    private var recordeNumeroVoltas:Int = UserDefaults.standard.integer(forKey: "RecordeNumeroVoltas")
   
    //Funcao para adicionar uma volta ao completá-la
    func addVolta(){
        self.numVoltas+=1
        
        self.verificarNumeroVoltas()
    }
    
    //Funcao para adicionar a pontuação no jogo baseada na logica do pulo
    func addPontuacaoPorPulo(){
        self.pontuacao += 2
        
        self.verificarPontuacao()
    }
    
    //Funcao para adicionar a pontuacao quando der uma volta
    func addPontuacaoVoltas(){
        self.pontuacao += 5
        
        self.verificarPontuacao()
    }

    //Adicionar pontuação baseado em cada segundo que usuário sobrevive no jogo
    func addPontuacaoPorTempo(ultimaAtualizacaoSegundos : inout Int){
        let dataAtual = Date()
        let calendario = Calendar.current
        let segundos = calendario.component(.second, from: dataAtual)
        

        if segundos != ultimaAtualizacaoSegundos{
            ultimaAtualizacaoSegundos = segundos
            self.pontuacao += 1
        }
        
        self.verificarPontuacao()
        
    }
    
    
    //Função que será chamada quando o usuário bater em um obstáculo para verificar seu recorde.
    private func verificarPontuacao(){
        if self.pontuacao > self.recorde{
            UserDefaults.standard.set(self.pontuacao, forKey: "Recorde")
        }
    }
    
    //Função para ver se bateu o recorde de número de voltas
    private func verificarNumeroVoltas(){
        if self.numVoltas > self.recordeNumeroVoltas {
            UserDefaults.standard.set(self.numVoltas, forKey: "RecordeNumeroVoltas")
        }
    }
    
    // Função para fazer um fetch no recorde e mostrar para o usuário a sua pontuação máxima
    static func pegarRecorde() -> Int{
        return UserDefaults.standard.integer(forKey: "Recorde")
    }
    
    static func pegarRecordVoltas() -> Int{
        return UserDefaults.standard.integer(forKey: "RecordeNumeroVoltas")
    }
}
