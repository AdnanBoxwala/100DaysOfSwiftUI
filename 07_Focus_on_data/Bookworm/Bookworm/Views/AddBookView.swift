//
//  AddBookView.swift
//  Bookworm
//
//  Created by Adnan Boxwala on 20.10.23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @FocusState private var textFieldIsFocussed: Bool
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = "Your review"
    let placeholderReviewText = "Your review"
    
    let genres = ["", "Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                        .focused($textFieldIsFocussed)
                    TextField("Author's name", text: $author)
                        .focused($textFieldIsFocussed)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section {
                    TextEditor(text: $review)
                        .foregroundStyle(review == placeholderReviewText ? .gray : .primary)
                        .onTapGesture {
                            review = review == placeholderReviewText ? "" : review
                        }
                        .focused($textFieldIsFocussed)
                    
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        
                        try? moc.save()
                        dismiss()
                    }
                }
                .disabled(allFieldsValid == false)
            }
            .navigationTitle("Add Book")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        review = review == "" ? placeholderReviewText : review
                        textFieldIsFocussed = false
                    }
                }
            }
        }
    }
    
    var allFieldsValid: Bool {
        return title.isNotEmpty && author.isNotEmpty && genre.isNotEmpty && review.isNotEmpty && review != placeholderReviewText
    }
}

#Preview {
    AddBookView()
}
