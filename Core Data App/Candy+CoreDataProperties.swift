
import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy");
    }
    
    @nonobjc public class func mFetchRequest() -> NSFetchRequest<Candy> {
        return (getContext().persistentStoreCoordinator?.managedObjectModel.fetchRequestTemplate(forName: "MCandyRequest"))!.copy() as! NSFetchRequest<Candy>
    }

    @NSManaged public var name: String?
    @NSManaged public var brand: Brand?
    @NSManaged public var price: Double
    @NSManaged public var number: Int64
}
