//
//  JXPagingListRefreshView.swift
//  JXPagingView
//
//  Created by jiaxin on 2018/8/28.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

open class JXPagingListRefreshView: JXPagingView {
    fileprivate var lastScrollingListViewContentOffsetY: CGFloat = 0

    override open func initializeViews() {
        super.initializeViews()

        mainTableView.bounces = false
    }

    override open func preferredProcessMainTableViewDidScroll(_ scrollView: UIScrollView) {
        if pinSectionHeaderVerticalOffset != 0 {
            if scrollView.contentOffset.y == 0 {
                mainTableView.bounces = false
            }else {
                mainTableView.bounces = true
            }
        }
        if (self.currentScrollingListView != nil && self.currentScrollingListView!.contentOffset.y > 0) {
            //mainTableView的header已经滚动不见，开始滚动某一个listView，那么固定mainTableView的contentOffset，让其不动
            self.mainTableView.contentOffset = CGPoint(x: 0, y: getMainTableViewMaxContentOffsetY())
        }

        if (mainTableView.contentOffset.y < getMainTableViewMaxContentOffsetY()) {
            //mainTableView已经显示了header，listView的contentOffset需要重置
            for list in self.validListDict.values {
                //正在下拉刷新时，不需要重置
                if list.listScrollView().contentOffset.y > 0 {
                    list.listScrollView().contentOffset = CGPoint.zero
                }
            }
        }

        if scrollView.contentOffset.y > getMainTableViewMaxContentOffsetY() && self.currentScrollingListView?.contentOffset.y == 0 {
            //当往上滚动mainTableView的headerView时，滚动到底时，修复listView往上小幅度滚动
            self.mainTableView.contentOffset = CGPoint(x: 0, y: getMainTableViewMaxContentOffsetY())
        }
    }
    
    override open func preferredProcessListViewDidScroll(scrollView: UIScrollView) {
        var shouldProcess = true
        if currentScrollingListView!.contentOffset.y > self.lastScrollingListViewContentOffsetY {
            //往上滚动
        }else {
            //往下滚动
            if self.mainTableView.contentOffset.y == 0 {
                shouldProcess = false
            }else {
                if (self.mainTableView.contentOffset.y < getMainTableViewMaxContentOffsetY()) {
                    //mainTableView的header还没有消失，让listScrollView一直为0
                    currentScrollingListView!.contentOffset = CGPoint.zero;
                    currentScrollingListView!.showsVerticalScrollIndicator = false;
                }
            }
        }
        if shouldProcess {
            if (self.mainTableView.contentOffset.y < getMainTableViewMaxContentOffsetY()) {
                //处于下拉刷新的状态，scrollView.contentOffset.y为负数，就重置为0
                if currentScrollingListView!.contentOffset.y > 0 {
                    //mainTableView的header还没有消失，让listScrollView一直为0
                    currentScrollingListView!.contentOffset = CGPoint.zero;
                    currentScrollingListView!.showsVerticalScrollIndicator = false;
                }
            } else {
                //mainTableView的header刚好消失，固定mainTableView的位置，显示listScrollView的滚动条
                self.mainTableView.contentOffset = CGPoint(x: 0, y: getMainTableViewMaxContentOffsetY());
                currentScrollingListView!.showsVerticalScrollIndicator = true;
            }
        }
        self.lastScrollingListViewContentOffsetY = currentScrollingListView!.contentOffset.y;
    }

}
