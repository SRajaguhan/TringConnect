//
//  TabBarViewController.swift
//  TringConnect
//
//  Created by Apple on 30/04/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateSelectedItemHighlight()
    }
    
    private func updateSelectedItemHighlight() {
        
        guard let numberOfItems = self.tabBar.items?.count, let highlightTabImage =  TCConstant.selectedTabImage else {
            return
        }
        let tabBarItemSize = CGSize(width: self.tabBar.frame.size.width/CGFloat(numberOfItems), height: self.tabBar.frame.size.height)
        let drawnImage = UIImage.tabHighLightImage(color: .white, size: tabBarItemSize,
                                                 highlightLineSize: TCConstant.highLightLinewRectSize, highLightImage: highlightTabImage)
        tabBar.selectionIndicatorImage = drawnImage
        
    }

}

// MARK: TabBar Delegate Implementation

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateSelectedItemHighlight()
    }
    
}

extension UIImage {
    class func tabHighLightImage(color: UIColor, size: CGSize, highlightLineSize: (Double, Double), highLightImage: UIImage ) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { context in
            context.cgContext.setFillColor(UIColor.clear.cgColor)
            let rectangle = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            context.cgContext.addRect(rectangle)
            context.cgContext.drawPath(using: .fill)
            
            let highLightWidth = highlightLineSize.0
            let xPos = Double(rectangle.width) / 2 - highLightWidth / 2
            let highLightRectangle = CGRect(x: xPos, y: 48, width: highLightWidth, height: highlightLineSize.1)
            context.cgContext.setFillColor(UIColor.clear.cgColor)
            context.cgContext.addRect(highLightRectangle)
            context.cgContext.drawPath(using: .fill)
            let image = highLightImage
            image.draw(in: highLightRectangle)
            
        }
        return image
    }
}
