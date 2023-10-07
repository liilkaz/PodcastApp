import UIKit

protocol SkipButtonPressedDelegate: NSObject {
    func skipButtonPressed(in vc: OnboardingViewController)
}

protocol NextButtonPressedDelegate: NSObject {
    func nextButtonPressed(in vc: OnboardingViewController)
}

class OnboardingViewController: UIViewController {
    weak var skipDelegate: SkipButtonPressedDelegate?
    weak var nextDelegate: NextButtonPressedDelegate?
    
    private var showGetStarted: Bool = false
    private lazy var onboardingImage = UIImageView(cornerRadius: 150)
    private lazy var onboardingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 250/255, alpha: 1)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerTitle = UILabel(font: .boldSystemFont(ofSize: 25), textColor: .darkGray, textAlignment: .left, numberOfLines: 0)
    private lazy var onboardingTitle = UILabel(font: .systemFont(ofSize: 15), textColor: .gray, textAlignment: .left, numberOfLines: 0)
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(text: "Skip", textColor: .black, backgroundColor: .clear, cornerRadius: 0)
        button.addTarget(self, action: #selector(skipButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(text: "Next", textColor: .black, backgroundColor: .white, cornerRadius: 25)
        button.addTarget(self, action: #selector(nextButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var getStartedButton: UIButton = {
        let button = UIButton(text: "Get Started", textColor: .white, backgroundColor: .systemBlue, cornerRadius: 25)
        button.addTarget(self, action: #selector(getStartedButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.backgroundColor = .white
        setupUI()
    }
    
    init(image: UIImage, headerTitle: String, title: String, showGetStarted: Bool, skipDelegate: SkipButtonPressedDelegate? = nil, nextDelegate: NextButtonPressedDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.skipDelegate = skipDelegate
        self.nextDelegate = nextDelegate
        self.showGetStarted = showGetStarted
        self.onboardingImage.image = image
        self.headerTitle.text = headerTitle
        self.onboardingTitle.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        skipDelegate?.skipButtonPressed(in: self)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        nextDelegate?.nextButtonPressed(in: self)
    }
    @IBAction func getStartedButtonPressed(_ sender: UIButton) {
        let vc = LoginViewController()
        navigationController?.setViewControllers([vc], animated: false)
        
    }
    
    private func setupUI() {
        view.addSubviews(onboardingImage, onboardingView, headerTitle, onboardingTitle)
        if !showGetStarted {
            view.addSubviews(skipButton, nextButton)
            setupMainUI()
            setupSkipAndNextButton()
        } else {
            view.addSubview(getStartedButton)
            setupMainUI()
            setupGetStartedButton()
        }
    }
    
    private func setupMainUI() {
        NSLayoutConstraint.activate([
            onboardingImage.heightAnchor.constraint(equalToConstant: 300),
            onboardingImage.widthAnchor.constraint(equalToConstant: 300),
            onboardingImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            onboardingView.heightAnchor.constraint(equalToConstant: 360),
            onboardingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27)
        ])
        
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: onboardingView.topAnchor, constant: 30),
            headerTitle.leadingAnchor.constraint(equalTo: onboardingView.leadingAnchor, constant: 30),
            headerTitle.trailingAnchor.constraint(equalTo: onboardingView.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            onboardingTitle.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 30),
            onboardingTitle.leadingAnchor.constraint(equalTo: onboardingView.leadingAnchor, constant: 30),
            onboardingTitle.trailingAnchor.constraint(equalTo: onboardingView.trailingAnchor, constant: -30)
        ])
    }
    
    private func setupSkipAndNextButton() {
        NSLayoutConstraint.activate([
            skipButton.heightAnchor.constraint(equalToConstant: 50),
            skipButton.topAnchor.constraint(equalTo: onboardingTitle.bottomAnchor, constant: 30),
            skipButton.leadingAnchor.constraint(equalTo: onboardingView.leadingAnchor, constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 85),
            nextButton.topAnchor.constraint(equalTo: onboardingTitle.bottomAnchor, constant: 30),
            nextButton.trailingAnchor.constraint(equalTo: onboardingView.trailingAnchor, constant: -30)
        ])
    }
    
    private func setupGetStartedButton() {
        NSLayoutConstraint.activate([
            getStartedButton.heightAnchor.constraint(equalToConstant: 50),
            getStartedButton.topAnchor.constraint(equalTo: onboardingTitle.bottomAnchor, constant: 30),
            getStartedButton.leadingAnchor.constraint(equalTo: onboardingView.leadingAnchor, constant: 30),
            getStartedButton.trailingAnchor.constraint(equalTo: onboardingView.trailingAnchor, constant: -30)
        ])
    }
}

