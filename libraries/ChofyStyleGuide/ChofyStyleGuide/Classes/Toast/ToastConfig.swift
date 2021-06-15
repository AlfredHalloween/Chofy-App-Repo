//
//  ToastView.swift
//  Toast
//
//  Created by Philippe Weidmann on 20.12.20.
//

import UIKit
import QuartzCore

public class ChofyToast {
    public static func showToast(title: String,
                                 tintColor: UIColor = ChofyColors.textObscure,
                                 isWarning: Bool = false) {
        let icon: UIImage = (isWarning ? ChofyIcons.failedCheck : ChofyIcons.okCheck).withRenderingMode(.alwaysTemplate)
        let iconTintColor: UIColor = isWarning ? ChofyColors.failedColor : ChofyColors.okColor
        let toast = ToastView(title: title,
                              titleFont: ChofyFontCatalog.bodyMedium,
                              textColor: ChofyColors.textObscure,
                              backgroundColor: ChofyColors.card,
                              icon: icon,
                              iconTintColor: iconTintColor,
                              cornerRadius: 12)
        toast.show()
    }
}

public class ToastView: UIView {

    public override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    private var cornerRadius: CGFloat
    private var textColor: UIColor
    private var hStack: UIStackView
    private var onTap: (() -> ())?

    /// Hide the view automatically after showing ?
    public var autoHide = true
    /// Display time for the notification view in seconds
    public var displayTime: TimeInterval = 3
    /// Hide the view automatically on tap ?
    public var hideOnTap = true

    public init(title: String,
                titleFont: UIFont = .systemFont(ofSize: 13, weight: .regular),
                subtitle: String? = nil,
                subtitleFont: UIFont = .systemFont(ofSize: 11, weight: .light),
                textColor: UIColor = UIColor.white,
                backgroundColor: UIColor = UIColor.black,
                icon: UIImage? = nil,
                iconTintColor: UIColor = UIColor.black,
                iconSpacing: CGFloat = 16,
                cornerRadius: CGFloat = 8,
                onTap: (() -> ())? = nil) {
        hStack = UIStackView(frame: CGRect.zero)
        self.cornerRadius = cornerRadius
        self.textColor = textColor
        super.init(frame: CGRect.zero)
        self.backgroundColor = backgroundColor
        getContainer()?.addSubview(self)
        getContainer()?.bringSubviewToFront(self)
        hStack.spacing = iconSpacing
        hStack.axis = .horizontal
        hStack.alignment = .center

        let vStack = UIStackView(frame: CGRect.zero)
        vStack.axis = .vertical
        vStack.alignment = .center

        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.numberOfLines = 0
        titleLabel.font = titleFont
        titleLabel.text = title
        titleLabel.textColor = textColor
        vStack.addArrangedSubview(titleLabel)

        if let icon = icon {
            let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
            iconImageView.image = icon
            iconImageView.tintColor = iconTintColor
            hStack.addArrangedSubview(iconImageView)
        }

        if let subtitle = subtitle {
            let subtitleLabel = UILabel(frame: CGRect.zero)
            if #available(iOS 13.0, *) {
                subtitleLabel.textColor = .secondaryLabel
            } else {
                subtitleLabel.textColor = .lightGray
            }
            subtitleLabel.numberOfLines = 0
            subtitleLabel.font = subtitleFont
            subtitleLabel.text = subtitle
            subtitleLabel.textColor = textColor
            vStack.addArrangedSubview(subtitleLabel)
        }

        self.onTap = onTap
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGestureRecognizer)

        hStack.addArrangedSubview(vStack)
        addSubview(hStack)

        setupConstraints()
        setupStackViewConstraints()

        transform = CGAffineTransform(translationX: 0, y: -100)
    }

    @available(iOS 10.0, *)
    public func show(haptic: UINotificationFeedbackGenerator.FeedbackType? = nil) {
        if let hapticType = haptic {
            UINotificationFeedbackGenerator().notificationOccurred(hapticType)
        }
        show()
    }

    public func show() {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
            self.transform = .identity
        }) { [self] (completed) in
            if autoHide {
                hide(after: displayTime)
            }
        }
    }

    public func hide(after time: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.transform = CGAffineTransform(translationX: 0, y: -120)
            }) { (completed) in
                self.removeFromSuperview()
            }
        })
    }

    private func getContainer() -> UIView? {
        return UIApplication.shared.keyWindow
    }

    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        let centerConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .topMargin, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: superview, attribute: .leadingMargin, multiplier: 1, constant: 8)
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: superview, attribute: .trailingMargin, multiplier: 1, constant: -8)
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        superview?.addConstraints([leadingConstraint, trailingConstraint, centerConstraint, topConstraint])
    }

    private func setupStackViewConstraints() {
        hStack.translatesAutoresizingMaskIntoConstraints = false

        let leadingConstraint = NSLayoutConstraint(item: hStack, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 16)
        let trailingConstraint = NSLayoutConstraint(item: hStack, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -16)
        let topConstraint = NSLayoutConstraint(item: hStack, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 16)
        let bottomConstraint = NSLayoutConstraint(item: hStack, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -16)

        addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }

    private func setupShadow() {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 1
    }

    @objc private func didTap() {
        if hideOnTap {
            hide(after: 0)
        }
        onTap?()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
