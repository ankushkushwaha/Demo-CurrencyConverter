//
//  ErrorView.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import SwiftUI

struct ErrorView: View {
    let error: DataError
    var tryAgainButtonAction: () -> Void
    
    var body: some View {
        VStack {
            Text(error.errorMessage)
                .padding()
                .multilineTextAlignment(.center)
            Button(action: {
                tryAgainButtonAction()
            }) {
                Image(systemName: "arrow.clockwise")
                    .font(.largeTitle)
            }
            .padding()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: DataError.networkError,
                  tryAgainButtonAction: {})
    }
}
