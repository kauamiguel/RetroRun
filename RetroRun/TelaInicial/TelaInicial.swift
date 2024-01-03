//
//  TelaInicial.swift
//  Mini01
//
//  Created by Kaua Miguel on 19/07/23.
//

import SpriteKit

class TelaInicial : SKScene{
    
    private var fita = SKSpriteNode()
    private var walkman = SKSpriteNode()
    private var botao1 = SKSpriteNode()
    private var botao2 = SKSpriteNode()
    private var botao3 = SKSpriteNode()
    private var parteTrasFita = SKSpriteNode()
    private var estaPosicionado = false
    private var fitaFoiTocada = false
    private var dragToStart = SKSpriteNode()
    private var diamondPontuacao = SKSpriteNode()
    private var simboloVoltas = SKSpriteNode()
    private var botaoCreditos = SKSpriteNode()
    
    // labels de records
    private var labelRecord = SKLabelNode()
    private var labelRecordSombra = SKLabelNode()
    
    private var labelRecordVoltas = SKLabelNode()
    private var labelRecordVoltasSombra = SKLabelNode()
    
    //referencia para a fita
    private var noAtual : SKNode?
    
    override func didMove(to view: SKView) {
        
        // Tocar trilha de fundo ao abrir o jogo
        EfeitoSonoro.tocarTrilhaSonora(volumeInicial: 0.0, volumeFinal: 0.2, duracaoFade: 5.0)
        
        botaoCreditos = childNode(withName: "botaoCreditos") as! SKSpriteNode
        parteTrasFita = childNode(withName: "parteTrasFita") as! SKSpriteNode
        fita = childNode(withName: "fita") as! SKSpriteNode
        walkman = childNode(withName: "walkman") as! SKSpriteNode
        botao1 = childNode(withName: "botao1") as! SKSpriteNode
        botao2 = childNode(withName: "botao2") as! SKSpriteNode
        botao3 = childNode(withName: "botao3") as! SKSpriteNode
        dragToStart = childNode(withName: "dragToStart") as! SKSpriteNode
        diamondPontuacao = childNode(withName: "diamondPontuacao") as! SKSpriteNode
        simboloVoltas = childNode(withName: "voltasSimbolo") as! SKSpriteNode
        
        
        // Mostra os Records de pontuação total e de número de voltas na tela inicial
        let record = PontuacaoLogica.pegarRecorde()
        labelRecord = childNode(withName: "record") as! SKLabelNode
        labelRecord.text = "\(record)"
        
        _ = PontuacaoLogica.pegarRecorde()
        labelRecordSombra = childNode(withName: "sombraPontuacao") as! SKLabelNode
        labelRecordSombra.text = "\(record)"
        
        
        
        let recordVoltas = PontuacaoLogica.pegarRecordVoltas()
        labelRecordVoltas = childNode(withName: "recordNumeroVoltas") as! SKLabelNode
        labelRecordVoltas.text = "\(recordVoltas)"
        
        _ = PontuacaoLogica.pegarRecordVoltas()
        labelRecordVoltasSombra = childNode(withName: "sombraVoltas") as! SKLabelNode
        labelRecordVoltasSombra.text = "\(recordVoltas)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Verifica se o primeiro toque não é nulo
        
        if let toque = touches.first{
            
            //Salva as coordenadas do toque (location)
            let localizcao = toque.location(in: self)
            
            //Nodes(at: ) retorna um array de nodes na região tocada
            let noTocado = self.nodes(at: localizcao)
            
            //Itera sobre cada node na região tocada e verifica qual tem o nome de "Fita"
            for node in noTocado.reversed(){
                if node.name == "fita"{
                    self.noAtual = node
                }
            }
        }
        
        if let toque = touches.first{
            
            //Salva as coordenadas do toque (location)
            let localizacao = toque.location(in: self)
            
            //Nodes(at: ) retorna um array de nodes na região tocada
            let noTocado = self.nodes(at: localizacao)
            
            //Itera sobre cada node na região tocada e verifica qual tem o nome de "Fita"
            for node in noTocado.reversed(){
                if node.name == "botaoCreditos"{
                    EfeitoSonoro.tocarSomTap01(self)
                    let transition = SKTransition.fade(withDuration: 2.0)
                    self.view?.presentScene(SKScene(fileNamed: "Creditos")!, transition: transition)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Verifica se a fita foi tocada para não deixa-la mover mais
        if !fitaFoiTocada{
            // Verifica se o toque e o No com nome "Fita" é vazio
            if let toque = touches.first, let node = self.noAtual{
                
                if toque.location(in: self).x > 0{
                    //Pega a localização do toque apenas no eixo x
                    let localizcaoDoToque = toque.location(in: self).x
                    //Atribiu a localização para o node com nome "Fita", já que a função trackeia a posição do node
                    node.position.x = localizcaoDoToque
                }else{
                    
                    //Signifca que a fita já está dentro do walkman
                    node.position.x = 0
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        animacaoFita()
    }
}

//Extension contem todas as funções com animações da tela inicial
extension TelaInicial{
    
    func animacaoFita(){
        
        //Verifica se a fita nao foi tocada para rodar a animacao apenas uma vez
        if !fitaFoiTocada{
            //Atribui a fita e o walkman para a mesma posicao no X
            if let node = self.noAtual{
                let acaoFita = SKAction.moveTo(x: 0, duration: 2.0)
                let acaoWalman = SKAction.moveTo(x: 0, duration: 2.0)
                let acaoBackGroundFita = SKAction.moveTo(x: 0, duration: 2.0)
                self.walkman.run(acaoWalman)
                self.parteTrasFita.run(acaoBackGroundFita)

                            
                EfeitoSonoro.tocarSomFita(self)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // depois de 2s ele faz o som de transição entre as Views
                    EfeitoSonoro.tocarSomTransicao(self)
                }
                
                if EfeitoSonoro.musicaEstaTocando{
                    EfeitoSonoro.pararTrilhaSonora()
                }
                
                node.run(acaoFita)
                
                self.fitaFoiTocada = true
                animacaoBotao()
                girarFita()
                zoomIn()
                pausarTela()
                self.noAtual = nil
            }
            
            
        }
    }
    
    //Criar animação de click do botão
    func animacaoBotao(){
        let posicaoInicial = botao2.position
        
        let descer = SKAction.moveTo(y: CGFloat(self.botao2.position.y - self.botao2.size.height/2), duration: 0.3)
        let subir = SKAction.moveTo(y: posicaoInicial.y, duration: 0.3)
        
        let tocarSomBotaoFita = SKAction.run {
            EfeitoSonoro.tocarSomBotaoFita(volume: 0.35)
        }
        
        //Antes de realizar a animação, esperar 2 segundos que é o tempo da animação da fita acabar
        let sequencia = SKAction.sequence([SKAction.wait(forDuration: 2.0), descer, tocarSomBotaoFita, subir])
        
        //Depois de animar o botao, remover os nós e deixar apenas a fita, para dar zoom
        self.botao2.run(sequencia){
            
            let removerNodes:[SKNode] = [self.walkman,self.botao1, self.botao2, self.botao3, self.parteTrasFita, self.labelRecord, self.dragToStart, self.diamondPontuacao, self.botaoCreditos, self.labelRecordVoltas, self.simboloVoltas, self.labelRecordSombra, self.labelRecordVoltasSombra]
            
            for nodes in removerNodes{
                let removerNode = SKAction.run {
                    nodes.removeFromParent()
                }
                
                let sequencia  = SKAction.sequence([SKAction.fadeAlpha(to: 0.3, duration: 0.3), removerNode])
                
                nodes.run(sequencia)
            }
        }
    }
    
    //Funcao para girar a fita na orientação do jogo
    func girarFita(){
        let acao = SKAction.rotate(byAngle: .pi, duration: 1.0)
        let sequencia = SKAction.sequence([SKAction.wait(forDuration: 3.5),acao])
        fita.run(sequencia)
    }
    
    //Criar a animação do zoom na fita
    func zoomIn() {
        let acaoZoom = SKAction.scale(by: 2.0, duration: 1.5)
        
        //Acao de zoom espera 4 segundos para terminar a animacao da fita e do botao
        let sequencia = SKAction.sequence([SKAction.wait(forDuration: 5.0), acaoZoom])
        fita.run(sequencia)
    }
    
    //Função para congelar a tela por 8 segundos antes de começar a gameplay
    func pausarTela(){
        //Duracao é a soma de todas as animações que ocorrerão durante o freeze da tela
        let duracao = 6.0
        let acaoDeEsperar = SKAction.wait(forDuration: duracao)
        
        let mostrarNovaView = SKAction.run {
            let transicao = SKTransition.fade(withDuration: 2.0)
            self.view?.presentScene(SKScene(fileNamed: "GameScene")!, transition: transicao)
        }
  
        let sequencia = SKAction.sequence([acaoDeEsperar, mostrarNovaView])
        
        self.run(sequencia)
    }
}
