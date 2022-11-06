//
//  MarvelHeaderView.swift
//  MarvelChallenge
//
//  Created by German Rosso on 30/10/2022.
//

import SwiftUI

struct MarvelHeaderView: View {
    var title: String
    var action: () -> Void
    var opacity: Double
    var disabled: Bool
    var body: some View {
        VStack {
            ZStack {
                Color.marvel262626
                    .ignoresSafeArea()
                HStack {
                    Button(action: action) {
                        Image(systemName: "xmark")
                            .frame(width: 14)
                            .foregroundColor(.marvelFFFFFF)
                            .opacity(opacity)
                            .padding(.horizontal)
                            .disabled(disabled)
                    }
                    Spacer()
                    Text(title)
                        .font(.robotoCondensedBold20)
                        .foregroundColor(.marvelFFFFFF)
                        .offset(x: -24)
                    Spacer()
                }
            }
            .frame(height: 56)
        }
    }
}

struct MarvelHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MarvelHeaderView(title: "Marvel Challenge", action: {print("hello")}, opacity: 100, disabled: false)
    }
}
