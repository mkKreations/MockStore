# MockStore

<p>
  <img src="https://img.shields.io/badge/iOS-13.0+-blue.svg" />
  <img src="https://img.shields.io/badge/Swift-5.0+-brightgreen.svg" />
</p>


<img src="MockStore.gif" height="500">


## Description

MockStore is a custom clone of the iOS App Store! The main purpose is to replicate the collection view layout of 
the App Store to demonstrate the power of Compositional Layout and DiffableDataSource - features introduced in 
iOS 13! The app currently contains the principal collection view layout found in the App Store using JSON data loaded
from the bundle. That data is then presented in a single collection view that has varying cells/layouts based on 
section. 


## Features

- Decodes data from JSON in bundle
- Uses orthogonal scrolling for varying sections
- Protocol conformance to dequeue reusable cells
- Single collection view to maintain varying layouts
- Light/Dark mode compatible


## Feedback

Any and all feedback is welcome - including pull requests.
