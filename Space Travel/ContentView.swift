//
//  ContentView.swift
//  Space Travel
//
//  Created by Erdinç Yılmaz on 15.02.2026.
//

import SwiftUI
import WebKit
import UIKit

struct ContentView: View {
    var body: some View {
        TabView {
            GameScreen()
                .tabItem {
                    Label("Oyun", systemImage: "gamecontroller.fill")
                }

            HowToPlayScreen()
                .tabItem {
                    Label("Nasıl Oynanır", systemImage: "list.bullet.rectangle")
                }

            AboutScreen()
                .tabItem {
                    Label("Hakkında", systemImage: "info.circle.fill")
                }
        }
        .background(Color.black.ignoresSafeArea())
        .toolbarBackground(.black, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
    }
}

private struct GameScreen: View {
    private let gameURL = URL(string: "https://space-travele.netlify.app/")!

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            GameWebView(url: gameURL)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
        }
    }
}

private struct HowToPlayScreen: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.black, Color(red: 0.06, green: 0.07, blue: 0.12)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    VStack(spacing: 12) {
                        Text("Nasıl Oynanır")
                            .font(.system(size: 34, weight: .bold))

                        Text("Oyunun Amacı")
                            .font(.system(size: 22, weight: .semibold))

                        Text("Her seviyede belirlenen Işık Yılı hedefine ulaşmak için yıldızları topla, engellerden kaç ve Küçük Prens’i güvenle bir sonraki bölüme taşı.")
                            .foregroundStyle(.secondary)
                    }

                    infoSection(
                        title: "Kontroller ve Hareket",
                        icon: "gamecontroller.fill",
                        lines: [
                            "Tam Özgürlük: Küçük Prens’i ekranda istediğin yöne (yukarı, aşağı, sağ, sol) serbestçe kaydırabilirsin.",
                            "Kıvrak Manevra: Hızla gelen engellerden kaçarken aynı zamanda rotanı yıldızlara doğru kırmalısın."
                        ]
                    )

                    infoSection(
                        title: "Puanlama ve Seviyeler",
                        icon: "sparkles",
                        lines: [
                            "Yıldız = Enerji: Topladığın her 1 Yıldız, sana +1 Işık Yılı kazandırır.",
                            "Hedefe Ulaş: Seviyeyi geçmek için o bölüme özel Işık Yılı hedefini tamamla.",
                            "Yeni Başlangıç: Bir seviye bittiğinde sayacın sıfırlanır ve yeni bir macera başlar."
                        ]
                    )

                    infoSection(
                        title: "Hayatta Kalma: Koruma Kalkanı",
                        icon: "shield.fill",
                        lines: [
                            "Kalkan Varsa Güvendesin: Kalkanın aktifken Ay veya Uzaylılara çarpsan bile yanmazsın.",
                            "Tek Kullanımlık: Bir engele çarptığında kalkanın kırılır ve seni korur.",
                            "Dikkat: Kalkanın yokken bir engele çarparsan seviyeye en baştan başlarsın."
                        ]
                    )

                    infoSection(
                        title: "Kaçman Gereken Tehlikeler",
                        icon: "exclamationmark.triangle.fill",
                        lines: [
                            "Aylar: Gökyüzünde süzülen devasa kütleler.",
                            "Uzaylılar: Beklenmedik anlarda çıkan gizemli düşmanlar."
                        ]
                    )
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 24)
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(Color.white.opacity(0.16), lineWidth: 1)
                )
                .padding(18)
            }
        }
    }

    @ViewBuilder
    private func infoSection(title: String, icon: String, lines: [String]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                Text(title)
                    .font(.system(size: 20, weight: .semibold))
            }
            ForEach(lines, id: \.self) { line in
                Text("• \(line)")
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white.opacity(0.05))
        )
    }
}

private struct AboutScreen: View {
    private var buildNumber: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "-"
    }

    private var versionNumber: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "-"
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.black, Color(red: 0.06, green: 0.07, blue: 0.12)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Spacer(minLength: 24)
                VStack(spacing: 18) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.08))
                            .frame(width: 74, height: 74)
                        Image(systemName: "applelogo")
                            .font(.system(size: 34, weight: .semibold))
                    }

                    Text("Hakkında")
                        .font(.system(size: 34, weight: .bold))

                    VStack(spacing: 10) {
                        infoRow(title: "Versiyon", value: versionNumber)
                        infoRow(title: "Build", value: buildNumber)
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 24)
                .frame(maxWidth: 340)
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(Color.white.opacity(0.16), lineWidth: 1)
                )
                Spacer()
            }
        }
    }

    @ViewBuilder
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
        .font(.system(size: 19))
    }
}

private struct GameWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let appInstallID = AppInstallIDProvider.current()

        let scriptSource = """
        window.APP_INSTALL_ID = "\(appInstallID)";
        try {
            localStorage.setItem("APP_INSTALL_ID", "\(appInstallID)");
        } catch (e) {}
        """

        let contentController = WKUserContentController()
        let script = WKUserScript(
            source: scriptSource,
            injectionTime: .atDocumentStart,
            forMainFrameOnly: false
        )
        contentController.addUserScript(script)

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.scrollView.bounces = false
        webView.backgroundColor = .black
        webView.isOpaque = true

        let request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        webView.load(request)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        // Initial load in makeUIView is enough for this screen.
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(appInstallID: AppInstallIDProvider.current())
    }

    final class Coordinator: NSObject, WKNavigationDelegate {
        private let appInstallID: String

        init(appInstallID: String) {
            self.appInstallID = appInstallID
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            let js = """
            window.APP_INSTALL_ID = "\(appInstallID)";
            try {
                localStorage.setItem("APP_INSTALL_ID", "\(appInstallID)");
            } catch (e) {}
            """
            webView.evaluateJavaScript(js)
        }
    }
}

private enum AppInstallIDProvider {
    private static let key = "APP_INSTALL_ID"
    private static let plistKey = "APP_INSTALL_ID"

    static func current() -> String {
        if let provided = Bundle.main.object(forInfoDictionaryKey: plistKey) as? String,
           !provided.isEmpty {
            UserDefaults.standard.set(provided, forKey: key)
            return provided
        }

        if let existing = UserDefaults.standard.string(forKey: key), !existing.isEmpty {
            return existing
        }

        let installID = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        UserDefaults.standard.set(installID, forKey: key)
        return installID
    }
}
