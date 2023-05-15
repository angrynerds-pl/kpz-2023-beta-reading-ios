import Foundation
import FirebaseFirestore
import FirebaseCore
import Combine
import Firebase


class HomeViewModel: ObservableObject{

    @Published var list = [HomeModel]()
    func getData(){

        let db = Firestore.firestore()
        db.collection("Text").getDocuments{snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map{ d in
                            return HomeModel(id: d.documentID,
                                             title: d["title"] as? String ?? "",
                                             author: d["author"] as? String ?? "")
                        }
                    }

                }
            }
            else{

            }
        }
    }
}
