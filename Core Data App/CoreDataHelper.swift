//
//  CoreDataHelper.swift
//  CoreDataOlemissDemo
//
//  Created by Morgan Dock on 4/2/17.
//  Copyright © 2017 Morgan Dock. All rights reserved.
//

import UIKit
import CoreData

func getContext () -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
}

func getBackgroundContext () -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.newBackgroundContext()
}

func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.persistentContainer.performBackgroundTask(block)
}

func saveContext(context: NSManagedObjectContext){
    do {
        try context.save()
        print("saved!")
    } catch let error as NSError  {
        print("Could not save \(error), \(error.userInfo)")
    }
}

func getBrand(name: String, location: String, year: Int64) -> Brand{
    let context = getContext()
    
    let newBrand = Brand(context: context)
    
    newBrand.name = name
    newBrand.location = location
    newBrand.year = year
    saveContext(context: context)
    return newBrand
    
}

func saveCandy (name: String,price: Double, number: Int64, brand: Brand) {
    let context = getContext()
    
    let entity =  NSEntityDescription.entity(forEntityName: "Candy", in: context)
    
    let transc = NSManagedObject(entity: entity!, insertInto: context)
    
    transc.setValue(name, forKey: "name")
    transc.setValue(price, forKey: "price")
    transc.setValue(number, forKey: "number")
    
    saveContext(context: context)
}

func saveCandyv2 (name: String, brand: Brand) {
    let context = getContext()
    
    let newName = Candy(context: context)
    
    newName.name = name
    newName.brand = brand
    
    saveContext(context: context)
}
