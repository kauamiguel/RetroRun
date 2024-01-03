//
//  ColisionMask.swift
//  Mini01
//
//  Created by Kaua Miguel on 12/07/23.
//

import Foundation

struct CollisionMask {
    // Categorias de colisão e contato
    static var semColisao: UInt32 = 0
    static var characterMask: UInt32 = 1 << 1
    static var plataformMask: UInt32 = 1 << 2
    static var redBlockMask: UInt32 = 1 << 3
    static var greenBlockMask: UInt32 = 1 << 4
    static var detectorSeguro: UInt32 = 1 << 5
    static var detectorReset: UInt32 = 1 << 6
    static var obstaculoFixo: UInt32 = 1 << 7
    static var largada: UInt32 = 1 << 8
}



