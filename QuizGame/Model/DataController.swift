

import Foundation
import CoreData


class DataController {
    
    static let shared = DataController()
    private init() {}
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    lazy var context=persistentContainer.viewContext
    
    
    
    func fetchQuizes() -> [QuizCD]? {
        let request: NSFetchRequest<QuizCD> = QuizCD.fetchRequest()
    
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let context = DataController.shared.persistentContainer.viewContext

        let quizes = try? context.fetch(request)
        return quizes
    }
  
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        
        let entityName=String(describing: objectType)
    
        let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do{
            //neka vrati objekte i ako je prazan, pomocu ?? pod naredbe, vratiti ce nil
            let fetchedObjects=try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        }catch{
            print(error)
            //ako se dogodila greska vrati nill
            return [T]()
        }
        
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }
    
    func saveContext () {
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("SAVED")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
