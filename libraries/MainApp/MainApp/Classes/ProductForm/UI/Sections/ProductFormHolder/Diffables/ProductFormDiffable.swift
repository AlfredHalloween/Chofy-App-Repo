//
//  EditProductDiffable.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 07/06/21.
//

import Foundation
import IGListKit

enum EditableFieldType {
    case single
    case bigText
    case selector
}

enum ProductFormFieldType: String {
    case name
    case company
    case barCode
    case weight
    case price
    case description
    
    var label: String {
        switch self {
        case .name:
            return "Nombre"
        case .company:
            return "Compañia"
        case .barCode:
            return "Código de barras"
        case .description:
            return "Descripción"
        case .weight:
            return "Cantidad"
        case .price:
            return "Precio"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .name, .weight, .company, .description:
            return .default
        case .barCode:
            return .numberPad
        case .price:
            return .decimalPad
        }
    }
    
    var editableType: EditableFieldType {
        switch self {
        case .name, .weight, .barCode, .price:
            return .single
        case .description:
            return .bigText
        case .company:
            return .selector
        }
    }
    
    var IsEditableCell: Bool {
        switch self {
        case .name, .weight, .price, .description:
            return true
        case .company, .barCode:
            return false
        }
    }
}

final class ProductFormDiffable: ListDiffable {
    var formItems: [EditProductDiffable] = [EditProductDiffable]()
    
    init(data: ProductEditable?, companyName: String?) {
        guard let data = data else { return }
        formItems.append(EditProductDiffable(identifier: ProductFormFieldType.name,
                                             text: data.name ?? ""))
        formItems.append(EditProductDiffable(identifier: ProductFormFieldType.company,
                                             text: companyName ?? ""))
        formItems.append(EditProductDiffable(identifier: ProductFormFieldType.barCode,
                                             text: data.barCode ?? ""))
        formItems.append(EditProductDiffable(identifier: ProductFormFieldType.weight,
                                             text: data.weight ?? ""))
        formItems.append(EditProductDiffable(identifier: ProductFormFieldType.price,
                                             text: String(data.price ?? 0.0)))
        formItems.append(EditProductDiffable(identifier: ProductFormFieldType.description,
                                             text: data.description ?? ""))
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return formItems.map {
            let identifier: String = $0.diffIdentifier() as? String ?? ""
            return identifier
        }.joined(separator: "_") as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let otherObject = object,
              let identifier = diffIdentifier() as? String,
              let otherIdentifier = otherObject.diffIdentifier() as? String else {
            return false
        }
        return identifier == otherIdentifier
    }
}

final class EditProductDiffable: ListDiffable {
    var identifier: ProductFormFieldType
    var text: String
    
    init(identifier: ProductFormFieldType, text: String = "") {
        self.identifier = identifier
        self.text = text
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return "\(identifier)_\(text)" as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let otherObject = object,
              let identifier = diffIdentifier() as? String,
              let otherIdentifier = otherObject.diffIdentifier() as? String else {
            return false
        }
        return identifier == otherIdentifier
    }
}
