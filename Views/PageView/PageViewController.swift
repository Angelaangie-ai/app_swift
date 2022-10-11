import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    @Binding var currentPage: Int;
    
    /**
     SwiftUI calls makeCoordinator before makeUIVIewController() so that we have access to the coordinator object when configuring our view controller
     */
    func makeCoordinator() -> Coordinator {
        Coordinator(self);
    }

    // like a POST api
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        
        pageViewController.dataSource = context.coordinator;
        pageViewController.delegate = context.coordinator

        return pageViewController
    }

    // like a PUT api
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
    }
    
    
    /**
     SwiftUI manages your UIViewControllerRepresentable type’s coordinator,
     and provides it as part of the context when calling the methods you created above.
     */
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController;
        var controllers = [UIViewController]()
        
        init (_ pageViewController: PageViewController) {
            parent = pageViewController;
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }
        
        /**
         These two required methods, pageViewController, establish the relationships between view controllers,
         so that you can swipe back and forth between them.
         */
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController)
            else {return nil};
            
            if (index == 0) {
                return controllers.last;
            }
            return controllers[index-1];
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController)
            else {return nil}
            
            if (index + 1 == controllers.count) {
                return controllers.first;
            }
            return controllers[index+1];
        }
        
        
        /**
         SwiftUI will call this method, pageViewControlle from UIPageViewControllerr, whenever a page switching animation completes
         => makes it possible to find the index of the current view controller and update the binding
         */
        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
    }
}
