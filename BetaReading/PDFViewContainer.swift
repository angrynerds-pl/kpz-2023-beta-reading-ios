//
//  PDFKit.swift
//  BetaReading
//
//  Created by Julia Gościniak on 30/05/2023.
//

import Foundation
import SwiftUI
import PDFKit

struct PDFViewContainer: View {
    let pdfURL: URL
    @Environment(\.presentationMode) var presentationMode // Dodane pole @Environment

    var body: some View {
        VStack {
            PDFKitView(url: pdfURL)
                .edgesIgnoringSafeArea(.all)
            Button("Zamknij") {
                presentationMode.wrappedValue.dismiss()// Zamknięcie widoku PDF
            }
            .padding()
        }
    }
}

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        DispatchQueue.global().async {
            let pdfDocument = PDFDocument(url: url)
            DispatchQueue.main.async {
                pdfView.document = pdfDocument
            }
        }
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        if let currentDocument = uiView.document, currentDocument.documentURL != url {
            uiView.document = nil // Resetowanie aktualnego dokumentu
            DispatchQueue.global().async {
                let pdfDocument = PDFDocument(url: url)
                DispatchQueue.main.async {
                    uiView.document = pdfDocument
                }
            }
        }
    }
}
