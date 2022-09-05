//
//  String+Extension.swift
//  RxNetflix
//
//  Created by DaeSeong on 2022/09/05.
//

import Foundation

extension String {
    
    func capitalizeFirstLetter()-> String{
        return self.prefix(1).uppercased() + self.dropFirst().lowercased()
    }
}
