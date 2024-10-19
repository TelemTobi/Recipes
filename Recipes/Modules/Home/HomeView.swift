//
//  HomeView.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    let viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .loading:
                ProgressView()
                
            case let .loaded(recipes):
                List(recipes) { recipe in
                    Button {
                        viewModel.onRecipeTap(recipe)
                    } label: {
                        RecipeListItem(recipe: recipe)
                    }
                }
                .listStyle(.inset)
                
            case .error:
                errorView()
            }
        }
        .navigationTitle("Recipes")
        .onFirstAppear { viewModel.onAppear() }
        .animation(.smooth, value: viewModel.viewState)
    }
    
    private func errorView() -> some View {
        VStack {
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .foregroundStyle(.secondary)
                .frame(width: 75, height: 75)
            
            Text("Whoops")
                .font(.title)
                .fontWeight(.medium)
            
            Text("Something went wrong...")
                .font(.body)
                .fontWeight(.regular)
                .foregroundStyle(.secondary)
            
            Button {
                viewModel.onTryAgainButtonTap()
            } label: {
                Text("Try again")
                    .font(.body)
                    .padding(.horizontal)
            }
            .padding(.horizontal)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding(.top, 5)
        }
    }
}
