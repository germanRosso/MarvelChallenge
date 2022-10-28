//
//  LoginView.swift
//  MarvelChallenge
//
//  Created by German Rosso on 20/09/2022.
//

import SwiftUI

struct LoginView: View {
    @State var userEmail = ""
    @State var userPassword = ""
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color.marvel262626
                    .edgesIgnoringSafeArea(.top)
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 114)
            }
            .frame(height: 140.54)
            ZStack {
                Color.marvelECEFF1
                    .edgesIgnoringSafeArea(.bottom)
                VStack(spacing: 20) {
                    CustomTextfield(userInput: $userEmail, image: "email", requiredData: "Email")
                    CustomTextfield(userInput: $userPassword, image: "lock", requiredData: "Password")
                    Button {
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(.marvelFFFFFF)
                            Text("Login")
                                .font(.robotoMedium14)
                                .foregroundColor(.marvel00000061)
                        }
                        .frame(width: 77, height: 35)
                    }
                    Spacer()
                }
                .padding(.top, 20)
            }
        }
    }
}

struct CustomTextfield: View {
    @State var userInput: Binding<String>
    var image: String
    var requiredData: String
    var body: some View {
        ZStack {
            background
            HStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                VStack(alignment: .leading, spacing: 0) {
                    Text(requiredData)
                        .font(.robotoCondensed20)
                    TextField("", text: userInput)
                }
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    private var background: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.marvel0000000B)
                .padding(.bottom, 5)
                .cornerRadius(5)
                .padding(.bottom, -5)
            VStack {
                Spacer()
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.marvel262626)
            }
        }
        .frame(height: 56)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
