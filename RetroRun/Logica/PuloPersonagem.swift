import SpriteKit

func pular(_ personagem: Personagem, _ plataforma:SKSpriteNode) {

    // Variáveis de controle do pulo
    let duracaoPulo: TimeInterval = 0.6 // Duração da animação de pulo

    let personagemPosicao = personagem.position

    // Função para realizar o pulo do personagem
    func realizarPulo(_ x: CGFloat, _ y: CGFloat) {
        let pularAcao = SKAction.moveBy(x: x, y: y, duration: duracaoPulo)
        pularAcao.timingMode = SKActionTimingMode.easeInEaseOut
        personagem.run(pularAcao)
    }

    let alturaPulo : CGFloat = 1000

    // Criando a animação do pulo baseado na posição do plano cartesiano
        if personagemPosicao.y > plataforma.size.height / 2 { // reto em cima
            realizarPulo(0, alturaPulo)
        } else if personagemPosicao.y < plataforma.size.height / 2 && personagemPosicao.y > -plataforma.size.height / 2 { // NAS CURVAS
            // CURVA ESQUERDA ======================================
            if personagemPosicao.x < 0 {
                // CURVA SUPERIOR
                if personagemPosicao.y > 0 { // curva de cima esquerda
                    if plataforma.size.height / 2 - personagemPosicao.y < (plataforma.size.height / 2)/4 { // até 1/3 DA CURVA NAO TERMINADA ELE NAO REALIZA O PULO PROS LADOS
                        realizarPulo(-alturaPulo, alturaPulo) // Ajuste nos eixos x e y para a curva superior esquerda
                    } else {
                        realizarPulo(-alturaPulo, 0) // Ajuste apenas no eixo x para pular para a esquerda
                    }
                // CURVA INFERIOR
                } else {
                    if -plataforma.size.height / 2 - personagemPosicao.y > -(plataforma.size.height / 2)/4 { // até 1/3 DA CURVA NAO TERMINADA ELE NAO REALIZA O PULO PROS LADOS
                        realizarPulo(-alturaPulo, -alturaPulo) // Ajuste nos eixos x e y para a curva inferior esquerda
                    } else {
                        realizarPulo(-alturaPulo, 0) // Ajuste apenas no eixo x para pular para a esquerda
                    }
                }
            // CURVA ESQUERDA ======================================
            } else {
            // CURVA DIREITA ======================================
                // CURVA SUPERIOR
                if personagemPosicao.y > 0 { // curva de cima da direita
                    if plataforma.size.height / 2 - personagemPosicao.y < (plataforma.size.height / 2)/4 { // até 1/3 DA CURVA NAO TERMINADA ELE NAO REALIZA O PULO PROS LADOS
                        realizarPulo(alturaPulo, alturaPulo) // Ajuste nos eixos x e y para a curva superior direita
                    } else {
                        realizarPulo(alturaPulo, 0) // Ajuste apenas no eixo x para pular para a direita
                    }
                // CURVA INFERIOR
                } else {
                    if -plataforma.size.height / 2 - personagemPosicao.y > -(plataforma.size.height / 2)/4 { // até 1/3 DA CURVA NAO TERMINADA ELE NAO REALIZA O PULO PROS LADOS
                        realizarPulo(alturaPulo, -alturaPulo) // Ajuste nos eixos x e y para a curva inferior direita
                    } else {
                        realizarPulo(alturaPulo, 0) // Ajuste apenas no eixo x para pular para a direita
                    }
                }
            }
            // CURVA DIREITA ======================================
        } else  { // RETO EM BAIXO
            realizarPulo(0, -alturaPulo)
        }
    }
