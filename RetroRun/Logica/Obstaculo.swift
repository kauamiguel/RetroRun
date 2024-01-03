//
//  Obstaculo.swift
//  Mini01
//
//  Created by Gabriel Eduardo on 13/07/23.
//

import SpriteKit

class ObstaculoColidivel : SKNode {
    let obstaculoColidivel: SKSpriteNode!
    
    // Categorias, Colisões e Contatos do Obstáculo Colidível
    let categoriasObstaculoColidivel = CollisionMask.redBlockMask
    let colisoesObstaculoColidivel = CollisionMask.semColisao
    let contatosObstaculoColidivel = CollisionMask.characterMask
    
    
    override init() {
        obstaculoColidivel = SKSpriteNode(imageNamed: "Colidiveis")
        
        obstaculoColidivel.name = "Obstaculo Colidivel"
        
        // Configurações de física
        obstaculoColidivel.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: obstaculoColidivel.size.width, height: obstaculoColidivel.size.height))
        obstaculoColidivel.physicsBody?.affectedByGravity = false
        obstaculoColidivel.physicsBody?.isDynamic = false
        
        // Configurações de contato
        obstaculoColidivel.physicsBody?.categoryBitMask = categoriasObstaculoColidivel
        obstaculoColidivel.physicsBody?.collisionBitMask = colisoesObstaculoColidivel
        obstaculoColidivel.physicsBody?.contactTestBitMask = contatosObstaculoColidivel
        
        super.init()
        
        addChild(obstaculoColidivel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ObstaculoNaoColidivel : SKNode {
    let obstaculoNaoColidivel: SKSpriteNode!
    
    // Categorias, Colisões e Contatos do Obstáculo Não Colidível
    let categoriasObstaculoNaoColidivel = CollisionMask.greenBlockMask
    let colisoesObstaculoNaoColidivel = CollisionMask.semColisao
    let contatosObstaculoNaoColidivel = CollisionMask.characterMask
    
    
    override init() {
        obstaculoNaoColidivel = SKSpriteNode(imageNamed: "NaoColidiveis")
        
        obstaculoNaoColidivel.name = "Obstaculo Nao Colidivel"
        
        // Configurações de física
        obstaculoNaoColidivel.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: obstaculoNaoColidivel.size.width, height: obstaculoNaoColidivel.size.height))
        obstaculoNaoColidivel.physicsBody?.affectedByGravity = false
        obstaculoNaoColidivel.physicsBody?.isDynamic = false
        
        // Configurações de contato
        obstaculoNaoColidivel.physicsBody?.categoryBitMask = categoriasObstaculoNaoColidivel
        obstaculoNaoColidivel.physicsBody?.collisionBitMask = colisoesObstaculoNaoColidivel
        obstaculoNaoColidivel.physicsBody?.contactTestBitMask = contatosObstaculoNaoColidivel
        
        super.init()
        
        addChild(obstaculoNaoColidivel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// A classe Obstaculo é a junção dos Obstaculos Colidíveis e Obstaculos Não Colidíveis
class Obstaculo: SKNode {
    
    let obstaculoColidivel = ObstaculoColidivel()
    let obstaculoNaoColidivel = ObstaculoNaoColidivel()
    let alturaMinima: CGFloat = 73
    let alturaMaxima: CGFloat = 110
    
    let detectorSeguro: SKShapeNode!
    let detectorReset: SKShapeNode!
    
    var fator: CGFloat = 1
    
    override init() {
        
        // Posicionamento das peças do obstáculo
        obstaculoColidivel.position = CGPoint(x: 0, y: obstaculoColidivel.obstaculoColidivel.size.height / 2)
        obstaculoNaoColidivel.position = CGPoint(x: 0, y: -obstaculoNaoColidivel.obstaculoNaoColidivel.size.height / 2 - 1)
        
        // Configurações do Detector Seguro
        detectorSeguro = SKShapeNode(rectOf: CGSize(width: obstaculoColidivel.obstaculoColidivel.size.width, height: obstaculoNaoColidivel.obstaculoNaoColidivel.size.height * 3))
        detectorSeguro.position = CGPoint(x: -obstaculoColidivel.obstaculoColidivel.size.width * 3, y: obstaculoNaoColidivel.obstaculoNaoColidivel.size.height / 2)
        detectorSeguro.alpha = 0
        
        detectorSeguro.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: obstaculoColidivel.obstaculoColidivel.size.width, height: obstaculoNaoColidivel.obstaculoNaoColidivel.size.height * 3))
        detectorSeguro.physicsBody?.isDynamic = false
        detectorSeguro.physicsBody?.affectedByGravity = false
        
        detectorSeguro.physicsBody?.categoryBitMask = CollisionMask.detectorSeguro
        detectorSeguro.physicsBody?.collisionBitMask = CollisionMask.semColisao
        detectorSeguro.physicsBody?.contactTestBitMask = CollisionMask.characterMask
        
        // Configurações do Detector Reset
        detectorReset = SKShapeNode(rectOf: CGSize(width: obstaculoColidivel.obstaculoColidivel.size.width, height: obstaculoNaoColidivel.obstaculoNaoColidivel.size.height * 3))
        detectorReset.position = CGPoint(x: 0, y: obstaculoNaoColidivel.obstaculoNaoColidivel.size.height / 2)
        detectorReset.alpha = 0
        
        detectorReset.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: obstaculoColidivel.obstaculoColidivel.size.width, height: obstaculoNaoColidivel.obstaculoNaoColidivel.size.height * 3))
        detectorReset.physicsBody?.isDynamic = false
        detectorReset.physicsBody?.affectedByGravity = false
        
        detectorReset.physicsBody?.categoryBitMask = CollisionMask.detectorReset
        detectorReset.physicsBody?.collisionBitMask = CollisionMask.semColisao
        detectorReset.physicsBody?.contactTestBitMask = CollisionMask.characterMask
        
        super.init()
        
        self.zPosition = 3
        
        addChild(detectorSeguro)
        addChild(detectorReset)
        self.addChild(obstaculoColidivel)
        self.addChild(obstaculoNaoColidivel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension Obstaculo {
    // Fator: Se o obstáculo estiver de cabeça para baixo, o fator será igual a -1. Senão, o fator será igual a 1. Isso ajuda no cálculo do posicionamento do obstáculo nas funções de subir e descer
    
    // Função para fazer o obstáculo subir
    func subir(fator: CGFloat) -> SKAction {
        let subirObstaculo = SKAction.moveTo(y: (alturaMaxima - obstaculoColidivel.obstaculoColidivel.size.height / 2) * fator, duration: 0.3)
        return subirObstaculo
    }
    
    // Função para fazer o obstáculo descer
    func descer(fator: CGFloat) -> SKAction{
        let descerObstaculo = SKAction.moveTo(y: (alturaMinima - obstaculoColidivel.obstaculoColidivel.size.height / 2) * fator, duration: 0.3)
        return descerObstaculo
    }
    
    // Função que une as funções de subir e descer.
    func sobeDesce(fator: CGFloat) {
        let minimo = Int.random(in:0...1)
        self.run(.repeatForever(.sequence([minimo != 0 ? subir(fator: fator) : descer(fator: fator), .wait(forDuration: Double.random(in: 1.5...3)), minimo != 0 ? descer(fator: fator) : subir(fator: fator), .wait(forDuration: Double.random(in: 1.5...3))])))
    }
    
    // Preciso fazer uma função para resetar as ações e modularizar o código
    func ultimaAcao() {
        self.removeAllActions()
        let subirOuDescer = Int.random(in: 0...1) // 0 para descer, 1 para subir
        subirOuDescer == 0 ? self.run(self.descer(fator: self.fator)) : self.run(self.subir(fator: self.fator))
    }
    
    func resetarAcoes() {
        self.removeAllActions()
        sobeDesce(fator: self.fator)
    }
}




// FUNÇÃO PARA POW CADA VEZ QUE BATER NO OBSTÁCULO

func animacaoPow(naPosicao: CGPoint, emCena: SKScene) {
        
        // Cria o nó de sprite para a animação de "pow"
        let pow = SKSpriteNode(imageNamed: "pow")
        emCena.addChild(pow)
        pow.zPosition = 10
        
        // Define a posição do "pow" como a posição do obstáculo de contato
        let posicaoObstaculo = naPosicao
        pow.position = posicaoObstaculo
        
        // Faz a animação de zoom IN e zoom OUT para o "pow"
        let acaoDeAumentar = SKAction.scale(by: 1.3, duration: 0.2)
        let acaoDeDiminuir = SKAction.scale(by: 0.0, duration: 0.2)
        let sequencia = SKAction.sequence([acaoDeAumentar, acaoDeDiminuir])
        
        // Executa a sequência de animação e remove o nó "pow" após a conclusão
        pow.run(sequencia) {
            pow.removeFromParent()
        }
    }
