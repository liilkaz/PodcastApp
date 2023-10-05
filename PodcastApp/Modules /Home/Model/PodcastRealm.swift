import Foundation
import RealmSwift

// podcastURL -> link to mp3 file
// imageURL -> link to photo podcast
// title ->  podcast title
// creator -> podcast creator title
// duration -> playback time

class ItemPodcastModel: Object {
    @Persisted var id: Int = 0
    @Persisted var podcastURL: String = ""
    @Persisted var imageURL: String = ""
    @Persisted var title: String = ""
    @Persisted var creator: String = ""
    @Persisted var duration: Int = 0
}

class RealmService {
    private let realm = try! Realm()
    private let podcast = ItemPodcastModel()
    
    
    func checkPodcastInRealm(id: Int, successComletion: @escaping () -> Void, failureCompletion: @escaping () -> Void) {
        let object = realm.objects(ItemPodcastModel.self).filter("id == \(id)")
        object.isEmpty ? failureCompletion() : successComletion()
    }
    
    func savePodcastToRealm(id: Int, podcastURL: String, imageURL: String, title: String, creator: String, duration: Int) {
        checkPodcastInRealm(id: id, successComletion: {
            print("Object with id \(id) already exists in the database.")
        }, failureCompletion: {
            let newPodcast = ItemPodcastModel()
            newPodcast.id = id
            newPodcast.podcastURL = podcastURL
            newPodcast.imageURL = imageURL
            newPodcast.title = title
            newPodcast.creator = creator
            newPodcast.duration = duration
            do {
                try self.realm.write {
                    self.realm.add(newPodcast)
                }
                print("Podcast with id \(id) has been saved to the database.")
            } catch {
                print("Error saving to Realm database: \(error)")
            }
        })
    }
    
    func loadFavoritesPodcastFromRealm() -> [ItemPodcastModel] {
        let podcast = realm.objects(ItemPodcastModel.self)
        return Array(podcast).reversed()
    }
    
    
    
    func deletePodcastFromRealm(id: Int) {
        do {
            if let objectToDelete = realm.objects(ItemPodcastModel.self).filter("id == \(id)").first {
                try realm.write {
                    realm.delete(objectToDelete)
                }
            }
        } catch {
            print("Error deleting object: \(error)")
        }
    }
}
