//
//  BottomSheetFilters.swift
//  WBN
//
//  Created by Maciej Zadykowicz on 12/01/2020.
//  Copyright © 2020 Maciej Zadykowicz. All rights reserved.
//

import SwiftUI

struct BottomSheetFilters: View {
    
    var body: some View {
        VStack (spacing: 0){
            HStack {
                Spacer()
                Color("Grey40")
                    .frame(width: 35.0, height: 3.0)
                    .cornerRadius(1.5)
                Spacer()
            }
            HStack {
                Text("Sort and filter")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black)
                Spacer()
                Text("Reset")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Color("accentBlue"))
            }.frame(height: 52.0).padding(.horizontal, 16)
            HStack {
                Text("Show me")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(Color("Grey"))
                Spacer()
            }.frame(height: 40.0).padding(.horizontal, 16).padding(.top, 12)
            HStack (spacing: 0){
                Filter(title: "Chats")
                Spacer()
                Filter(title: "Browser")
            }.frame(height: 52.0).padding(.horizontal, 16)
            HStack {
                Text("Sort by")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(Color("Grey"))
                Spacer()
            }.frame(height: 40.0).padding(.horizontal, 16).padding(.top, 24)
            HStack {
                Text("Date created")
                .font(.system(size: 17, weight: .regular))
                Spacer()
                Color.white
                    .cornerRadius(6)
                    .frame(width: 12, height: 12)
                    .padding(6)
                    .background(Color("accentBlue"))
                    .cornerRadius(32)
            }.frame(height: 52.0).padding(.horizontal, 16)
            HStack {
                Text("Latest activity")
                .font(.system(size: 17, weight: .regular))
                Spacer()
                Color.white
                    .opacity(0.0)
                    .cornerRadius(6)
                    .frame(width: 12, height: 12)
                    .padding(6)
                    .background(Color("LightGrey"))
                    .cornerRadius(32)
            }.frame(height: 52.0).padding(.horizontal, 16)
            Spacer()
        }
        .padding(.vertical, 12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}

struct BottomSheetFilters_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetFilters()
    }
}

struct Filter: View {
    
    var title: String = "Chats"
    
    var body: some View {
        HStack {
            Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                EmptyView()
            }
            .toggleStyle(
                ColoredToggleStyle(label: title))
                .padding(.leading, 16).padding(.vertical, 8).padding(.trailing, 8)
            .background(Color("LightBlue"))
        }.cornerRadius(22)
    }
}

struct ColoredToggleStyle: ToggleStyle {
    var label = ""
    var onColor = Color("accentBlue")
    var offColor = Color.white
    var thumbColor = Color.white

    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(Color("accentBlue"))
            Spacer()
            Button(action: { configuration.isOn.toggle() } )
            {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 50, height: 29)
                    .overlay(
                        Circle()
                            .fill(thumbColor)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(3)
                            .offset(x: configuration.isOn ? 10 : -10))
                    .animation(Animation.easeInOut(duration: 0.1))
            }
        }
    }
}
