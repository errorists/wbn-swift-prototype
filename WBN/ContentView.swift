//
//  ContentView.swift
//  WBN
//
//  Created by Maciej Zadykowicz on 11/01/2020.
//  Copyright © 2020 Maciej Zadykowicz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var rotationOn = false
    @State var homeExpanded = false
    @State var newToggled = false
    @State var filtersToggled = false
    @State var showProfile = false
    @State var showActivity = false
    @State var showWallet = false
    @State var showSearch = false
    @State var newSheetState = CGSize.zero
    @State var filterSheetState = CGSize.zero
    @State var homeButtonState = CGSize.zero
    
    var topSafeArea: CGFloat = 44.0
    var bottomSafeArea: CGFloat = 34.0
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            
            NavigationView(rotationOn: $rotationOn)
            
            VStack (spacing: 0) {
                ZStack {
                    HStack {

                        Button(action: { self.showProfile = true }) {
                            NavButton(type: .imageButton)
                        }.sheet(isPresented: $showProfile) {
                            ProfileView()
                        }

                        Spacer()

                        WalletButton(showWallet: $showWallet)
                            .sheet(isPresented: $showWallet) {
                                WalletView()
                            }

                        Spacer()

                        Button(action: { self.showActivity = true }) {
                            NavButton(type: .iconButton, icon: "notificationIcon")
                                .overlay(Badge().offset(x: 12, y: -12))
                        }.sheet(isPresented: $showActivity) {
                            ActivityView()
                        }


                    }
                    .padding(.top, topSafeArea)
                    .padding(.horizontal, 6)
                    .scaleEffect(rotationOn ? 1.0 : 1.1, anchor: .bottom)
                    .opacity(rotationOn ? 1 : 0)
                    .animation(.interpolatingSpring(stiffness: 300, damping: 30))
                }

                Spacer()

                ZStack {
                    HStack {
                        NewButton(newToggled: $newToggled)
                        Spacer()
                        Button(action: { self.showSearch = true }) {
                            NavButton(type: .iconButton, icon: "Search")
                        }
                        Button(action: { self.filtersToggled = true }) {
                            NavButton(type: .iconButton, icon: "filters")
                        }
                    }
                    .frame(height: 52)
                    .scaleEffect(rotationOn ? 1.0 : 1.1, anchor: .top)
                    .opacity(rotationOn ? 1 : 0)
                    .animation(.interpolatingSpring(stiffness: 300, damping: 30))

                    HomeButton(rotationOn: $rotationOn,  homeExpanded: $homeExpanded, homeButtonState: $homeButtonState)
                    }
                .padding(.bottom, 34)
            }
            .overlay(Color.black.opacity(newToggled || filtersToggled || showSearch ? 0.5 : 0)
                .animation(.easeInOut(duration: 0.25))
                .onTapGesture {
                    if self.newToggled == true {
                        self.newToggled = false
                    } else if self.filtersToggled == true {
                        self.filtersToggled = false
                    } else if self.showSearch == true {
                        self.showSearch = false
                    }
                }
            )
        }
        .overlay(SearchView()
            .opacity(showSearch ? 1 : 0)
            .scaleEffect(showSearch ? 1.0 : 0.9)
            .animation(.interpolatingSpring(stiffness: 300, damping: 30))
        )

        .overlay(BottomSheetNew()
            .offset(y: newToggled ? (screen.height - 360 - bottomSafeArea) : screen.height)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.newSheetState = value.translation
                    }
                    .onEnded { value in
                        if self.newSheetState.height > 50 {
                            self.newToggled = false
                        }
                        self.newSheetState = .zero
                    }
            )
            .offset(y: newSheetState.height)
            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
        )
        .overlay(BottomSheetFilters()
            .offset(y: filtersToggled ? (screen.height - 350 - bottomSafeArea) : screen.height)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.filterSheetState = value.translation
                    }
                    .onEnded { value in
                        if self.filterSheetState.height > 50 {
                            self.filtersToggled = false
                        }
                        self.filterSheetState = .zero
                    }
            )
            .offset(y: filterSheetState.height)
            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
        )
        .edgesIgnoringSafeArea(.all)
        .background(Color("windowBackground"))
        .statusBar(hidden: rotationOn ? true : false)
    }
}

struct HomeButton: View {
    @Binding var rotationOn : Bool
    @Binding var homeExpanded : Bool
    @Binding var homeButtonState : CGSize
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                VStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 2)
                }
                .opacity(homeExpanded ? 0 : 1)
                .frame(width: 20, height: 20)
                .animation(.linear(duration: 0.05))
            }
            .frame(width: 44, height: 44)
            .background(Color("accentBlue"))
            .clipShape(
                Circle()
            )
            .shadow(radius: rotationOn ? 10 : 0, y: rotationOn ? 4 : 0)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.homeButtonState = value.translation
                        if self.homeButtonState.height < -50 && self.rotationOn == false {
                            self.homeExpanded = true
                        }
                    }
                    .onEnded { value in
                        self.homeButtonState = .zero
                        self.homeExpanded = false
                    }
            )
            .scaleEffect(homeExpanded ? 17 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0))
            Spacer()
        }
        .frame(height: 52)
        .onTapGesture {
            self.rotationOn.toggle()
        }
        .overlay(
            VStack {
                HStack {
                    VStack {
                        Image("teller")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.3, alignment: .top)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        Text("teller.exchange")
                            .font(.caption)
                            .foregroundColor(Color.white)
                    }
                    VStack {
                        Image("Public Chat")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.3, alignment: .top)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        Text("#status")
                            .font(.caption)
                            .foregroundColor(Color.white)
                    }
                    VStack {
                        Image("Group Chat")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.3, alignment: .top)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        Text("Climate change")
                            .font(.caption)
                            .foregroundColor(Color.white)
                    }
                }
            }
            .offset(y: -UIScreen.main.bounds.height * 0.2)
            .opacity(homeExpanded ? 1 : 0)
            .scaleEffect(homeExpanded ? 1 : 0.25, anchor: .bottom)
            .animation(.spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0))
        )
    }
}

struct NavButton: View {
    
    enum buttonType {
        case iconButton
        case imageButton
    }
    var type = buttonType.iconButton
    var icon = "tab_Accounts"
    var asset = "userPic"
    
    var body: some View {
        VStack {
            if type == buttonType.iconButton {
                VStack {
                    Image(icon)
                }
                .frame(width: 40, height: 40)
                .background(BlurView(style: .dark))
                .foregroundColor(Color.white)
                .cornerRadius(20)
            }
            else {
                Image(asset)
                .renderingMode(.original)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(20)
            }
        }
        .frame(width: 52, height: 52)
    }
}

struct NewButton: View {
    @Binding var newToggled : Bool
    
    var body: some View {
        Button(action: { self.newToggled.toggle() }) {
            HStack {
                VStack {
                    Image("Add").foregroundColor(Color.white)
                }
                Text("New")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color.white)
            }
            .frame(height: 40)
            .padding(.horizontal, 12)
            .background(BlurView(style: .dark))
            .cornerRadius(20)
        }
        .frame(height: 52)
        .padding(.horizontal, 12)
    }
}

struct WalletButton: View {
    @Binding var showWallet: Bool
    
    var body: some View {
        Button(action: { self.showWallet = true }) {
            HStack (spacing: 0) {
                Image("tab_Accounts")
                    .foregroundColor(Color.white)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 8)
                Text("1309.24")
                    .font(.system(size: 18.0, weight: .medium, design: .rounded))
                    .foregroundColor(Color.white)
                Text("€")
                    .font(.system(size: 18.0, weight: .light, design: .rounded))
                    .foregroundColor(Color.white)
                    .padding(.leading, 6)
            }
            .frame(height: 40)
            .padding(.horizontal, 16)
            .background(Color("accentBlue"))
            .cornerRadius(24)
            .shadow(radius: 10, y: 4)
        }
        .frame(height: 52)
        .padding(.horizontal, 12)
    }
}

struct Badge: View {
    var number : Int = 8
    
    var body: some View {
        VStack {
            Text(String(number)).font(.system(size: 13.0, weight: .medium, design: .rounded)).foregroundColor(Color.white).padding(.horizontal, 5)
        }
        .frame(minWidth: 20)
        .frame(height: 20)
        .background(Color("notificationBadge"))
        .cornerRadius(10)
    }
}

struct CardView: View {
    @Binding var rotationOn: Bool
    
    var title: String = "title"
    var image: String = "Public Chat"
    var unread: Int = 0
    
    let screen = UIScreen.main.bounds
    let topSafeArea: CGFloat = 44.0
    let bottomSafeArea: CGFloat = 34.0
    
    var body: some View {
        ZStack (alignment: .top){
            Image(image)
                .padding(.bottom, bottomSafeArea)
            HStack (spacing: 0){
                if unread >= 1 {
                    Badge(number: unread).padding(.leading, 8)
                }
                Text(title)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(Color("primaryTextColor"))
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .padding(.horizontal, 12)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color("Grey"))
                }.frame(width:44, height: 44)
            }
            .frame(height: 44.0)
            .background(LinearGradient(gradient: Gradient(colors: [Color("startGradientStop"), Color("endGradientStop")]), startPoint: .top, endPoint: .bottom))
            .shadow(color: Color.black.opacity(0.1), radius: 0, x: 0, y: 1)
            .opacity(rotationOn ? 1: 0)
        }
        .background(Color("backgroundAppearance"))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .edgesIgnoringSafeArea(.all)
    }
}

struct NavigationView: View {
    @Binding var rotationOn: Bool
    @State var currentIndex = 4

    var body: some View {
        let manager = RotateViewManager(axis: .vertical,
                                        currentIndex: $currentIndex,
                                        rotationOn: $rotationOn,
                                        viewList: [
                                            CardView(rotationOn: $rotationOn, title: "uniswap.exchange", image: "uniswap"),
                                            CardView(rotationOn: $rotationOn, title: "climate change huh…", image: "Group Chat"),
                                            CardView(rotationOn: $rotationOn, title: "Chicken, Peter, you’re just a little chicken!", image: "Public Chat", unread: 12),
                                            CardView(rotationOn: $rotationOn, title: "teller.exchange/buy", image: "teller"),
                                            CardView(rotationOn: $rotationOn, title: "Sticker", image: "Private Chat")
                                        ],
                                        spacing: -UIScreen.main.bounds.height * 0.85)
            .background(Color("windowBackground"))
            .edgesIgnoringSafeArea(.all)
        return manager
    }
}

struct RotateScrollPosition: View {
    @Binding var rotationOn: Bool
    @Binding var offset: CGFloat
    var axis: Axis.Set

    init(rotationOn: Binding<Bool>, offset: Binding<CGFloat>, axis: Axis.Set) {
        self._rotationOn = rotationOn
        self._offset = offset
        self.axis = axis
    }

    var body: some View {
        GeometryReader { geometry -> Text in
            if self.rotationOn {
                let newOffset = geometry.frame(in: .global).minY
                if self.offset != newOffset {
                    self.offset = newOffset
                }
            }
            return Text("")
        }.frame(width: 0, height: 0)
    }
}

struct RotateContentView<T: View>: View {
    @Binding var offset: CGFloat
    @Binding var rotationOn: Bool
    @Binding var currentIndex: Int
    private var axis: Axis.Set
    private var viewList: [T]
    private var spacing: CGFloat
    private var blockUserInteractionWhileScrolling: Bool

    init(axis: Axis.Set,
         offset: Binding<CGFloat>,
         currentIndex: Binding<Int>,
         rotationOn: Binding<Bool>,
         viewList: [T],
         spacing: CGFloat,
         blockUserInteractionWhileScrolling: Bool = true) {
        self.axis = axis
        self._offset = offset
        self._currentIndex = currentIndex
        self._rotationOn = rotationOn
        self.viewList = viewList
        self.spacing = spacing
        self.blockUserInteractionWhileScrolling = blockUserInteractionWhileScrolling
    }

    var body: some View {

        var scrollArea: CGFloat {
            let count = CGFloat(viewList.count - 1) == 0 ? 1 : CGFloat(viewList.count - 1)
            return count * (UIScreen.main.bounds.height + spacing)
        }

//        let scrollPosition: CGFloat = -offset / ((scrollArea == 0 ? 1 : scrollArea) / 2) - 1

        return Group {
            RotateScrollPosition(rotationOn: $rotationOn, offset: $offset, axis: self.axis)

            Spacer().frame(height: self.rotationOn ? -self.spacing * 2.2 : 0)

            ForEach(0..<self.viewList.count) { index in
                ZStack {
                    self.viewList[index]
                        .gesture(DragGesture())

                    if self.rotationOn && self.blockUserInteractionWhileScrolling {
                        VStack {
                            HStack {
                                Spacer()
                            }
                            Spacer()
                            }.background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
                            .disabled(true)
                    }
                }
                    .rotation3DEffect(.degrees(self.rotationOn ? Double(-32) : 0), axis: (x: 1, y: 0, z: 0), anchor: .top)
                    .animation(.interpolatingSpring(stiffness: 150, damping: 30))
                    .frame(height: UIScreen.main.bounds.height)
                    .onTapGesture {
                        self.currentIndex = index
                        self.rotationOn = false
                }
            }
        }
    }
}

struct RotateViewManager<T: View>: View {
    @State var offset: CGFloat = 0.0
    @Binding var currentIndex: Int
    @Binding var rotationOn: Bool
    private var axis: Axis.Set
    private var spacing: CGFloat
    private var viewList: [T]
    private var blockUserInteractionWhileScrolling: Bool

    init(axis: Axis.Set = .horizontal,
         currentIndex: Binding<Int>,
         rotationOn: Binding<Bool>,
         viewList: [T],
         spacing: CGFloat = -250,
         blockUserInteractionWhileScrolling: Bool = true) {
        self.axis = axis
        self._currentIndex = currentIndex
        self._rotationOn = rotationOn
        self.viewList = viewList
        self.spacing = spacing
        self.blockUserInteractionWhileScrolling = blockUserInteractionWhileScrolling
    }

    var body: some View {

        var newOffset: CGFloat {
            if rotationOn {
                return 0
            } else {
                var index = currentIndex
                index = index >= viewList.count ? viewList.count - 1 : index
                index = index < 0 ? 0 : index
                let size = UIScreen.main.bounds.height
                return -(offset + size * CGFloat(index) )
            }
        }

        return ZStack {
            ScrollView(axis, showsIndicators: false) {
                VStack(spacing: rotationOn ? spacing : 0) {
                    RotateContentView(axis: axis,
                                      offset: $offset,
                                      currentIndex: $currentIndex,
                                      rotationOn: $rotationOn,
                                      viewList: viewList,
                                      spacing: spacing,
                                      blockUserInteractionWhileScrolling: blockUserInteractionWhileScrolling)
                    }
                .offset(y: newOffset)
            }
            .edgesIgnoringSafeArea([.top, .bottom])
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .animation(.interpolatingSpring(stiffness: 150, damping: 30))
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



