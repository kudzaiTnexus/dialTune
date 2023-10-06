//
//  RailView.swift
//  dialTune
//
//  Created by KudzaisheMhou on 06/10/2023.
//

import Foundation
import SwiftUI

struct RailView: View {
    var railTitle: String
    var railHeight: CGFloat
    var railWidth: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(railTitle)
                .font(.system(size: 16, weight: .semibold, design: .default))
                .padding(.leading, 12)
                .padding(.top)
            
            CarouselView(
                items: ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8"],
                cellWidth: railWidth,
                cellHeight: railHeight
            ) {
                Text("Item")
                    .background(Color.red)
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
            .frame(height: railHeight)
            Spacer()
        }
    }
}



class CarouselViewController<ItemView: View>: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    private var cellWidth: CGFloat
    private var cellHeight: CGFloat
    
    private let items: [String]
    private let itemView: ItemView
    
    init(items: [String], cellWidth: CGFloat, cellHeight: CGFloat, itemView: @escaping () -> ItemView) {
        self.items = items
        self.cellWidth = cellWidth
        self.cellHeight = cellHeight
        self.itemView = itemView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast  // Improve scroll responsiveness
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let leftInset = (view.bounds.width - 300) / 2
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 16)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item: \(items[indexPath.row])")
    }
}

struct CarouselView<ItemView: View>: UIViewControllerRepresentable {
    var items: [String]
    var cellWidth: CGFloat
    var cellHeight: CGFloat
    var itemView: () -> ItemView
    
    func makeUIViewController(context: Context) -> CarouselViewController<ItemView> {
        return CarouselViewController(items: items, cellWidth: cellWidth, cellHeight: cellHeight, itemView: itemView)
    }
    
    func updateUIViewController(_ uiViewController: CarouselViewController<ItemView>, context: Context) {
        // Update code here if needed
    }
}
