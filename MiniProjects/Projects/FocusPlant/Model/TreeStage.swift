//
//  TreeStage.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 22/6/2569 BE.
//

enum TreeStage: Int {
    case stage1 = 1
    case stage2 = 2
    case stage3 = 3
    case stage4 = 4
    case stage5 = 5

    var imageName: String {
        "tree_stage_\(rawValue)"
    }
}
