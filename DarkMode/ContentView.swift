//
//  ContentView.swift
//  DarkMode
//
//  Created by YILMAZ ER on 21.05.2023.
//

import SwiftUI

enum Theme {
    static let primary = Color("Primary")
}

enum Assets {
    static let weather = Image("Weather_icon")
}

enum SchemeType: Int, Identifiable, CaseIterable {
    var id: Self { self }
    case system
    case light
    case dark
}

extension SchemeType {
    var title: String {
        switch self {
        case .system:
            return "🖥️ System"
        case .light:
            return "🕯️ Light"
        case .dark:
            return "🌔 Dark"
        }
    }
    var img: Image {
        switch self {
        case .system:
            return Assets.weather
        case .light:
            return Assets.weather
        case .dark:
            return Assets.weather
        }
    }
}

struct ContentView: View {
    @AppStorage("systemThemeVal") private var systemTheme: Int = (SchemeType.allCases.first?.rawValue ?? 0)
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var weatherTxt: String { colorScheme == .light ? "Day time" : "Night time"}
    
    private var selectedScheme: ColorScheme? {
        guard let theme = SchemeType(rawValue: systemTheme) else { return nil }
        switch theme {
        case .light:
            return .light
        case .dark:
            return .dark
        default:
            return nil
        }
    }
    
    var body: some View {
        ZStack{
            Theme.primary.ignoresSafeArea()
            VStack {
                  
                Assets.weather
                    .resizable()
                    .frame(width: 100,height: 100)
                Text(weatherTxt)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Picker(selection: $systemTheme) {
                    ForEach(SchemeType.allCases) { item in
                        Text(item.title)
                        .tag(item.rawValue)
                    }
                } label: {
                    Text("Pick a theme")
                }
                .padding()
                
         
                
                
                List {
                    
                    VStack {
                        Picker("Flavor", selection: $systemTheme) {
                            ForEach(SchemeType.allCases) { item in
                                Text(item.title)
                                    .tag(item.rawValue)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    Picker("Theme", selection: $systemTheme) {
                        HStack{
                            Image("sun")
                                .resizable()
                                .frame(width: 5,height: 5)
                                .padding()
                            Spacer()
                                .frame(width: 50)
                            Text("  Light")
                        }
                        .tag(1)
                        HStack {
                            Image("moon")
                                .padding(.trailing, 18)
                            Text("  Dark")
                        }.tag(2)
                        HStack {
                            Image("system")
                                .padding(.trailing, 18)
                            Text("  System")
                        }
                        .tag(0)
                    }
                }
                
            }
        }
        .preferredColorScheme(selectedScheme)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDisplayName("Inherited")
            ContentView()
                .previewDisplayName("Light Mode")
            .preferredColorScheme(.light)
            ContentView()
                .previewDisplayName("Dark Mode")
            .preferredColorScheme(.dark)
        }
    }
}
