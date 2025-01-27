import SwiftUI
import WebKit

struct AgreementWebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: urlString) else { return }
        uiView.load(URLRequest(url: url))
    }
}

#Preview {
    AgreementWebView(urlString: "https://yandex.ru/legal/practicum_offer/")
}
