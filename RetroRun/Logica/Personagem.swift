//
//  Personagem.swift
//  Mini01
//
//  Created by Gabriel Eduardo on 13/07/23.
//

import SpriteKit

class Personagem: SKNode {
    
    var personagem: SKSpriteNode!
    
    // Categorias, Colisões e Contatos do Personagem
    let categoriasPersonagem = CollisionMask.characterMask
    let colisoesPersonagem = CollisionMask.semColisao
    let contatosPersonagem = CollisionMask.plataformMask | CollisionMask.redBlockMask | CollisionMask.obstaculoFixo | CollisionMask.largada
    
    
    override init() {
        
        personagem = SKSpriteNode(imageNamed: "Personagem")
        
        personagem.name = "Personagem" // Identificação do personagem
        
        // Tamanho e posicionamento (Precisa ser alterado)
        personagem.setScale(0.8)
        
        personagem.zPosition = 4
        personagem.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // Configurações de física
        personagem.physicsBody = SKPhysicsBody(texture: personagem.texture!, size: personagem.size)
        personagem.physicsBody?.isDynamic = true
        personagem.physicsBody?.affectedByGravity = false
        personagem.position = CGPoint(x: 0, y: 0)
        
        
        
        // Configurações de contato
        personagem.physicsBody?.categoryBitMask = categoriasPersonagem
        personagem.physicsBody?.contactTestBitMask = CollisionMask.plataformMask
        personagem.physicsBody?.collisionBitMask = CollisionMask.redBlockMask
        
        personagem.name = "Personagem" // Identificação do personagem
        
        super.init()
        
        addChild(personagem)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Personagem {
    func resetarPersonagem() {
        personagem.removeAllActions()
        personagem.removeFromParent()
    }
    
    func addPersonagem(){
        self.addChild(personagem)
    }
    
    func adicionarPersonagemACena(_ naCena:SKScene){
        if personagem.parent == nil {
            naCena.addChild(personagem)
        }
    }
}
