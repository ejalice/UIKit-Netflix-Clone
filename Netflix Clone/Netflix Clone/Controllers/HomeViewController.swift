//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by eunji on 2022/07/11.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = ["Trailing Movies", "Popular", "Trending Tv", "Upcoming Movies", "Top rated"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        // frame: .zero -> AutoLayout으로 frame을 잡아주니 .zero를 사용해서 크기가 없도록 함.
        /* style: .grouped
         - 종류: .plain / .grouped / .insetGrouped
         - .plain: 가장 기본 style
         - .grouped: 각 section에 고유한 행들의 그룹이 있음
         - .insetGrouped: 각 section group이 둥근 모서리 형태로 처리된 style.
         */
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        // register: cell 등록 method
        // reuseIdentifier: cell id
        return table
    }()

    override func viewDidLoad() {
        /* viewDidLoad()
         - 실행시, 처음으로 load 되는 것.
         
         * viewDidAppear vs viewDidLoad
         - viewDidAppear(): View가 나타날 때 마다 실행
         - viewDidLoad(): app이 처음으로 load 되었을 때만
         */
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavbar()
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
    }
    
    private func configureNavbar() {
        
        // Original Code -> Image Size가 커서 netflixLogo가 중간으로 옴.
//        var image = UIImage(named: "netflixLogo")
//        image = image?.withRenderingMode(.alwaysOriginal) // use the image as it is
        
        // Fixed Code 1 -> Image Size 조정
//        var image = resizeImage(image: UIImage(named: "netflixLogo")!, targetSize: CGSize(width: 30, height: 30))
//        image = image.withRenderingMode(.alwaysOriginal)
        
        // Original Code & Fixed Code 1
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        
        // Fixed Code 2 -> Button size 조정
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        let logoButton = UIButton()
        logoButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        logoButton.setImage(image, for: .normal)
        logoButton.imageView?.contentMode = .scaleAspectFit
        let leftBarButtonItem = UIBarButtonItem(customView: logoButton)
        let width = leftBarButtonItem.customView?.widthAnchor.constraint(equalToConstant: 30)
            width?.isActive = true
        let height = leftBarButtonItem.customView?.heightAnchor.constraint(equalToConstant: 30)
            height?.isActive = true

        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        /* viewDidLayoutSubview()
         - 다른 view들의 content update 시 사용.
         - view가 update될 때마다 불러짐. -> view size / view layout이 재측정될 때마다 불러짐.
         - view들의 크기나 위치를 최종적으로 결졍.
         - 테이블의 데이터를 reload.
         
         - app 실행시키면, viewDidLayoutSubviews() 는 항상 viewDidLoad() 후에 불러짐. -> layout calculation이 다시될 때마다 불러지기 때문. 핸드폰 회전시켜도 불러짐.
         */
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    /*
     row + row + ... + row = cell
     cell + cell + ... + cell = section
     (header) + section + (footer)+ (header) + section + (footer) +... + section = tableView
     각각의 section은 header와 footer를 가질 수 있음.
     
     결론: row < cell < secton < tableView
     */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeueReusableCell: cell 재사용시 사용하는 method
        // IndexPath: [section, row] -> 행을 식별하는 경로
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // cell height
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // section마다 있는 Header height
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.lowercased()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    // UIImage size 조정 코드 -> 강의에 X
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
}
