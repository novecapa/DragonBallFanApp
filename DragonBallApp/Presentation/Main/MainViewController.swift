//
//  MainViewController.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import UIKit

final class MainViewController: UIViewController {

    static let identifier = "MainViewController"

	var viewModel: MainViewModelProtocol!

	// MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.viewReady()
    }

    override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		viewModel.viewDidAppear()
    }

    private func setupBindings() {
        // Do bindings setup
    }
}
