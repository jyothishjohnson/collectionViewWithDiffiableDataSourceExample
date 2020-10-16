//
//  ViewController.swift
//  collectionviewdiffableDS
//
//  Created by jyothish.johnson on 14/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Sample>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Sample>
    
    var list : [Sample] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeData()
        collectionView.register(UINib(nibName: "DemoCell", bundle: .main), forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        
        applySnapshot(animatingDifferences: false)
        
    }
    
    
    /// Makes a datasource of type UICollectionViewDiffableDataSource<Section, Sample>
    /// using the collectionview and cell provider closure
    /// inside which we asign the data to the view
    /// - Returns: UICollectionViewDiffableDataSource<Section, Sample>
    
    func makeDataSource() -> DataSource {
        
        let dataSource = DataSource(collectionView: collectionView, cellProvider: {(collectionView, indexPath, sample) -> UICollectionViewCell in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DemoCell
            cell.sampleLabel.text = sample.label
            return cell
        })
        return dataSource
    }
    
    
    /// Add random elements to the list
    /// - Parameter rand: This will be initial random number
    
    func makeData(rand : Int = 1){
        
        list = []
        for i in rand...rand+9 {
            var sample = Sample()
            sample.id = i
            sample.label = "No: \(i)"
            list.append(sample)
        }
    }
    
    
    
    /// Apply the data snapshot to the collectionview
    /// - Parameter animatingDifferences: boolean indicating whether to animate the transition of new data snapshot
    
    func applySnapshot(animatingDifferences: Bool = false) {
        
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(list)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        makeData(rand: Int.random(in: 1...10))
        applySnapshot(animatingDifferences: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

enum Section: Int{
    case main
}


/// Model Struct for cell
struct Sample: Hashable{
    
    var id : Int?
    var label : String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Sample, rhs: Sample) -> Bool {
        lhs.id == rhs.id
    }
}


