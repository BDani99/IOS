//
//  MovieListView.swift
//  Intern
//
//  Created by Zoltan Vinkler on 23/05/2023.
//

import SwiftUI

struct MovieListView: View {
    @EnvironmentObject var dataSource: DataSource
    @State private var selectedMovie: Movie?
    @State private var sortDescriptor: MovieSortDescriptor?
    
    var body: some View {
        NavigationView {
            VStack {
                if !dataSource.movies.isEmpty {
                    List {
                        ForEach(dataSource.movies.sorted(by: sortDescriptor?.sortClosure ?? { $0.title < $1.title })) { movie in
                            HStack {
                                AsyncImage(url: movie.thumbnail)
                                
                                VStack {
                                    Text(movie.title).frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(String(movie.year)).foregroundColor(Color.gray).frame(maxWidth: .infinity, alignment: .leading)                                }
                                
                                Text(String(movie.rating)).frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .onTapGesture {
                                selectedMovie = movie
                            }
                        }
                        .onDelete(perform: delete)
                    }
                } else if !dataSource.errorMessage.isEmpty {
                    Text(dataSource.errorMessage)
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Movies")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            sortDescriptor = .title(ascending: true)
                        }) {
                            Label("Title (Ascending)", systemImage: "arrow.up")
                        }
                        
                        Button(action: {
                            sortDescriptor = .title(ascending: false)
                        }) {
                            Label("Title (Descending)", systemImage: "arrow.down")
                        }
                        
                        Button(action: {
                            sortDescriptor = .rating(ascending: true)
                        }) {
                            Label("Rating (Ascending)", systemImage: "arrow.up")
                        }
                        
                        Button(action: {
                            sortDescriptor = .rating(ascending: false)
                        }) {
                            Label("Rating (Descending)", systemImage: "arrow.down")
                        }
                        
                        Button(action: {
                            sortDescriptor = .year(ascending: true)
                        }) {
                            Label("Year (Ascending)", systemImage: "arrow.up")
                        }
                        
                        Button(action: {
                            sortDescriptor = .year(ascending: false)
                        }) {
                            Label("Year (Descending)", systemImage: "arrow.down")
                        }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
            .sheet(item: $selectedMovie) { movie in
                MovieDetailView(movie: movie)
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        dataSource.movies.remove(atOffsets: offsets)
    }
}


enum MovieSortDescriptor {
    case title(ascending: Bool)
    case rating(ascending: Bool)
    case year(ascending: Bool)
    
    var sortClosure: (Movie, Movie) -> Bool {
        switch self {
        case let .title(ascending):
            return ascending ? { $0.title < $1.title } : { $0.title > $1.title }
        case let .rating(ascending):
            return ascending ? { $0.rating < $1.rating } : { $0.rating > $1.rating }
        case let .year(ascending):
            return ascending ? { $0.year < $1.year } : { $0.year > $1.year }
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
