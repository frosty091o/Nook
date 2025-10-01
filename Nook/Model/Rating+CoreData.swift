//
//  Rating+CoreData.swift
//  Nook
//
//  Created by Ethan on 1/10/2025.
//

import CoreData

@objc(Rating)
public class Rating: NSManagedObject {}

extension Rating {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rating> {
        NSFetchRequest<Rating>(entityName: "Rating")
    }

    @NSManaged public var id: String
    @NSManaged public var spotId: String
    @NSManaged public var noise: Int16
    @NSManaged public var wifi: Int16
    @NSManaged public var power: Int16
    @NSManaged public var seating: Int16
    @NSManaged public var comment: String?
    @NSManaged public var createdAt: Date
    @NSManaged public var spot: Spot?
}

extension Rating {
    static func create(
        in ctx: NSManagedObjectContext,
        spotId: String,
        noise: Int16, wifi: Int16, power: Int16, seating: Int16,
        comment: String?
    ) -> Rating {
        let r = Rating(context: ctx)
        r.id = UUID().uuidString
        r.spotId = spotId
        r.noise = noise
        r.wifi = wifi
        r.power = power
        r.seating = seating
        r.comment = comment
        r.createdAt = Date()
        return r
    }
}
