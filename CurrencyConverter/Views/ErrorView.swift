//
//  ErrorView.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import SwiftUI

struct ErrorView: View {
    let error: DataError
    
    var body: some View {
        Text(error.errorMessage)
            .alert(isPresented: .constant(true)) {
                Alert(title: Text("Error"),
                      message: Text(error.errorMessage),
                      dismissButton: .default(Text("OK")))
            }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: DataError.networkError)
    }
}
