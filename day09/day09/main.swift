//
//  main.swift
//  day09
//
//  Created by Tyler Kieft on 1/1/19.
//  Copyright © 2019 Tyler Kieft. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func getOrInsert(_ key: Key, valueCreator:() -> Value) -> Value {
        if let value = self[key] {
            return value
        } else {
            let value = valueCreator()
            self[key] = value
            return value
        }
    }
}

class Edge {
    let node: Node
    let cost: Int

    init(_ node: Node, cost: Int) {
        self.node = node
        self.cost = cost
    }
}

class Node: Hashable {

    let name: String
    var edges = [Edge]()

    init(_ name: String) {
        self.name = name
    }

    func addEdge(_ edge: Edge) {
        edges.append(edge)
    }

    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

// Comparison function that orders Edges by cost
let costFunc = {(e1: Edge, e2: Edge) -> Bool in e1.cost < e2.cost }

// Find either the lowest cost or highest cost path
func findPath(cities: [String: Node], max: Bool) -> Int {
    var pathCost = max ? Int.min : Int.max
    
    for (_, node) in cities {
        var unvisitedNodes = Set<Node>(cities.values)
        unvisitedNodes.remove(node)
        
        var costs = [Node:Int]()
        costs[node] = 0
        
        var currentNode = node
        
        while unvisitedNodes.count != 0 {
            let nextEdges = currentNode.edges.filter({ (edge) -> Bool in unvisitedNodes.contains(edge.node) })
            let nextEdge = max ? nextEdges.max(by: costFunc)! : nextEdges.min(by: costFunc)!
            costs[nextEdge.node] = costs[currentNode]! + nextEdge.cost
            currentNode = nextEdge.node
            unvisitedNodes.remove(currentNode)
        }
        
        if max ? (costs[currentNode]! > pathCost) : (costs[currentNode]! < pathCost) {
            pathCost = costs[currentNode]!
        }
    }
    
    return pathCost
}

let file = CommandLine.arguments[1]
let fileData = try String(contentsOfFile: file).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
let lines = fileData.components(separatedBy: CharacterSet.newlines)

var cities = [String: Node]()

// Parse Input
for line in lines {
    let nodes = line.components(separatedBy: CharacterSet.whitespaces)

    let n1 = cities.getOrInsert(nodes[0]) { () -> Node in Node(nodes[0]) }
    let n2 = cities.getOrInsert(nodes[2]) { () -> Node in Node(nodes[2]) }

    n1.addEdge(Edge(n2, cost: Int(nodes[4])!))
    n2.addEdge(Edge(n1, cost: Int(nodes[4])!))
}


print(findPath(cities: cities, max: false))
print(findPath(cities: cities, max: true))
