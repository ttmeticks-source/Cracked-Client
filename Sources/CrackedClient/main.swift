import SwiftUI
import AppKit

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
    @State private var hasChosenEdition = false
    @State private var launchAlert = false
    @State private var launchMessage = ""

    private let tabs = ["Home", "HUD", "Practice", "Settings"]

    var body: some View {
        Group {
            if hasChosenEdition {
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
            } else {
                versionChooser
            }
        }
        .preferredColorScheme(.dark)
        .alert("Minecraft Launcher", isPresented: $launchAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(launchMessage)
        }
    }

    private var versionChooser: some View {
        VStack(spacing: 28) {
            Spacer()
            Text("COOLED")
                .font(.system(size: 34, weight: .black, design: .rounded))
                .foregroundStyle(.cyan)
            Text("CHOOSE YOUR EDITION")
                .font(.system(size: 25, weight: .bold))
                .foregroundStyle(.white)
            Text("Select which Minecraft version to use.")
                .foregroundStyle(.gray)

            HStack(spacing: 18) {
                editionCard(title: "Java Edition", subtitle: "PC • Java", symbol: "laptopcomputer")
                editionCard(title: "Bedrock Edition", subtitle: "Cross-platform", symbol: "cube.transparent")
            }
            .frame(maxWidth: 620)

            Text("You can change your choice next time you launch the app.")
                .font(.caption)
                .foregroundStyle(.gray)
            Spacer()
            Text("Made by c0oled!")
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .padding(36)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.10, green: 0.11, blue: 0.16))
    }

    private func editionCard(title: String, subtitle: String, symbol: String) -> some View {
        Button {
            edition = title
            hasChosenEdition = true
            launchSelectedEdition()
        } label: {
            VStack(spacing: 14) {
                Image(systemName: symbol)
                    .font(.system(size: 38))
                    .foregroundStyle(.cyan)
                Text(title)
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, minHeight: 170)
            .background(.white.opacity(0.06), in: RoundedRectangle(cornerRadius: 16))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.cyan.opacity(0.55), lineWidth: 1))
        }
        .buttonStyle(.plain)
    }

    private func launchSelectedEdition() {
        guard edition == "Java Edition" else {
            launchMessage = "Minecraft Bedrock Edition does not have an official macOS release, so this app cannot launch it on this Mac. Choose Java Edition to launch the native Mac version."
            launchAlert = true
            return
        }

        let fileManager = FileManager.default
        let candidates = [
            URL(fileURLWithPath: "/Applications/Minecraft.app"),
            fileManager.homeDirectoryForCurrentUser.appendingPathComponent("Applications/Minecraft.app"),
            URL(fileURLWithPath: "/Applications/Minecraft Launcher.app"),
            fileManager.homeDirectoryForCurrentUser.appendingPathComponent("Applications/Minecraft Launcher.app")
        ]

        let installedApp = candidates.first { fileManager.fileExists(atPath: $0.path) }
            ?? NSWorkspace.shared.urlForApplication(withBundleIdentifier: "com.mojang.minecraftlauncher")

        guard let appURL = installedApp else {
            launchMessage = "Minecraft Java Edition was not found. Install the official Minecraft Launcher for macOS, then choose Java Edition again."
            launchAlert = true
            return
        }

        let configuration = NSWorkspace.OpenConfiguration()
        NSWorkspace.shared.openApplication(at: appURL, configuration: configuration) { _, error in
            DispatchQueue.main.async {
                if let error {
                    launchMessage = "Minecraft could not be opened: \\(error.localizedDescription)"
                    launchAlert = true
                }
            }
        }
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
