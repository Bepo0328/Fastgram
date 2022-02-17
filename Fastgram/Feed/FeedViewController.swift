//
//  FeedViewController.swift
//  Fastgram
//
//  Created by 전윤현 on 2022/02/16.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    
    private var feeds: [Feed] = []
    private var limit = 10
    private var isLoadingContent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = self.tableView.frame.width + 120
        self.initialize()
        self.setupRefreshControl()
    }
}

extension FeedViewController {
    @objc func initialize() {
        loadContents(reset: true)
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(initialize), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    func loadContents(reset: Bool = false) {
        fetchMoreContent(completion: { [weak self] feeds in
            guard let weakSelf = self else { return }
            
            if reset {
                weakSelf.feeds = feeds
            } else {
                weakSelf.feeds.append(contentsOf: feeds)
            }
            
            let finishFetching = weakSelf.limit <= weakSelf.feeds.count
            
            if finishFetching {
                self?.tableView.tableFooterView?.frame = .zero
            } else {
                self?.tableView.tableFooterView?.frame = CGRect(x: 0, y: 0, width: weakSelf.tableView.frame.width, height: 50)
            }
            
            weakSelf.isLoadingContent = false
            weakSelf.tableView.reloadData()
            weakSelf.tableView.refreshControl?.endRefreshing()
            
            if reset {
                weakSelf.playMovieIfNeeded()
            }
        })
    }
    
    private func fetchMoreContent(completion: @escaping (([Feed]) -> ())) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let feeds = (1...3).map({ _ in Feed.createRandom() })
            completion(feeds)
        })
    }
}

extension FeedViewController {
    private func playMovieIfNeeded() {
        var alreadyPlaying = false
        tableView.visibleCells.compactMap({ $0 as? MoviePlayable }).forEach({
            let isPlayable = $0.isPlayable(with: self.tableView)
            
            if isPlayable && alreadyPlaying == false {
                $0.resume()
                alreadyPlaying = true
            } else {
                $0.pause()
            }
        })
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        let feed = feeds[indexPath.row]
        
        cell.feed = feed
        
        return cell
    }
}

extension FeedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let shouldLoadMoreContents = scrollView.contentOffset.y + scrollView.frame.height - 30 > scrollView.contentSize.height
        let haveMoreContents = feeds.count < limit
        
        if shouldLoadMoreContents && haveMoreContents && isLoadingContent == false {
            isLoadingContent = true
            loadContents(reset: false)
        }
        
        playMovieIfNeeded()
    }
}
