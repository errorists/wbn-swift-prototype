//
//  SearchView.swift
//  WBN
//
//  Created by Maciej Zadykowicz on 15/01/2020.
//  Copyright © 2020 Maciej Zadykowicz. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("Grey"))
                        Text("Search…")
                            .foregroundColor(Color("Grey"))
                        Spacer()
                    }
                    .frame(height: 36)
                    .padding(.horizontal, 12)
                    .background(Color("LightGrey"))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    Text("Cancel")
                        .padding(.horizontal, 12)
                        .foregroundColor(Color("accentBlue"))
                }
                .padding(8)
                Divider()
                HStack {
                    Text("Recent")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(Color("Grey"))
                        .padding(12)
                    Spacer()
                }
                HStack {
                    Text("dao")
                        .padding(12)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color("Grey40"))
                        .padding(.trailing, 12)
                }
                HStack {
                    Text("market")
                        .padding(12)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color("Grey40"))
                        .padding(.trailing, 12)
                }
                Spacer()
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .frame(height: UIScreen.main.bounds.width, alignment: .top)
        .padding(.horizontal, 16)
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
