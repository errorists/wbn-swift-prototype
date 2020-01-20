//
//  ProfileView.swift
//  WBN
//
//  Created by Maciej Zadykowicz on 12/01/2020.
//  Copyright © 2020 Maciej Zadykowicz. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack (spacing: 0) {
            ScrollView {
                HStack (spacing: 0) {
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color.black)
                    }.frame(width:44, height: 52)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24, weight: .regular))
                            .foregroundColor(Color("Grey"))
                    }.frame(width:52, height: 52)
                }.frame(height: 52).background(Color.white)
                Image("profileView")
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
            }
        }
        .background(Color.white)
        .frame(alignment: .top)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
