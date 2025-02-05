//
//  CustomSplashViewController.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import UIKit

final class CustomSplashViewController: UIViewController {

    private enum Constants {
        static let imageSquare: CGFloat = 240
        static let animationDuration: Double = 0.75
        static let bottomAnchorLabel: CGFloat = 40
    }

    var viewModel: CustomSplashViewModel!

    private lazy var imageSplash: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = .load(.splash)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = .zero
        return imageView
    }()

    lazy private var labelVersion: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .notoSans(.regular(12))
        label.text = viewModel.appVersion
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    init() {
        super.init(nibName: nil, bundle: Bundle(for: CustomSplashViewController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAnimation()
    }

    private func setupView() {
        self.view.addSubview(imageSplash)
        self.view.addSubview(labelVersion)
        NSLayoutConstraint.activate([
            imageSplash.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageSplash.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageSplash.widthAnchor.constraint(equalToConstant: Constants.imageSquare),
            imageSplash.heightAnchor.constraint(equalToConstant: Constants.imageSquare),
            labelVersion.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.view.bottomAnchor.constraint(equalTo: labelVersion.bottomAnchor, constant: Constants.bottomAnchorLabel)
        ])
    }

    private func setupAnimation() {
        UIView.animate(withDuration: Constants.animationDuration, animations: { [weak self] in
            self?.imageSplash.alpha = 1.0
        }, completion: { [weak self] _ in
            UIView.animate(withDuration: Constants.animationDuration, animations: {
                self?.imageSplash.alpha = 0.0
            }, completion: { [weak self] _ in
                UIView.animate(withDuration: Constants.animationDuration, animations: {
                    self?.imageSplash.alpha = 1.0
                }, completion: { [weak self] _ in
                    UIView.animate(withDuration: Constants.animationDuration, animations: {
                        self?.imageSplash.alpha = 0.0
                    }, completion: { [weak self] _ in
                        self?.viewModel.showMainView()
                    })
                })
            })
        })
    }
}
