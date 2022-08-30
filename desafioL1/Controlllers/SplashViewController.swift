//
//  SplashViewController.swift
//  desafioL1
//
//  Created by Felipe Tavela on 30/08/22.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.performSegue(withIdentifier: "toMovies", sender: nil)
        }
   }

}
