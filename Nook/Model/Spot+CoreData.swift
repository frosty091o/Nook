//
//  Untitled.swift
//  Nook
//
//  Created by Ethan on 1/10/2025.
//

import CoreData

@objc(Spot)
public class Spot: NSManagedObject {}

extension Spot {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Spot> {
        NSFetchRequest<Spot>(entityName: "Spot")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var type: String?
    @NSManaged public var ratingAvg: Double
    @NSManaged public var wifi: Int16
    @NSManaged public var noise: Int16
    @NSManaged public var power: Int16
    @NSManaged public var seating: Int16
    @NSManaged public var isFavourite: Bool
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var ratings: NSSet?
}

extension Spot {
    static func create(
        in ctx: NSManagedObjectContext,
        id: String,
        name: String,
        lat: Double,
        lon: Double,
        type: String? = nil
    ) -> Spot {
        let s = Spot(context: ctx)
        s.id = id
        s.name = name
        s.lat = lat
        s.lon = lon
        s.type = type
        s.ratingAvg = 0
        s.wifi = 0
        s.noise = 0
        s.power = 0
        s.seating = 0
        s.isFavourite = false
        s.lastUpdated = Date()
        return s
    }
}

// MARK: Generated accessors for ratings
extension Spot {
    @objc(addRatingsObject:)
    @NSManaged public func addToRatings(_ value: Rating)

    @objc(removeRatingsObject:)
    @NSManaged public func removeFromRatings(_ value: Rating)

    @objc(addRatings:)
    @NSManaged public func addToRatings(_ values: NSSet)

    @objc(removeRatings:)
    @NSManaged public func removeFromRatings(_ values: NSSet)
}
