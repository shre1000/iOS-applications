

import Foundation
import CoreData


extension Brand {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Brand> {
        return NSFetchRequest<Brand>(entityName: "Brand");
    }

    @NSManaged public var name: String?
    @NSManaged public var candies: NSSet?
    @NSManaged public var location: String?
    @NSManaged public var year: Int64

}

// MARK: Generated accessors for candies
extension Brand {

    @objc(addCandiesObject:)
    @NSManaged public func addToCandies(_ value: Candy)

    @objc(removeCandiesObject:)
    @NSManaged public func removeFromCandies(_ value: Candy)

    @objc(addCandies:)
    @NSManaged public func addToCandies(_ values: NSSet)

    @objc(removeCandies:)
    @NSManaged public func removeFromCandies(_ values: NSSet)

}
