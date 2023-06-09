//
//  MovieDetailView.swift
//  Intern
//
//  Created by Zoltan Vinkler on 23/05/2023.
//

import SwiftUI

struct MovieDetailView: View {
    var movie: Movie
    
    var body: some View {
        Spacer()
        VStack {
            //AsyncImage(url: movie.thumbnail)
            AsyncImage(url:  movie.thumbnail) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100.0, height: 148.9)
            HStack{
                Text(movie.title)
                    .font(.title).padding(.top, 20)
                
                Text(String(movie.year))
                    .foregroundColor(Color.gray).padding(.top, 23)
            }
            Text(String(movie.rating)).frame(width: 45, height: 45).background(Color.yellow).cornerRadius(15)
            Spacer()
        }
        .padding()
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




