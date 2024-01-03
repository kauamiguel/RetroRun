//
//  GameScene.swift
//  Mini01
//
//  Created by Kaua Miguel on 12/07/23.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    //Variaveis para pegar a referencia de Node Child da gameScene.sks
    private var plataforma = SKSpriteNode()
    private var roldana1 = SKSpriteNode()
    private var roldana2 = SKSpriteNode()
    private var roloFita01 = SKSpriteNode()
    private var roloFita02 = SKSpriteNode()
    private var record = SKLabelNode()
    private var recordBorda = SKLabelNode()
    private var tapToJumpLabel : SKSpriteNode?
    private var voltasLabel = SKLabelNode()
    private var voltasLabelBorda = SKLabelNode()
    private var largada = SKSpriteNode()
    private var botaoDePause = SKSpriteNode()
    let obstaculoPai = SKNode()
    
    
    
    var obstaculoFixo1 = SKSpriteNode()
    var obstaculoFixo2 = SKSpriteNode()
    var obstaculoFixo3 = SKSpriteNode()
    var obstaculoFixo4 = SKSpriteNode()
    var obstaculoFixo5 = SKSpriteNode()
    
    //Variaveis para a logica do programa
    let personagem = Personagem()
    let obstaculo = Obstaculo()
    var personagemPulou = false
    let pontuacao = PontuacaoLogica()
    var ultimaAtualizacaoSegundos = 0
    var numeroDeVoltasContador = PontuacaoLogica()
    var pauseMenu: PauseMenu?
    var pausado = false
    var personagemMorreu = false
    
    var houveContato = true
    
    // Variáveis para evitar detectar o mesmo contato 2 vezes
    var tempoDeteccao:Double = 0.0
    var endingTime = Date.now
    var inicioDeteccao = Date.now
    
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        if EfeitoSonoro.musicaEstaTocando {
            EfeitoSonoro.pararTrilhaSonora()
        }
        
        
        // Pegando referência dos nodes da gameScene
        plataforma = childNode(withName: "Plataforma") as! SKSpriteNode
        roldana1 = childNode(withName: "Roldana1") as! SKSpriteNode
        roldana2 = childNode(withName: "Roldana2") as! SKSpriteNode
        roloFita01 = childNode(withName: "roloFita01") as! SKSpriteNode
        roloFita02 = childNode(withName: "roloFita02") as! SKSpriteNode
        tapToJumpLabel = childNode(withName: "tapToJump") as? SKSpriteNode
        botaoDePause = childNode(withName: "menuPause") as! SKSpriteNode
        largada = childNode(withName: "largada") as! SKSpriteNode
        voltasLabelBorda = childNode(withName: "voltasBorda") as! SKLabelNode
        recordBorda = childNode(withName: "recordBorda") as! SKLabelNode
        // guardam número de VOLTAS e RECORD
        voltasLabel = childNode(withName: "voltas") as! SKLabelNode
        record = childNode(withName: "record") as! SKLabelNode
        
        
        obstaculoFixo1 = childNode(withName: "obstaculoFixo1") as! SKSpriteNode
        obstaculoFixo2 = childNode(withName: "obstaculoFixo2") as! SKSpriteNode
        obstaculoFixo3 = childNode(withName: "obstaculoFixo3") as! SKSpriteNode
        obstaculoFixo4 = childNode(withName: "obstaculoFixo4") as! SKSpriteNode
        obstaculoFixo5 = childNode(withName: "obstaculoFixo5") as! SKSpriteNode
        
        
        //Criando a ação de rotação das roldanas
        let acaoDeRotacionarRoldana1 = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 4)
        let repeticaRoldanas1 = SKAction.repeatForever(acaoDeRotacionarRoldana1).reversed()
        roldana1.run(repeticaRoldanas1)
        
        let acaoDeRotacionarRoldana2 = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 4).reversed()
        let repeticaRoldana2 = SKAction.repeatForever(acaoDeRotacionarRoldana2)
        roldana2.run(repeticaRoldana2)
        
        let repetirRotacaoRolo01 = SKAction.repeatForever(.rotate(byAngle: CGFloat.pi*2, duration: 4)).reversed()
        roloFita01.run(repetirRotacaoRolo01)
        
        let repetirRotacaoInfinitaRolo02 = SKAction.repeatForever(.rotate(byAngle: CGFloat.pi*2, duration: 4)).reversed()
        roloFita02.run(repetirRotacaoInfinitaRolo02)
        
        //Corpo fisico da plataforma
        plataforma.physicsBody = SKPhysicsBody(texture: plataforma.texture!, size: plataforma.texture!.size())
        plataforma.physicsBody?.isDynamic = false
        plataforma.physicsBody?.affectedByGravity = false
        plataforma.physicsBody?.categoryBitMask = CollisionMask.plataformMask
        plataforma.physicsBody?.contactTestBitMask = CollisionMask.characterMask
        
        //Corpo fisico do obstaculo fixo
        obstaculoFixo1.physicsBody = SKPhysicsBody(texture: obstaculoFixo1.texture!, size: obstaculoFixo1.texture!.size())
        obstaculoFixo1.physicsBody?.isDynamic = false
        obstaculoFixo1.physicsBody?.affectedByGravity = false
        obstaculoFixo1.physicsBody?.categoryBitMask = CollisionMask.obstaculoFixo
        obstaculoFixo1.physicsBody?.contactTestBitMask = CollisionMask.characterMask
        obstaculoFixo1.physicsBody?.collisionBitMask = CollisionMask.semColisao
        
        obstaculoFixo2.physicsBody = SKPhysicsBody(texture: obstaculoFixo2.texture!, size: obstaculoFixo2.texture!.size())
        obstaculoFixo2.physicsBody?.isDynamic = false
        obstaculoFixo2.physicsBody?.affectedByGravity = false
        obstaculoFixo2.physicsBody?.categoryBitMask = CollisionMask.obstaculoFixo
        obstaculoFixo2.physicsBody?.contactTestBitMask = CollisionMask.characterMask
        obstaculoFixo2.physicsBody?.collisionBitMask = CollisionMask.semColisao
        
        
        obstaculoFixo3.physicsBody = SKPhysicsBody(texture: obstaculoFixo3.texture!, size: obstaculoFixo3.texture!.size())
        obstaculoFixo3.physicsBody?.isDynamic = false
        obstaculoFixo3.physicsBody?.affectedByGravity = false
        obstaculoFixo3.physicsBody?.categoryBitMask = CollisionMask.obstaculoFixo
        obstaculoFixo3.physicsBody?.contactTestBitMask = CollisionMask.characterMask
        obstaculoFixo3.physicsBody?.collisionBitMask = CollisionMask.semColisao
        
        
        obstaculoFixo4.physicsBody = SKPhysicsBody(texture: obstaculoFixo4.texture!, size: obstaculoFixo4.texture!.size())
        obstaculoFixo4.physicsBody?.isDynamic = false
        obstaculoFixo4.physicsBody?.affectedByGravity = false
        obstaculoFixo4.physicsBody?.categoryBitMask = CollisionMask.obstaculoFixo
        obstaculoFixo4.physicsBody?.contactTestBitMask = CollisionMask.characterMask
        obstaculoFixo4.physicsBody?.collisionBitMask = CollisionMask.semColisao
        
        
        obstaculoFixo5.physicsBody = SKPhysicsBody(texture: obstaculoFixo5.texture!, size: obstaculoFixo5.texture!.size())
        obstaculoFixo5.physicsBody?.isDynamic = false
        obstaculoFixo5.physicsBody?.affectedByGravity = false
        obstaculoFixo5.physicsBody?.categoryBitMask = CollisionMask.obstaculoFixo
        obstaculoFixo5.physicsBody?.contactTestBitMask = CollisionMask.characterMask
        obstaculoFixo5.physicsBody?.collisionBitMask = CollisionMask.semColisao
        
        
        //Configurando a largada
        largada.physicsBody?.categoryBitMask = CollisionMask.largada
        largada.physicsBody?.contactTestBitMask = CollisionMask.characterMask
        largada.physicsBody?.collisionBitMask = 0
        
        //Criando a animação de piscar na label de tapToJump
        let diminuirOpacidade = SKAction.fadeAlpha(to: 0.2, duration: 1.0)
        let aumentarOpacidade = SKAction.fadeAlpha(to: 1.0, duration: 1.0)
        let acaoDePiscarTapToJump = SKAction.repeatForever(SKAction.sequence([diminuirOpacidade, aumentarOpacidade]))
        tapToJumpLabel?.run(acaoDePiscarTapToJump)
        
        pauseMenu = PauseMenu(gameLayer: self)
        addChild(pauseMenu!)
        pauseMenu?.isHidden = true
        
        // Máscara de Corte para os obstáculos não aparecerem na janela da fita
        let MascaraDeCorte = SKCropNode()
        MascaraDeCorte.maskNode = SKSpriteNode(imageNamed: "MascaraDeCorte")
        MascaraDeCorte.zPosition = 3
        
        MascaraDeCorte.addChild(obstaculoPai) // Isso quer dizer que todos os obstáculos serão submissos à Máscara de Corte
        addChild(MascaraDeCorte) // Adicionando a Máscara de Corte, também é adicionado tudo que é submisso à ela
        
        addChild(personagem)
        
        personagem.seguir(plataforma, personagem) // fazer personagem seguir o circuito
        
        posicionarObstaculos(pai: obstaculoPai) // adicionar obstáculos móveis à cena
    }
}


//Extension com funcoes nao padrões da gameScene
extension GameScene{
    
    // Função que adiciona os obstáculos individualmente
    func adicionarObstaculo(x: CGFloat, down: Bool, pai: SKNode) {
        let obstaculo = Obstaculo()
        
        if down { // Caso o obstáculo esteja na parte debaixo da plataforma
            obstaculo.zRotation = .pi
            obstaculo.fator = -1
        }
        
        // Posicionamento do obstáculo
        obstaculo.position = CGPoint(x: x, y: ((obstaculo.alturaMinima - obstaculo.obstaculoColidivel.obstaculoColidivel.size.height / 2)) * obstaculo.fator)
        
        // Definição da animação do obstáculo
        obstaculo.sobeDesce(fator: obstaculo.fator)
        
        // Definição do obstáculo
        pai.addChild(obstaculo)
    }
    
    
    // Função que adiciona todos obstáculos. Nela passamos a posição X e se o objeto está na parte debaixo da plataforma. Também é necessário passar o nó principal, o nó pai de todos os obstáculos
    func posicionarObstaculos(pai: SKNode) {
        //DE CIMA
        adicionarObstaculo(x: 0, down: false, pai: pai)
        adicionarObstaculo(x: 165, down: false, pai: pai)
        
        //DE BAIXO
        adicionarObstaculo(x: -165, down: true, pai: pai)
        adicionarObstaculo(x: 0, down: true, pai: pai)
        adicionarObstaculo(x: 165, down: true, pai: pai)
    }
}


// Extension para adicionar a logica do jogo com as funções padrões da gameScene e do mundo fisico
extension GameScene{
    
    override func update(_ currentTime: TimeInterval) {
        //Lógica para adicionar pontuação do personagem de 1 em 1
        pontuacao.addPontuacaoPorTempo(ultimaAtualizacaoSegundos: &ultimaAtualizacaoSegundos)
        self.record.text = "\(pontuacao.pontuacao)"
        self.recordBorda.text = "\(pontuacao.pontuacao)"
        
        if pausado {
            self.isPaused = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Verificando se o tapJump ja desapareceu e caso não, remover apos a oitava pontuação
        setTapToJumpLabel()
        
        for touch in touches {
            let location = touch.location(in: self)
            let nodesAtLocation = nodes(at: location)
            
            // Verificando se o personagem está no chão
            for node in nodesAtLocation {
                if node.name == "menuPause" {
                    if let pauseMenu = pauseMenu {
                        if !pausado {
                            pauseMenu.show()
                            pausado = true
                            if EfeitoSonoro.musicaEstaTocando {
                                EfeitoSonoro.musicaDeFundo?.volume = 0.1
                            }
                        }
                        // som de tap ao clicar no pause
                        EfeitoSonoro.tocarSomTap01(self)
                    }
                    
                } else  {
                    // Verificação para saber quando pode dar outro pulo
                    
                    // se não estiver pulando E se não estiver clicando no botão de pause
                    if houveContato && !botaoDePause.contains(location) {
                        pular(personagem, plataforma)
                        houveContato = false
                        
                        //Pontua o personagem e adiciona na Scene
                        pontuacao.addPontuacaoPorPulo()
                        record.text = "\(pontuacao.pontuacao)"
                        recordBorda.text = "\(pontuacao.pontuacao)"
                    }
                }
            }
        }
    }
    
    
    
    
    //Definindo o contato com os obstáculos
    func didBegin(_ contact: SKPhysicsContact) {
        
        // Código para detectar apenas 1 contato. Sem ele, o mesmo contato é detectado 2 vezes
        tempoDeteccao = Date.now.timeIntervalSince(inicioDeteccao)
        
        
        // contato do personagem com a plataforma ===================================================
        if contact.bodyA.categoryBitMask == CollisionMask.characterMask && contact.bodyB.categoryBitMask == CollisionMask.plataformMask || contact.bodyA.categoryBitMask == CollisionMask.plataformMask && contact.bodyB.categoryBitMask == CollisionMask.characterMask {
            houveContato = true // Isso significa que o personagem já pode pular
        }
        
        
        
        // Colisao com obstaculo fixo se o obstaculo for o body A
        if contact.bodyA.categoryBitMask == personagem.categoriasPersonagem && contact.bodyB.categoryBitMask == CollisionMask.redBlockMask {
            
            configureContactMobileObstacle(contact: contact, contactBody: contact.bodyB)
            
            // Colisao com obstaculo movel se o obstaculo for o body A
        } else if contact.bodyA.categoryBitMask == CollisionMask.redBlockMask && contact.bodyB.categoryBitMask == personagem.categoriasPersonagem {
            
            configureContactMobileObstacle(contact: contact, contactBody: contact.bodyA)
        }
        
        
        
        // Colisao com obstaculo fixo se o obstaculo for o body B
        if contact.bodyB.categoryBitMask == CollisionMask.obstaculoFixo && contact.bodyA.categoryBitMask == personagem.categoriasPersonagem{
            
            configureContactFixedObstacle(contact: contact, contactBody: contact.bodyB)
            
            // Colisao com obstaculo fixo se o obstaculo for o body A
        } else if contact.bodyA.categoryBitMask == CollisionMask.obstaculoFixo && contact.bodyB.categoryBitMask == personagem.categoriasPersonagem{
            
            configureContactFixedObstacle(contact: contact, contactBody: contact.bodyA)
        }
        
        
        
        //Detectar contato com a largada e assim incrementar o numero de voltas ===============================
        if contact.bodyA.categoryBitMask == CollisionMask.largada && contact.bodyB.categoryBitMask == personagem.categoriasPersonagem || contact.bodyB.categoryBitMask == CollisionMask.largada && contact.bodyA.categoryBitMask == personagem.categoriasPersonagem{
            
            countNumberOfLaps()
        }
        
        
        
        // Detecção do contato do personagem com o Detector Seguro. Quando o personagem entrar em contato com o Detector Seguro, o obstáculo vai realizar uma última ação e, então, vai ficar parado.
        if contact.bodyA.categoryBitMask == personagem.categoriasPersonagem && contact.bodyB.categoryBitMask == CollisionMask.detectorSeguro {
            // Código para detectar apenas 1 contato. Sem ele, o mesmo contato é detectado 2 vezes
            if tempoDeteccao < 0.55 { return }
            inicioDeteccao = Date.now
            
            if let obstaculo = contact.bodyB.node?.parent as? Obstaculo {
                obstaculo.ultimaAcao()
            }
            
        } else if contact.bodyA.categoryBitMask == CollisionMask.detectorSeguro && contact.bodyB.categoryBitMask == personagem.categoriasPersonagem {
            // Código para detectar apenas 1 contato. Sem ele, o mesmo contato é detectado 2 vezes
            if tempoDeteccao < 0.55 { return }
            inicioDeteccao = Date.now
            
            if let obstaculo = contact.bodyA.node?.parent as? Obstaculo {
                obstaculo.ultimaAcao()
            }
        }
    }
    
    
    func didEnd(_ contact: SKPhysicsContact) { // Quando a colisão termina
        
        // Detecção do fim do contato com o Detector Reset. Quando terminar o contato, o obstáculo vai voltar a se mexer constantemente.
        if contact.bodyA.categoryBitMask == personagem.categoriasPersonagem && contact.bodyB.categoryBitMask == CollisionMask.detectorReset {
            if let obstaculo = contact.bodyB.node?.parent as? Obstaculo {
                if !obstaculo.hasActions() {
                    obstaculo.resetarAcoes()
                }
            }
        } else if contact.bodyA.categoryBitMask == CollisionMask.detectorReset && contact.bodyB.categoryBitMask == personagem.categoriasPersonagem {
            if let obstaculo = contact.bodyA.node?.parent as? Obstaculo {
                if !obstaculo.hasActions() {
                    obstaculo.resetarAcoes()
                }
            }
        }
    }
}



//Definindo as acoes que irao acontecer dentro das funcoes padroes da gameScene (DidBegin , Update...)
extension GameScene{
    
    //Pega qual corpo teve contato e se ele é o corpo A ou B para assim realizar as ações
    func configureContactMobileObstacle(contact : SKPhysicsContact, contactBody : SKPhysicsBody){
        //Animação de batida com obstáculo móvel
        animacaoPow(naPosicao: contactBody.node!.parent!.parent!.position,
                    emCena: self)
        
        // Efeito sonoro de batida no obstáculo fixo
        if EfeitoSonoro.toggleSonsEstaLigado {
            EfeitoSonoro.tocarSomHit(volume: 0.4)
        }
        
        // Desliga a música da volta atual
        if EfeitoSonoro.toggleMusicaEstaLigado && EfeitoSonoro.musicaEstaTocando {
            EfeitoSonoro.pararTrilhaSonora()
        }
        
        
        // REINICIAR AÇÕES DO PERSONAGEM APÓS COLIDIR COM OBSTÁCULO MÓVEL
        personagem.seguir(plataforma, personagem)
        
        // Zera o numero de voltas e pontuação
        pontuacao.pontuacao = 0
        record.text = "\(pontuacao.pontuacao)"
        recordBorda.text = "\(pontuacao.pontuacao)"
        
        numeroDeVoltasContador.numVoltas = 0
        voltasLabel.text = "\(numeroDeVoltasContador.numVoltas)"
        voltasLabelBorda.text = "\(numeroDeVoltasContador.numVoltas)"
        
        
        // Reseta as ações do obstáculo
        if let obstaculo = contactBody.node?.parent as? Obstaculo {
            if !obstaculo.hasActions() {
                obstaculo.resetarAcoes()
            }
        }
    }
    
    
    
    //Pega qual corpo teve contato e se ele é o corpo A ou B para assim realizar as ações
    func configureContactFixedObstacle(contact : SKPhysicsContact, contactBody : SKPhysicsBody){
        //Animação de batida com obstáculo móvel
        animacaoPow(naPosicao: contactBody.node!.position,
                    emCena: self)
        
        // Efeito sonoro de batida no obstáculo fixo
        if EfeitoSonoro.toggleSonsEstaLigado {
            EfeitoSonoro.tocarSomHit(volume: 0.4)
        }
        
        // Desliga a música da volta atual
        if EfeitoSonoro.toggleMusicaEstaLigado && EfeitoSonoro.musicaEstaTocando {
            EfeitoSonoro.pararTrilhaSonora()
        }
        
        // REINICIAR AÇÕES DO PERSONAGEM APÓS COLIDIR COM OBSTÁCULO MÓVEL
        personagem.seguir(plataforma, personagem)
        
        
        // Zera o numero de voltas e pontuação
        numeroDeVoltasContador.numVoltas = 0
        voltasLabel.text = "\(numeroDeVoltasContador.numVoltas)"
        voltasLabelBorda.text = "\(numeroDeVoltasContador.numVoltas)"
        
        
        pontuacao.pontuacao = 0
        record.text = "\(pontuacao.pontuacao)"
        recordBorda.text = "\(pontuacao.pontuacao)"
    }
    
    
    func setTapToJumpLabel(){
        if let tapLabel = tapToJumpLabel{
            if pontuacao.pontuacao > 8{
                let animacaoFade = SKAction.fadeAlpha(to: 0.5, duration: 2.0)
                let removerLabel = SKAction.run {
                    tapLabel.removeFromParent()
                }
                let sequencia  = SKAction.sequence([animacaoFade, removerLabel])
                tapLabel.run(sequencia)
                tapToJumpLabel = nil
            }
        }
    }
    
    
    
    func countNumberOfLaps(){
        // Código para detectar apenas 1 contato. Sem ele, o mesmo contato é detectado 2 vezes
        if tempoDeteccao < 0.55 { return }
        inicioDeteccao = Date.now
        
        //Incrementa um ao numero de voltas
        numeroDeVoltasContador.addVolta()
        voltasLabel.text = "\(numeroDeVoltasContador.numVoltas)"
        voltasLabelBorda.text = "\(numeroDeVoltasContador.numVoltas)"
        
        
        pontuacao.addPontuacaoVoltas()
        record.text = "\(pontuacao.pontuacao)"
        recordBorda.text = "\(pontuacao.pontuacao)"
    }
}
