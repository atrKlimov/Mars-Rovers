//
//  Router.swift
//  Mars Rovers
//
//  Created by Artem Klimov on 11/08/2019.
//  Copyright © 2019 artem. All rights reserved.
//
import UIKit

protocol Animator: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}

protocol Closable: class {
    func close()
}

protocol RouterProtocol: class {
    associatedtype V: UIViewController
    var viewController: V? { get }

    func open(_ viewController: UIViewController, transition: Transition)
}

class Router<U>: RouterProtocol, Closable where U: UIViewController {
    typealias V = U

    weak var viewController: V?
    var openTransition: Transition?

    func open(_ viewController: UIViewController, transition: Transition) {
        transition.viewController = self.viewController
        transition.open(viewController)
    }

    func close() {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = viewController else {
            assertionFailure("Nothing to close.")
            return
        }
        openTransition.close(viewController)
    }
}
