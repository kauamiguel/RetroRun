//
//  ConfigsAudio.swift
//  Mini01
//
//  Created by Leonardo Mota on 27/07/23.
//

import AVFoundation
import SpriteKit

class EfeitoSonoro {
    
    // Variáveis para EFEITOS SONOROS
    public static var musicaDeFundo: AVAudioPlayer?
    private static var somHit: AVAudioPlayer?
    static var musicaEstaTocando = false
    static var somEstaTocando = true
        //Toggles
        static var toggleMusicaEstaLigado = true
        static var toggleSonsEstaLigado = true
    
    private static var somFitaEntrando: SKAction?
    private static var somTransicao : SKAction?
    
    
    // TRILHA SONORA ==============================================================
    class func tocarTrilhaSonora(volumeInicial: Float, volumeFinal: Float, duracaoFade: TimeInterval) {
        // Obtendo o caminho completo para o arquivo de música "TrilhaRetroRun.m4a"
        if let mdfPath = Bundle.main.path(forResource: "TrilhaRetroRun", ofType: "m4a") {
            let url = URL(fileURLWithPath: mdfPath)
            do {
                // Inicializando o AVAudioPlayer com a URL do arquivo de música
                musicaDeFundo = try AVAudioPlayer(contentsOf: url)
                // Preparando o player para a reprodução
                musicaDeFundo?.prepareToPlay()

                // Definindo o volume inicial (zero para fade-in)
                musicaDeFundo?.volume = volumeInicial

                // Iniciando a reprodução
                musicaDeFundo?.play()
                musicaEstaTocando = true
                musicaDeFundo?.numberOfLoops = -1 // tocar em loop

                // Adicionando o fade-in com um Timer
                let fadeSteps = 100 // Número de passos para o fade-in
                let fadeStepDuration = duracaoFade / Double(fadeSteps)
                var currentVolume = volumeInicial

                Timer.scheduledTimer(withTimeInterval: fadeStepDuration, repeats: true) { timer in
                    currentVolume += (volumeFinal - volumeInicial) / Float(fadeSteps)
                    if currentVolume >= volumeFinal {
                        // Garantir que o volume não ultrapasse o valor final
                        timer.invalidate()
                        currentVolume = volumeFinal
                    }
                    musicaDeFundo?.volume = currentVolume
                }

            } catch {
                print("Erro ao inicializar o AVAudioPlayer: \(error)")
            }
        } else {
            print("Arquivo de música não encontrado.")
        }
    }
    
    // Para parar a reprodução da música
    class func pararTrilhaSonora() {
        musicaDeFundo?.stop()
        musicaEstaTocando = false
    }
   
    typealias MyNode = SKNode & AnyObject // faz com que MyNode receba tanto um SKNode quanto SKScene (ou qualquer outra classe que herde de SKNode)
    
    // SOM FITA ENTRANDO ==============================================================
    class func tocarSomFita(_ em: MyNode) {
        let somFitaEntrando:SKAction
        somFitaEntrando = SKAction.playSoundFileNamed("FitaEntrando", waitForCompletion: false)
        em.run(somFitaEntrando)
    }
   
    
    // SOM TRANSIÇÃO ==============================================================
    class func tocarSomTransicao(_ em: MyNode){
        let somTransicao:SKAction
        somTransicao = SKAction.playSoundFileNamed("TransicaoTV", waitForCompletion: false)
        em.run(somTransicao)
    }
    
    // SOM HIT ==============================================================
    class func tocarSomHit(volume: Float = 0.0) {
            if let hitPath = Bundle.main.url(forResource: "Hit", withExtension: "mp3") {
                do {
                    somHit = try AVAudioPlayer(contentsOf: hitPath)
                    somHit?.prepareToPlay()
                    somHit?.volume = volume
                    somHit?.play()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    somHit?.stop()
                    }
                } catch {
                    print("Erro ao inicializar o AVAudioPlayer: \(error)")
                }
            } else {
                print("Arquivo de som não encontrado.")
            }
        }
    
    class func pararSomHit(){
        somHit?.stop()
    }
    
    
    
    // SOM TAP 01 ==============================================================
    class func tocarSomTap01(_ em: MyNode){
        let somTap01:SKAction
        somTap01 = SKAction.playSoundFileNamed("TapSound", waitForCompletion: false)
        em.run(somTap01)
    }
    
    // SOM TAP 02 ==============================================================
    class func tocarSomTap02(_ em: MyNode){
        let somTap02:SKAction
        somTap02 = SKAction.playSoundFileNamed("TapSound2", waitForCompletion: false)
        em.run(somTap02)
    }
    
    // SOM CLICK BOTÃO FITA ==============================================================
    class func tocarSomBotaoFita(volume: Float = 0.0){
        if let hitPath = Bundle.main.url(forResource: "BotaoClick", withExtension: "mp3") {
            do {
                somHit = try AVAudioPlayer(contentsOf: hitPath)
                somHit?.prepareToPlay()
                somHit?.volume = volume
                somHit?.play()
            } catch {
                print("Erro ao inicializar o AVAudioPlayer: \(error)")
            }
        } else {
            print("Arquivo de som não encontrado.")
        }
    }

}


