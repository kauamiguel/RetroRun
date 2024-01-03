//
//  Pause.swift
//  Mini01
//
//  Created by Kaua Miguel on 26/07/23.
//

import SpriteKit
import SwiftUI

class PauseMenu: SKNode {
    
    var gameLayer: SKScene!
    
    var isSoundOn = true
    var isMusicOn = true
    
    init(gameLayer: SKScene) {
        self.gameLayer = gameLayer
        super.init()
        
        let blur = SKSpriteNode(imageNamed: "blur")
        blur.size = CGSize(width: 660, height: 290)
        addChild(blur)
        blur.zPosition = 19
        
        let bg = SKSpriteNode(imageNamed: "bg")
        addChild(bg)
        bg.zPosition = 20
        

        // Adicione os elementos do menu de pausa
        let pauseLabel = SKSpriteNode(imageNamed: "pause")
        pauseLabel.position = CGPoint(x: 0, y: 100)
        addChild(pauseLabel)
        pauseLabel.zPosition = 21
        
        //Music Toggle
        
            //Texto Musica
        
        let musicToggleText = SKLabelNode(text: "Music")
        musicToggleText.fontName = "Quicksand-Bold"
        musicToggleText.position = CGPoint(x: -50, y: 45)
        musicToggleText.fontSize = 20
        addChild(musicToggleText)
        musicToggleText.zPosition = 21
        
            //Toggle Musica
        
        let musicToggle = isSoundOn ? SKSpriteNode(imageNamed: "ligado") : SKSpriteNode(imageNamed: "desligado")
        musicToggle.name = "musicToggle"
        musicToggle.position = CGPoint(x: 50, y: 45 + 19/2)
        addChild(musicToggle)
        musicToggle.zPosition = 21
        
        //Sound Toggle
        
            //Texto Som
        
        let soundToggleText = SKLabelNode(text: "Sound")
        soundToggleText.fontName = "Quicksand-Bold"
        soundToggleText.position = CGPoint(x: -50, y: 15)
        soundToggleText.fontSize = 20
        addChild(soundToggleText)
        soundToggleText.zPosition = 21
        
            //Toggle Som
        
        let soundToggle = isSoundOn ? SKSpriteNode(imageNamed: "ligado") : SKSpriteNode(imageNamed: "desligado")
        soundToggle.name = "soundToggle"
        soundToggle.position = CGPoint(x: 50, y: 15 + 19/2)
        addChild(soundToggle)
        soundToggle.zPosition = 21
        
        //Resume
        
        let resumeButton = SKSpriteNode(imageNamed: "botaoResumeFinal")
        resumeButton.position = CGPoint(x: 0, y: -40)
        resumeButton.name = "resumeButton"
        addChild(resumeButton)
        resumeButton.zPosition = 21
        
        //Main Menu
        
        let mainMenuButton = SKSpriteNode(imageNamed: "botaoHomeFinal")
        mainMenuButton.position = CGPoint(x: 0, y: -85)
        mainMenuButton.name = "mainMenuButton"
        addChild(mainMenuButton)
        mainMenuButton.zPosition = 21
        
        isUserInteractionEnabled = true
        isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        // Pause a camada do jogo e exiba o menu de pausa
        gameLayer.isPaused = true
        isHidden = false
    }
    
    func hide() {
        // Retome a camada do jogo e oculte o menu de pausa
        gameLayer.isPaused = false
        isHidden = true
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let nodesAtLocation = nodes(at: location)
            
            
            for node in nodesAtLocation {
                if node.name == "resumeButton" {
                    
                    EfeitoSonoro.tocarSomTap01(self) // som de tap ao voltar pro jogo
                    
                    gameLayer.isPaused = false
                    hide()
                    
                    if let gameScene = self.scene as? GameScene {
                            gameScene.pausado = false
                    }
                    
                } else if node.name == "mainMenuButton" {
                    EfeitoSonoro.tocarSomTap01(self) // som de tap ao sair do jogo
                    
                    // voltando os toggles para o seu estado original de LIGADOS
                    EfeitoSonoro.toggleMusicaEstaLigado = true
                    EfeitoSonoro.toggleSonsEstaLigado = true
                    
                    hide()
                    
                    let transition = SKTransition.fade(withDuration: 2.0)

                    // Criação da cena
                    if let scene = SKScene(fileNamed: "TelaInicial") {
                        // Definir a escala da cena
                        scene.scaleMode = .aspectFill
                        
                        // Apresentar a cena com a transição
                        gameLayer.view?.presentScene(scene, transition: transition)
                    }

                    
                } else if node.name == "musicToggle" {
                    // Alterne a música quando o toggle de música for pressionado
                    toggleMusic()
                    
                } else if node.name == "soundToggle" {
                    
                    // Alterne o som quando o toggle de som for pressionado
                    toggleSound()
                }
            }
        }
    }
    
    func toggleMusic() {
        isMusicOn = !isMusicOn
        
        let musicToggle = childNode(withName: "musicToggle") as! SKSpriteNode
        
        musicToggle.texture = isMusicOn ? SKTexture(imageNamed: "ligado") : SKTexture(imageNamed: "desligado")
        
        //togglar música de fundo
        if isMusicOn {
            if !EfeitoSonoro.musicaEstaTocando{
                
                EfeitoSonoro.tocarTrilhaSonora(volumeInicial: 0.0, volumeFinal: 0.5, duracaoFade: 1.0)
            }

            
            EfeitoSonoro.toggleMusicaEstaLigado = true
        } else {
            EfeitoSonoro.toggleMusicaEstaLigado = false
            EfeitoSonoro.pararTrilhaSonora()
  
        }
        
        
    }
    
    func toggleSound() {
        isSoundOn = !isSoundOn
        
        let soundToggle = childNode(withName: "soundToggle") as! SKSpriteNode
        soundToggle.texture = isSoundOn ? SKTexture(imageNamed: "ligado") : SKTexture(imageNamed: "desligado")
        
        
        EfeitoSonoro.toggleSonsEstaLigado.toggle()
        
        // Ativar e desativar o som de Hit do personagem no obstáculo
        if EfeitoSonoro.toggleSonsEstaLigado{
            EfeitoSonoro.somEstaTocando = true
        } else {
            EfeitoSonoro.somEstaTocando = false
        }
        

    }
}


struct MyView: UIViewControllerRepresentable{
    typealias UIViewControllerType = GameViewController
    
    func makeUIViewController(context: Context) -> GameViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let viewController = storyboard.instantiateInitialViewController()
        else{
            fatalError("Cannot load ViewController from main storyboard")
        }
        return viewController as! GameViewController
    }
    
    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}
struct ControllerView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
            .ignoresSafeArea()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
