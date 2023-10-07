import UIKit

class OnboardingPageViewController: UIPageViewController {
    private lazy var viewControllersList: [UIViewController] = {
        let vc1 = OnboardingViewController(image: UIImage(named: "Onboarding1")!, headerTitle: "PodcastApp: Your favorite tracks in one place", title: "Welcome to PodcastApp - a unique podcast app that offers you a limitless world of podcast in the palm of your hand", showGetStarted: false, skipDelegate: self, nextDelegate: self)
        let vc2 = OnboardingViewController(image: UIImage(named: "Onboarding2")!, headerTitle: "Explore a variety of genres with PodcastApp", title: "PodcastApp doesn't just offer a wide range of genres. We strive to make your podcast life as rich and interesting as possible. Our app features podcast from the most diverse corners of the podcast world", showGetStarted: false, skipDelegate: self, nextDelegate: self)
        
        let vc3 = OnboardingViewController(image: UIImage(named: "Onboarding3")!, headerTitle: "Your podcast adventure begins right now", title: "Now that you've familiarized yourself with Podcast's features, it's time to start enjoying podcast. Tap 'Get Started' and discover a new world of podcast possibilities", showGetStarted: true)
        return [vc1, vc2, vc3]
    }()
    
    private lazy var setupPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundStyle = .minimal
        pageControl.numberOfPages = viewControllersList.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .gray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnboardingPage()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUI()
    }
    
    private func setupOnboardingPage() {
        dataSource = self
        delegate = self
        setViewControllers([viewControllersList[0]], direction: .forward, animated: false, completion: nil)
    }

    private func setupUI() {
        view.addSubview(setupPageControl)
        NSLayoutConstraint.activate([
            setupPageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            setupPageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            setupPageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllersList.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard viewControllersList.count > previousIndex else {
            return nil
        }
        
        return viewControllersList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllersList.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let viewControllersCount = viewControllersList.count
        
        guard nextIndex != viewControllersCount else {
            return nil
        }
        
        guard viewControllersCount != nextIndex else {
            return nil
        }
        
        guard viewControllersCount > nextIndex else {
            return nil
        }
        
        return viewControllersList[nextIndex]
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed || !finished {
            if let currentViewController = self.viewControllers?.first,
               let index = viewControllersList.firstIndex(of: currentViewController)
            {
                setupPageControl.currentPage = index
            }
        }
    }
}

extension OnboardingPageViewController: SkipButtonPressedDelegate {
    func skipButtonPressed(in vc: OnboardingViewController) {
        if let lastViewController = viewControllersList.last {
            setViewControllers([lastViewController], direction: .forward, animated: true, completion: nil)
            setupPageControl.currentPage = viewControllersList.count - 1
        }
    }
}

extension OnboardingPageViewController: NextButtonPressedDelegate {
    func nextButtonPressed(in vc: OnboardingViewController) {
        if let currentViewController = viewControllers?.first,
           let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController),
           let currentIndex = viewControllersList.firstIndex(of: currentViewController)
        {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
            
            let newIndex = currentIndex + 1
            setupPageControl.currentPage = newIndex
        }
    }
}
