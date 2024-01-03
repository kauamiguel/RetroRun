import SpriteKit

// Rota do personagem ==========================================================
extension Personagem {
    
    func seguir(_ plataforma:SKSpriteNode, _ personagem: Personagem){
        
        let cornerRadius: CGFloat = 64.0 + personagem.personagem.size.height/2
        
        // codigo novo para fazer personagem andar sobre o circuito, sem colisao
        
        let metadeLarguraPersonagem = personagem.personagem.size.width / 2
        let metadeAlturaPersonagem = personagem.personagem.size.height / 2
        
        let roundedRect = UIBezierPath(roundedRect: CGRect(
            x: -plataforma.size.width / 2 - metadeLarguraPersonagem,
            y: -plataforma.size.height / 2 - metadeAlturaPersonagem,
            width: plataforma.size.width + personagem.personagem.size.width,
            height: plataforma.size.height + personagem.personagem.size.height),
                                       cornerRadius: cornerRadius)
        
        // Rotacionando horizontalmente e depois verticalmente
        let rotationTransform1 = CGAffineTransform(rotationAngle: .pi )
        let rotationTransform2 = CGAffineTransform(scaleX: -1.0, y: 1.0)
        roundedRect.apply(rotationTransform1)
        roundedRect.apply(rotationTransform2)
        
        let cgPathSeguivel = roundedRect.cgPath // transformando em cgPath para usar o follow
        
        let followAction = SKAction.repeatForever(SKAction.follow(cgPathSeguivel, asOffset: false, orientToPath: true, speed:110))
        
        self.run(followAction) // seguir circuito
        
        // Tocar trilha sonora toda vez que bate no obstáculo
        if EfeitoSonoro.toggleMusicaEstaLigado {
            EfeitoSonoro.tocarTrilhaSonora(volumeInicial: 0.0, volumeFinal: 0.5, duracaoFade: 1.0)
        }
    }
}
// Rota do personagem ==========================================================

