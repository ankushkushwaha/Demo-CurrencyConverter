//
//  CurrencyRateView.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import SwiftUI

struct CurrencyRateView: View {
    @StateObject private var viewModel = ConverterViewModel()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .padding()
            } else if let error = viewModel.error {
                ErrorView(error: error, tryAgainButtonAction: {
                    fetchData()
                })
            } else {
                textInputView
                baseCurrencyPicker
                gridView
            }
        }.onAppear {
            fetchData()
        }.onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            
            viewModel.calculateConversionRates()
        }
    }
    
    private func fetchData() {
        Task {
            await viewModel.fetchAndShowCurrencies()
        }
    }
    
    private var textInputView: some View {
        TextField("Enter amount", text: $viewModel.amount)
            .keyboardType(.decimalPad)
            .frame(height: 30, alignment: .leading)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(10)
            .focused($isFocused)
            .toolbar() {
                ToolbarItemGroup(placement: .keyboard) {
                    Button(action: {
                        hideKeyboard()
                    }, label: {Text("Done").bold()})
                }
            }
    }
    
    private var baseCurrencyPicker: some View {
        HStack {
            Spacer()
            Text("Select Base Currency: ")
            Picker("Select an option", selection: $viewModel.selectedBaseCurrency) {
                ForEach(viewModel.originalCurrencyModels, id: \.self) { model in
                    Text(model.currencySymbol).tag(CurrencyRateModel?.some(model))
                }
            }
            .frame(minWidth: 50)
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal, 10)
            .border(.gray)
            .padding(.horizontal, 10)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private var gridView: some View {
        let gridItemWidth = CGFloat(80.0)
        let columns = [GridItem(.adaptive(minimum: gridItemWidth),
                                spacing: 10)]

        return ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.currencyListModels, id: \.self) { currencyRateModel in
                    VStack {
                        Text(currencyRateModel.currencySymbol)
                            .minimumScaleFactor(0.7)
                            .lineLimit(1)
                            .foregroundColor(Color.gray)
                        
                        Text(currencyRateModel.rate.prettyStringValue ?? "")
                            .font(.system(size: 15))
                            .minimumScaleFactor(0.4)
                            .lineLimit(1)
                            .foregroundColor(Color.gray)
                        
                        Text(currencyRateModel.convertedRate?.prettyStringValue ?? "-")
                            .minimumScaleFactor(0.4)
                            .lineLimit(1)
                    }
                    .frame(minWidth: gridItemWidth)
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
            }
            .padding(.horizontal, 5)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func hideKeyboard() {
        isFocused = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CurrencyRateView()
        }
    }
}
