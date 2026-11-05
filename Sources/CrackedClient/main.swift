import SwiftUI

@main
struct CrackedClientApp: App {
    var body: some Scene {
        WindowGroup {
            ClientView()
                .frame(minWidth: 850, minHeight: 560)
        }
        .windowStyle(.titleBar)
    }
}

struct ClientView: View {
    @AppStorage("selectedEdition") private var edition = "Java Edition"
    @AppStorage("showFPS") private var showFPS = true
    @AppStorage("showCoordinates") private var showCoordinates = true
    @AppStorage("practiceTimerEnabled") private var practiceTimer = false
    @AppStorage("practiceNotes") private var practiceNotes = ""

    @State private var selectedTab = "Home"

    private let tabs = ["Home", "HUD", "Practice", "Settings"]

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                Text("COOLED")
                    .font(.system(size: 25, weight: .black, design: .rounded))
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
                        .background(selectedTab == tab ? Color.cyan.opacity(0.2) : Color.clear)
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
                    Text("Choose which edition your companion settings are for.")
                        .foregroundStyle(.gray)

                    Picker("Edition", selection: $edition) {
                        Text("Java Edition").tag("Java Edition")
                        Text("Bedrock Edition").tag("Bedrock Edition")
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: 420)

                    HStack(spacing: 12) {
                        Image(systemName: "cube.transparent")
                            .font(.system(size: 34))
                            .foregroundStyle(.cyan)
                        VStack(alignment: .leading) {
                            Text(edition).font(.headline).foregroundStyle(.white)
                            Text("Selected profile").font(.caption).foregroundStyle(.gray)
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: 420, alignment: .leading)
                    .background(.white.opacity(0.06), in: RoundedRectangle(cornerRadius: 12))
                }

                if selectedTab == "HUD" {
                    Toggle("FPS display preference", isOn: $showFPS)
                    Toggle("Coordinates display preference", isOn: $showCoordinates)
                    Text("These switches are saved preferences in this companion app. They do not read live game data or draw an in-game overlay.")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }

                if selectedTab == "Practice" {
                    Toggle("Practice timer enabled", isOn: $practiceTimer)
                    Text("Practice notes")
                        .font(.headline)
                        .foregroundStyle(.white)
                    TextEditor(text: $practiceNotes)
                        .font(.body)
                        .scrollContentBackground(.hidden)
                        .padding(8)
                        .frame(minHeight: 180)
                        .background(.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 10))
                }

                if selectedTab == "Settings" {
                    Text("Cracked Client")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                    Text("Version 1.0 • macOS 13+")
                        .foregroundStyle(.gray)
                    Text("Settings are stored locally on this Mac. Java and Bedrock use different mod ecosystems; choosing an edition here does not install mods.")
                        .foregroundStyle(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer()
                Text("Made by c0oled!  •  Companion utility only")
                    .font(.caption)
                    .foregroundStyle(.gray)
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
