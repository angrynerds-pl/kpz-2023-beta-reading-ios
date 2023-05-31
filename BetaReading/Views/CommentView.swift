//
//  CommentView.swift
//  BetaReading
//
//  Created by Julia Gościniak on 31/05/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


struct CommentView: View {
    @State private var comment = ""
    let textId: String // Add this property

    var body: some View {
        VStack {
            Text("Add Comment")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            TextField("Enter your comment", text: $comment)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)

            Button("Post") {
                postComment()
            }
            .padding()

            Spacer()
        }
    }

    private func postComment() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("User is not logged in.")
            return
        }

        let commentData: [String: Any] = [
            "textId": textId, // Use the provided textID
            "author": currentUserID,
            "comment": comment
        ]

        let db = Firestore.firestore()
        db.collection("Comments").addDocument(data: commentData) { error in
            if let error = error {
                print("Error posting comment: (error.localizedDescription)")
            } else {
                print("Comment posted successfully!")
            }
        }

        // Reset comment field
        comment = ""
    }
}

