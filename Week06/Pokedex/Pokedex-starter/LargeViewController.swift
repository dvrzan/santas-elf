/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class LargeViewController: UIViewController {
  
  @IBOutlet weak var largeCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Pokemon>!

    override func viewDidLoad() {
        super.viewDidLoad()

      largeCollectionView.collectionViewLayout = configureLayout()
      configureDataSource()
    }
  
  //MARK: - Collection view data source
   enum Section {
     case main
   }
   
   func configureLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.7))
     let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
     
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0))
     let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
     //group.interItemSpacing = .fixed(5)
     
     let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous
     
     return UICollectionViewCompositionalLayout(section: section)
   }
   
   func configureDataSource() {
     dataSource = UICollectionViewDiffableDataSource<Section, Pokemon>(collectionView: self.largeCollectionView) {
       (collectionView, indexPath, pokemon) -> UICollectionViewCell? in
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeCell.reuseIdentifier, for: indexPath) as? LargeCell else {
         fatalError("Unable to create cell")
       }
       let pokemonImage = UIImage(named: "\(pokemon.pokemonID)")
       cell.pokemonImageView.image = pokemonImage
       cell.layer.cornerRadius = cell.bounds.width / 20
       cell.pokemonNameLabel.text = pokemon.pokemonName
      cell.pokemonExpLabel.text = pokemon.baseExp.description
      cell.pokemonHeightLabel.text = pokemon.height.description
      cell.pokemonWeightLabel.text = pokemon.weight.description
      
       
       return cell
     }
     var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>()
     initialSnapshot.appendSections([.main])
     let pokemons = PokemonGenerator.shared.generatePokemons()
     initialSnapshot.appendItems(pokemons)
     
     dataSource.apply(initialSnapshot, animatingDifferences: false)
   }

}
