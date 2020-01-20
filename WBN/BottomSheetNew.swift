//
//  BottomSheetNew.swift
//  WBN
//
//  Created by Maciej Zadykowicz on 12/01/2020.
//  Copyright © 2020 Maciej Zadykowicz. All rights reserved.
//

import SwiftUI

struct BottomSheetNew: View {
    var body: some View {
        VStack (spacing: 0) {
            HStack {
                Spacer()
                Color("Grey40")
                    .frame(width: 35.0, height: 3.0)
                    .cornerRadius(1.5)
                Spacer()
            }
            HStack {
                Text("Open…")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black)
                Spacer()
                Image("qr")
            }.frame(height: 52.0).padding(.horizontal, 16)
            ActionListRow(title: "Private chat", image: "message")
            ActionListRow(title: "Group chat", image: "group_chat")
            ActionListRow(title: "Public chat", image: "public_chat")
            ActionListRow(title: "Browser tab", image: "browser")
            ActionListRow(title: "New transaction", image: "2_arrows")
            Spacer()
        }
        .padding(.vertical, 12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}

struct BottomSheetNew_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetNew()
    }
}

struct ActionListRow: View {
    
    var title: String = "title"
    var image: String = "message"
    
    var body: some View {
        HStack (spacing: 16) {
            VStack {
                Image(image)
            }.frame(width: 40, height: 40).background(Color("LightBlue")).cornerRadius(20)
            Text(title)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(Color("accentBlue"))
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color("Grey40"))
        }.frame(height: 56.0).padding(.horizontal, 16)
    }
}
