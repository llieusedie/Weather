//
//  HeaderView.swift
//  Clima
//
//  Created by Paul Kirnoz on 28.06.2022.
//

import SwiftUI

struct HeaderView: View {
    @State private var searchTerm = "San Francisco"
    @State private var isSearching = false
    
    @ObservedObject var cityVM: CityViewViewModel
    @FocusState private var searchIsFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                if isSearching {
                    withAnimation(.spring()) {
                        Button {
                            withAnimation(.spring()) {
                                searchIsFocused = false
                                self.isSearching = false
                                cityVM.city = searchTerm
                            }
                        } label: {
                            Image(systemName: "location.magnifyingglass")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("main"))
                                .padding(.leading, 15)
                            
                        }
                    }
                }
                
                TextField("San Francisco", text: $searchTerm)
                    .font(.custom("Montserrat-Medium", size: 30))
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .trailing], 40)
                    .focused($searchIsFocused)
                    .submitLabel(.search)
                    .keyboardType(.alphabet)
                    .onTapGesture {
                        withAnimation {
                            self.isSearching = true
                        }
                    }
                
                if isSearching {
                    withAnimation(.spring()) {
                        Button {
                            withAnimation(.spring()) {
                                self.isSearching = false
                                //                                self.searchTerm = ""
                            }
                        } label: {
                            Image(systemName: "clear")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("main"))
                                .padding(.trailing, 15)
                        }
                    }
                }
            }
            
            HStack(spacing: 60) {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("\(cityVM.temperature)°")
                        .font(.custom("Montserrat-Bold", size: 60))
                    
                    Text("\(cityVM.conditions)")
                        .font(.custom("Montserrat-Medium", size: 30))
                }
                
                LottieView(name: cityVM.getLottieAnimationFor(icon: cityVM.weatherIcon))
                    .frame(width: 150, height: 150)
                    .shadow(color: .gray, radius: 5, x: 2, y: 2)
            }
            .padding([.leading, .trailing], 20)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
