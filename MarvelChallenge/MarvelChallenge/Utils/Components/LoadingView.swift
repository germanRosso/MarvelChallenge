//
//  LoadingView.swift
//  MarvelChallenge
//
//  Created by German Rosso on 05/11/2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
            ProgressView()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
