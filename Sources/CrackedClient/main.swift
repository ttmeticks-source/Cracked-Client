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
    @State private var androidEmulatorProcess: Process? = nil

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
        .alert("Game Launch", isPresented: $launchAlert) {
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
            Text("Choose a free official trial. Bedrock runs through an Android emulator.")
                .foregroundStyle(.gray)

            HStack(spacing: 18) {
                editionCard(title: "Java Edition", subtitle: "Free official demo • Mac", symbol: "laptopcomputer")
                editionCard(title: "Bedrock Edition", subtitle: "Free Android trial • Emulator", symbol: "cube.transparent")
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
        if edition == "Java Edition" {
            launchJavaDemo()
        } else {
            launchBedrockTrial()
        }
    }

    private func launchJavaDemo() {
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
            launchMessage = "The official Minecraft Launcher is not installed. Opening the official download page. Install it in Applications, sign in with a Microsoft account, then choose Play Demo. The Java demo is free and lasts about 100 minutes of in-game time."
            launchAlert = true
            if let url = URL(string: "https://www.minecraft.net/download") {
                NSWorkspace.shared.open(url)
            }
            return
        }

        let configuration = NSWorkspace.OpenConfiguration()
        NSWorkspace.shared.openApplication(at: appURL, configuration: configuration) { _, error in
            DispatchQueue.main.async {
                if let error {
                    launchMessage = "Minecraft Launcher could not be opened: \\(error.localizedDescription)"
                } else {
                    launchMessage = "The official launcher is open. Sign in with a Microsoft account that does not own Java Edition, then choose Play Demo. The free demo is limited to about 100 minutes of in-game time."
                }
                launchAlert = true
            }
        }
    }

    private func launchBedrockTrial() {
        guard let sdkRoot = androidSDKRoot() else {
            launchMessage = "Bedrock has no native macOS release. Its official free trial is the Android app. To run it here, install Android Studio, add the Android Emulator, and create a virtual phone with a Google Play image. This app will detect and start that emulator. Android Studio's download page is opening."
            launchAlert = true
            openAndroidStudioSetup()
            return
        }

        let emulatorURL = sdkRoot.appendingPathComponent("emulator/emulator")
        let adbURL = sdkRoot.appendingPathComponent("platform-tools/adb")
        let fileManager = FileManager.default

        guard fileManager.isExecutableFile(atPath: emulatorURL.path),
              fileManager.isExecutableFile(atPath: adbURL.path) else {
            launchMessage = "The Android SDK was found, but its Emulator or ADB tool is missing. Open Android Studio → SDK Manager and install Android Emulator and Android SDK Platform-Tools."
            launchAlert = true
            openAndroidStudioSetup()
            return
        }

        guard let avdOutput = commandOutput(emulatorURL, arguments: ["-list-avds"]) else {
            launchMessage = "Android Emulator could not list its virtual devices. Open Android Studio and check Device Manager."
            launchAlert = true
            openAndroidStudioSetup()
            return
        }

        let avds = avdOutput
            .components(separatedBy: .newlines)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        guard let playStoreAVD = avds.first(where: { avdHasGooglePlay($0) }) else {
            launchMessage = "No Google Play-enabled Android virtual device was found. In Android Studio → Device Manager, create a phone and choose a system image labelled Google Play. Then press Bedrock Trial again."
            launchAlert = true
            openAndroidStudioSetup()
            return
        }

        let emulatorProcess = Process()
        emulatorProcess.executableURL = emulatorURL
        emulatorProcess.arguments = ["-avd", playStoreAVD]
        emulatorProcess.standardOutput = FileHandle.nullDevice
        emulatorProcess.standardError = FileHandle.nullDevice

        do {
            try emulatorProcess.run()
            androidEmulatorProcess = emulatorProcess
        } catch {
            launchMessage = "Android Emulator failed to start: \\(error.localizedDescription)"
            launchAlert = true
            return
        }

        DispatchQueue.global(qos: .utility).async {
            let deadline = Date().addingTimeInterval(240)
            while Date() < deadline {
                if self.commandOutput(adbURL, arguments: ["-e", "shell", "getprop", "sys.boot_completed"]) == "1" {
                    let playStoreExists = self.commandOutput(adbURL, arguments: ["-e", "shell", "pm", "path", "com.android.vending"]) != nil
                    guard playStoreExists else {
                        DispatchQueue.main.async {
                            self.launchMessage = "The Android emulator started, but its Google Play Store is missing. Shut it down and create a virtual device using a Google Play system image."
                            self.launchAlert = true
                        }
                        return
                    }

                    _ = self.commandOutput(adbURL, arguments: [
                        "-e", "shell", "am", "start",
                        "-a", "android.intent.action.VIEW",
                        "-d", "market://details?id=com.mojang.minecrafttrialpe"
                    ])

                    DispatchQueue.main.async {
                        self.launchMessage = "The Android emulator is ready and the official Minecraft Trial listing has been opened in Google Play. Sign in to Google Play, install Minecraft Trial by Mojang, then launch it inside the emulator. This is the free, time-limited Android Bedrock trial—not a native Mac build."
                        self.launchAlert = true
                    }
                    return
                }
                Thread.sleep(forTimeInterval: 3)
            }

            DispatchQueue.main.async {
                self.launchMessage = "Android Emulator did not finish starting within four minutes. Open Android Studio → Device Manager, start the Google Play virtual device manually, then try again."
                self.launchAlert = true
            }
        }
    }

    private func androidSDKRoot() -> URL? {
        let home = FileManager.default.homeDirectoryForCurrentUser
        var candidates = [
            home.appendingPathComponent("Library/Android/sdk"),
            home.appendingPathComponent("Android/Sdk")
        ]

        for key in ["ANDROID_SDK_ROOT", "ANDROID_HOME"] {
            if let value = ProcessInfo.processInfo.environment[key], !value.isEmpty {
                candidates.insert(URL(fileURLWithPath: value), at: 0)
            }
        }

        return candidates.first {
            FileManager.default.fileExists(atPath: $0.appendingPathComponent("emulator/emulator").path)
        }
    }

    private func avdHasGooglePlay(_ name: String) -> Bool {
        let configURL = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent(".android/avd/\\(name).avd/config.ini")
        guard let config = try? String(contentsOf: configURL, encoding: .utf8) else {
            return false
        }
        let normalized = config
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "\\t", with: "")
            .lowercased()
        return normalized.contains("playstore.enabled=true")
    }

    private func openAndroidStudioSetup() {
        let home = FileManager.default.homeDirectoryForCurrentUser
        let studioCandidates = [
            URL(fileURLWithPath: "/Applications/Android Studio.app"),
            home.appendingPathComponent("Applications/Android Studio.app")
        ]
        if let studio = studioCandidates.first(where: {
            FileManager.default.fileExists(atPath: $0.path)
        }) {
            NSWorkspace.shared.openApplication(at: studio, configuration: NSWorkspace.OpenConfiguration()) { _, _ in }
        } else if let url = URL(string: "https://developer.android.com/studio") {
            NSWorkspace.shared.open(url)
        }
    }

    private func commandOutput(_ executable: URL, arguments: [String]) -> String? {
        let process = Process()
        let output = Pipe()
        process.executableURL = executable
        process.arguments = arguments
        process.standardOutput = output
        process.standardError = FileHandle.nullDevice

        do {
            try process.run()
            let data = output.fileHandleForReading.readDataToEndOfFile()
            process.waitUntilExit()
            guard process.terminationStatus == 0 else { return nil }
            return String(data: data, encoding: .utf8)?
                .trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            return nil
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
