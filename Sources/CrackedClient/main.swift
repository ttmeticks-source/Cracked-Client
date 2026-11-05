
import SwiftUI

@main
struct CrackedClientApp: App {
    var body: some Scene {
        WindowGroup {
            ClientView()
                .frame(minWidth: 850, minHeight: 560)
        }
    }
}

struct ClientView: View {
    @State private var selectedTab = "Home"
    @State private var edition = "Java Edition"
    @State private var fps = true
    @State private var coordinates = true
    @State private var timer = false

    private let tabs = ["Home", "HUD", "Practice", "Settings"]

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                Text("COOLED")
                    .font(.system(size: 25, weight: .black))
                    .foregroundStyle(.cyan)
                    .padding(.bottom, 20)

                ForEach(tabs, id: \.self) { tab in
                    Button {
                        selectedTab = tab
                    } label: {
                        HStack {
                            Image(systemName: icon(for: tab))
                            Text(tab)
                            Spacer()
                        }
                        .padding(12)
                        .background(
                            selectedTab == tab
                            ? Color.cyan.opacity(0.2)
                            : Color.clear
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 9))
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.white)
                }

                Spacer()

                Text("Made by c0oled!")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(18)
            .frame(width: 190)
            .background(Color(red: 0.07, green: 0.08, blue: 0.12))

            VStack(alignment: .leading, spacing: 22) {
                Text(selectedTab.uppercased())
                    .font(.system(size: 27, weight: .bold))
                    .foregroundStyle(.white)

                if selectedTab == "Home" {
                    Text("Minecraft Companion")
                        .font(.title2.bold())
                        .foregroundStyle(.white)

                    Text("Choose your Minecraft edition.")
                        .foregroundStyle(.gray)

                    Picker("Edition", selection: $edition) {
                        Text("Java Edition").tag("Java Edition")
                        Text("Bedrock Edition").tag("Bedrock Edition")
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: 400)

                    Text("Selected: \(edition)")
                        .foregroundStyle(.cyan)
                }

                if selectedTab == "HUD" {
                    Toggle("FPS display preference", isOn: $fps)
                    Toggle("Coordinates preference", isOn: $coordinates)
                }

                if selectedTab == "Practice" {
                    Toggle("Practice timer preference", isOn: $timer)
                    Text("Practice tools can be expanded here.")
                        .foregroundStyle(.gray)
                }

                if selectedTab == "Settings" {
                    Text("Cracked Client settings")
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text("Version 1.0 • macOS")
                        .foregroundStyle(.gray)
                }

                Spacer()
            }
            .padding(32)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 0.10, green: 0.11, blue: 0.16))
        }
        .preferredColorScheme(.dark)
    }

    private func icon(for tab: String) -> String {
        switch tab {
        case "Home": return "house"
        case "HUD": return "rectangle.on.rectangle"
        case "Practice": return "timer"
        default: return "gear"
        }
    }
}
