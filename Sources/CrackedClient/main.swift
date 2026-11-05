import SwiftUI

@main
struct CrackedClientApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 760, minHeight: 560)
                .preferredColorScheme(.dark)
        }
        .windowStyle(.titleBar)
    }
}

enum MinecraftEdition: String, CaseIterable, Identifiable {
    case java = "Java Edition"
    case bedrock = "Bedrock Edition"

    var id: String { rawValue }

    var subtitle: String {
        switch self {
        case .java: return "Companion settings for Java players"
        case .bedrock: return "Companion settings for Bedrock players"
        }
    }

    var symbol: String {
        switch self {
        case .java: return "cup.and.saucer.fill"
        case .bedrock: return "cube.fill"
        }
    }
}

struct ContentView: View {
    @State private var edition: MinecraftEdition = .java
    @State private var showCoordinates = true
    @State private var showFps = true
    @State private var showClock = false
    @State private var practiceNotes = ""

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.055, green: 0.075, blue: 0.11),
                         Color(red: 0.10, green: 0.13, blue: 0.18)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 22) {
                header

                VStack(alignment: .leading, spacing: 12) {
                    Text("CHOOSE YOUR EDITION")
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .tracking(1.8)
                        .foregroundStyle(.white.opacity(0.55))

                    HStack(spacing: 12) {
                        ForEach(MinecraftEdition.allCases) { item in
                            editionCard(item)
                        }
                    }
                }

                HStack(alignment: .top, spacing: 18) {
                    settingsPanel
                    previewPanel
                }

                Spacer(minLength: 0)

                HStack {
                    Label("Companion mode · no game injection", systemImage: "shield.lefthalf.filled")
                    Spacer()
                    Text("Made by c0oled!")
                        .fontWeight(.semibold)
                }
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(.white.opacity(0.48))
            }
            .padding(28)
        }
        .tint(Color(red: 0.35, green: 0.82, blue: 0.62))
    }

    private var header: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 5) {
                Text("CRACKED CLIENT")
                    .font(.system(size: 25, weight: .black, design: .rounded))
                    .tracking(1.2)
                    .foregroundStyle(.white)
                Text("A lightweight Minecraft companion")
                    .font(.system(size: 13))
                    .foregroundStyle(.white.opacity(0.58))
            }
            Spacer()
            Image(systemName: "square.stack.3d.up.fill")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color(red: 0.35, green: 0.82, blue: 0.62))
                .padding(14)
                .background(.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 15))
        }
    }

    private func editionCard(_ item: MinecraftEdition) -> some View {
        let selected = edition == item
        return Button {
            edition = item
        } label: {
            HStack(spacing: 13) {
                Image(systemName: item.symbol)
                    .font(.system(size: 22, weight: .semibold))
                    .frame(width: 46, height: 46)
                    .background(.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.rawValue)
                        .font(.system(size: 15, weight: .bold))
                    Text(item.subtitle)
                        .font(.system(size: 11))
                        .foregroundStyle(.white.opacity(0.55))
                }
                Spacer()
                if selected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Color(red: 0.35, green: 0.82, blue: 0.62))
                }
            }
            .foregroundStyle(.white)
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(selected ? Color.white.opacity(0.11) : Color.white.opacity(0.045),
                        in: RoundedRectangle(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(selected ? Color(red: 0.35, green: 0.82, blue: 0.62) : .white.opacity(0.09),
                            lineWidth: selected ? 1.5 : 1)
            }
        }
        .buttonStyle(.plain)
    }

    private var settingsPanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("COMPANION SETTINGS")
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .tracking(1.5)
                .foregroundStyle(.white.opacity(0.55))

            settingRow("Coordinates display", detail: "Toggle a sample coordinate readout", value: $showCoordinates)
            settingRow("FPS display", detail: "Show an FPS placeholder in the preview", value: $showFps)
            settingRow("In-game clock", detail: "Show a simple clock placeholder", value: $showClock)

            Divider().overlay(.white.opacity(0.1))

            Text("PRACTICE NOTES")
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .tracking(1.5)
                .foregroundStyle(.white.opacity(0.55))

            TextEditor(text: $practiceNotes)
                .font(.system(size: 12))
                .scrollContentBackground(.hidden)
                .foregroundStyle(.white)
                .padding(8)
                .frame(height: 94)
                .background(.black.opacity(0.18), in: RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white.opacity(0.08)))

            Text("Settings are a local UI preview; they do not modify Minecraft.")
                .font(.system(size: 10))
                .foregroundStyle(.white.opacity(0.42))
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white.opacity(0.055), in: RoundedRectangle(cornerRadius: 18))
    }

    private func settingRow(_ title: String, detail: String, value: Binding<Bool>) -> some View {
        Toggle(isOn: value) {
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.white)
                Text(detail)
                    .font(.system(size: 10))
                    .foregroundStyle(.white.opacity(0.48))
            }
        }
        .toggleStyle(.switch)
    }

    private var previewPanel: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("HUD PREVIEW")
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .tracking(1.5)
                .foregroundStyle(.white.opacity(0.55))

            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 14)
                    .fill(LinearGradient(colors: [Color(red: 0.20, green: 0.34, blue: 0.29),
                                                  Color(red: 0.12, green: 0.22, blue: 0.24)],
                                         startPoint: .top, endPoint: .bottom))
                VStack(alignment: .leading, spacing: 5) {
                    if showFps {
                        Text("FPS: --")
                    }
                    if showCoordinates {
                        Text("XYZ: 120 / 64 / -38")
                    }
                    if showClock {
                        Text("Clock: --:--")
                    }
                }
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(.white)
                .padding(12)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(edition == .java ? "JAVA PREVIEW" : "BEDROCK PREVIEW")
                            .font(.system(size: 9, weight: .bold))
                            .tracking(1.1)
                            .foregroundStyle(.white.opacity(0.65))
                    }
                }
                .padding(12)
            }
            .frame(height: 220)

            Label(edition.subtitle, systemImage: edition.symbol)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white.opacity(0.78))

            Text("Java and Bedrock use different mod and extension systems. This app currently provides a shared companion interface only.")
                .font(.system(size: 11))
                .foregroundStyle(.white.opacity(0.48))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white.opacity(0.055), in: RoundedRectangle(cornerRadius: 18))
    }
}
