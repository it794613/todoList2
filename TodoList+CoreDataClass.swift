//
//  TodoList+CoreDataClass.swift
//  todolist2
//
//  Created by 최진용 on 2022/09/23.
//
//

import Foundation
import CoreData

@objc(TodoList)
public class TodoList: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoList> {
        return NSFetchRequest<TodoList>(entityName: "TodoList")
    }
    
    @NSManaged public var todo: String?
    
}
