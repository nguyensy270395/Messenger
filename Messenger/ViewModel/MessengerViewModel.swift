//
//  MessengerViewModel.swift
//  Messenger
//
//  Created by Nguyễn Thanh Sỹ on 25/05/2022.
//

import Foundation
import FirebaseFirestore
import UIKit
import Firebase
import FirebaseStorage

class StorageBaseManager: ObservableObject {
    let storage = Storage.storage()
    func upload(image: UIImage) -> String {
        let name = "images/\(UUID()).jpg"
        let storageRef = storage.reference().child(name)
        let resizedImage = image.resize(withSize: CGSize(width: 200, height: 200), contentMode: .contentAspectFit)
        let data = resizedImage!.jpegData(compressionQuality: 1)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"

        if let data = data {
                storageRef.putData(data, metadata: metadata) { (metadata, error) in
                        if let error = error {
                                print("Error while uploading file: ", error)
                        }
                    print("Metadata:           \(metadata)")
                    self.getURLWithID(id: name)
                }
        }
        return name
    }
    
    func getURLWithID(id: String, completion: ((URL)-> Void)? = nil) {
        let storageRef = storage.reference()
        storageRef.child(id).downloadURL { (urlResult, err) in
            if err != nil {
                print("Error: \(err)")
                return
            }
            print(urlResult)
            completion?(urlResult!)
        }
    }
    func listAllFiles() {
          // Create a reference
          let storageRef = storage.reference().child("images")

          // List all items in the images folder
          storageRef.listAll { (result, error) in
            if let error = error {
              print("Error while listing all files: ", error)
            }

              for item in result!.items {
              print("Item in images folder: ", item)
            }
          }
      }
  
}
class MessengerViewModel:  ObservableObject {
    private var storage = StorageBaseManager()
    @Published private(set) var message: [ContentMessage] = [] {
        didSet {
            if let lastMessageId = message.last?.id {
                self.lastMessageId = lastMessageId
            }
            
        }
    }
    @Published var image = UIImage()
    @Published private(set) var lastMessageId = -1
    @Published var url = URL(string: "")
    let db = Firestore.firestore()
    
    init() {
        getMessage()
    }
    
  
  
    func getMessage() {
        db.collection("messages").addSnapshotListener { [self] querySnapshort, error in
            guard let documents = querySnapshort?.documents else{
                print("Error: \(String(describing: error))")
                return
            }
            
            self.message = documents.compactMap{ documents -> ContentMessage? in
                do{
                    let data = documents.data()
                    return ContentMessage(id: data["id"] as! Int,
                                          image: data["image"] as? String ?? "",
                                          text: data["text"] as! String,
                                          timeStamp: (data["timeStamp"] as! String).toDate(),
                                          from: data["from"] as! Int,
                                          to: data["to"] as! Int)
                } catch {
                    print("Error: \(error)")
                    return nil
                }
            }
            .sorted(by: {$0.timeStamp < $1.timeStamp})
            print(self.message)
        }
    }
    func sendImage() {
        do {
            let messageSend = ContentMessage(id: (message.last?.id ?? 0) + 1, image: storage.upload(image: self.image), text: "", timeStamp: Date(), from: 1, to: 2)
            try? db.collection("messages").document().setData([
                "id"        :   messageSend.id,
                "image"     :   messageSend.image,
                "text"      :   messageSend.text,
                "timeStamp" :   messageSend.timeStamp.dateAndTimetoString(),
                "from"      :   messageSend.from,
                "to"        :   messageSend.to
            ])
        } catch {
            print("Error: \(error)")
        }
        self.image = UIImage()
    }
    
    
    func sendMessage(text: String, toUserId: Int) {
        do {
            let messageSend = ContentMessage(id: (message.last?.id ?? 0) + 1, image: "", text: text, timeStamp: Date(), from: 1, to: 2)
            try? db.collection("messages").document().setData([
                "id"        :   messageSend.id,
                "image"     :   messageSend.image,
                "text"      :   messageSend.text,
                "timeStamp" :   messageSend.timeStamp.dateAndTimetoString(),
                "from"      :   messageSend.from,
                "to"        :   messageSend.to
            ])
        } catch {
            print("Error: \(error)")
        }
    }
}
