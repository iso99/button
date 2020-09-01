
//

import UIKit
import SnapKit

enum AddToCartButtonState {
    case loading, normal, outOfStock
}

class AddToCartButtonView: UIButton {
    
    private lazy var plusLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.font = .getLocalizedFont(type: .bold(14))
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        return view
    }()
    
    
    private lazy var whiteCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(plusLabel)
        view.addSubview(loadingIndicator)
        return view
    }()
    
    
    private lazy var buttonTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .getLocalizedFont(type: .medium(12))
        lbl.text = "Add to cart"
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        configure(.normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configure(.normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        configure(.normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        whiteCircle.makeCircular()
        makeCircular()
    }
    
    private func setupViews() {
        addSubview(whiteCircle)
        addSubview(buttonTitle)
        let inset = CGFloat(4)
        
        whiteCircle.snp.makeConstraints { (make) in
            make.trailing.top.bottom.equalToSuperview().inset(inset)
            make.width.equalTo(whiteCircle.snp.height)
        }
        
        plusLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        buttonTitle.snp.makeConstraints { (make) in
            make.center.equalToSuperview().offset(whiteCircle.bounds.width)
        }
    }
}


extension AddToCartButtonView {
    func configure(_ state: AddToCartButtonState) {
        switch state {
        case .loading:
            loadingIndicator.startAnimating()
            plusLabel.isHidden = true
            isUserInteractionEnabled = false
            backgroundColor = #colorLiteral(red: 0.1890185773, green: 0.7043585777, blue: 0.2574312389, alpha: 1)
        case .outOfStock:
            plusLabel.text = "∅"
            backgroundColor = .black
            isUserInteractionEnabled = false
        case .normal:
            loadingIndicator.stopAnimating()
            plusLabel.isHidden = false
            backgroundColor = #colorLiteral(red: 0.9616089463, green: 0.520662725, blue: 0.2854938507, alpha: 1)
            isUserInteractionEnabled = true
        }
    }
}


extension UIView {
    func makeCircular() {
        layer.cornerRadius = min(bounds.height, bounds.width) * 0.5
        clipsToBounds = true
        if #available(iOS 13.0, *) {
            layer.cornerCurve = .circular
        }
        layoutIfNeeded()
    }
}
