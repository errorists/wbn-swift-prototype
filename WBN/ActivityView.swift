//
//  ActivityView.swift
//  WBN
//
//  Created by Maciej Zadykowicz on 14/01/2020.
//  Copyright © 2020 Maciej Zadykowicz. All rights reserved.
//

import SwiftUI

struct ActivityView: View {
    var body: some View {
        ZStack (alignment: .top) {
            Image("Activity view")
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .padding(.top, 52)
            HStack (spacing: 0) {
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Image("filters")
                        .foregroundColor(Color.black)
                }.frame(width:44, height: 52)
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(Color("Grey"))
                }.frame(width:52, height: 52)
            }
        }
        .frame(height: UIScreen.main.bounds.height - 88, alignment: .top)
        .background(Color.white)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
