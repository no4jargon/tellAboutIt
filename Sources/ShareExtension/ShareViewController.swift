import UIKit
import UniformTypeIdentifiers

class ShareViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleInput()
    }

    private func handleInput() {
        guard let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
              let attachments = extensionItem.attachments else {
            completeExtension()
            return
        }

        for provider in attachments {
            if provider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                provider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { [weak self] url, error in
                    guard let self = self, let url = url else {
                        self?.completeExtension()
                        return
                    }
                    self.processVideo(url: url)
                }
                return
            }
        }
        completeExtension()
    }

    private func processVideo(url: URL) {
        guard let data = try? Data(contentsOf: url) else {
            completeExtension()
            return
        }
        captionVideo(videoData: data) { [weak self] caption in
            DispatchQueue.main.async {
                self?.presentShareDialog(videoURL: url, caption: caption)
            }
        }
    }

    private func captionVideo(videoData: Data, completion: @escaping (String) -> Void) {
        var request = URLRequest(url: URL(string: "https://api.twelvelabs.io/v1/caption")!)
        request.httpMethod = "POST"
        request.setValue("Bearer YOUR_API_KEY", forHTTPHeaderField: "Authorization")
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.uploadTask(with: request, from: videoData) { data, response, error in
            var caption = "Generated caption"
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let cap = json["caption"] as? String {
                caption = cap
            }
            completion(caption)
        }
        task.resume()
    }

    private func presentShareDialog(videoURL: URL, caption: String) {
        let activityVC = UIActivityViewController(activityItems: [caption, videoURL], applicationActivities: nil)
        activityVC.completionWithItemsHandler = { [weak self] _, _, _, _ in
            self?.completeExtension()
        }
        self.present(activityVC, animated: true, completion: nil)
    }

    private func completeExtension() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
}
