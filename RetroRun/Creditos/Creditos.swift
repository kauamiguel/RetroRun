//
//  Creditos.swift
//  Mini01
//
//  Created by Kaua Miguel on 28/07/23.
//

import SpriteKit


class Creditos : SKScene{
    
    var boardCamera = SKCameraNode()
    var backGroundCima = SKSpriteNode()
    var creditos = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.addChild(boardCamera)
        self.camera = boardCamera
        
        backGroundCima = childNode(withName: "bg1") as! SKSpriteNode
        creditos = childNode(withName: "Creditos") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let toque = touches.first{
            
            //Salva as coordenadas do toque (location)
            let localizacao = toque.location(in: self)
            
            //Nodes(at: ) retorna um array de nodes na região tocada
            let noTocado = self.nodes(at: localizacao)
            
            //Itera sobre cada node na região tocada e verifica qual tem o nome de "Fita"
            for node in noTocado.reversed(){
                if node.name == "botaoFechar"{
                    EfeitoSonoro.tocarSomTap01(self)
                    let transition = SKTransition.fade(withDuration: 2.0)
                    //self.view?.presentScene(SKScene(fileNamed: "TelaInicial")!, transition: transition)
                    if let view = self.view, let scene = TelaInicial(fileNamed: "TelaInicial") {
                        scene.scaleMode = .aspectFill
                        view.presentScene(scene, transition: transition)
                    }
                }
            }
        }
    }
}
