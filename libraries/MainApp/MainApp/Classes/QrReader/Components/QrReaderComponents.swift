//
//  QrReaderComponents.swift
//  MainApp-MainAppResources
//
//  Created by Juan Alfredo García González on 18/06/21.
//

import Foundation

struct QrReaderModalInput: GenericModalInput {
    var advice: String? {
        return "Confirmacion".uppercased()
    }
    
    var title: String? {
        return "Permisos de cámara"
    }
    
    var subtitle: String? {
        return "Se requieren los permisos de cámara para utilizar el scanner." +
            "\n Configura los permisos de la cámara para acceder a este módulo."
    }
    
    var mainBtnTitle: String {
        return "Ir a configuración"
    }
    
    var secondaryBtnTitle: String {
        return "Cancelar"
    }
}
