"""
[Single-Responsibility Principle (SRP)] Implement a simple program to interact with
the library catalog system. Create a Python class Book to represent a single book with
attributes: Title, Author, ISBN, Genre, Availability (whether the book is available for
borrowing or not). Create another Python class LibraryCatalog to manage the
collection of books with following functionalities:
- Add books by storing each book objects (Hint: Create an empty list in constructor
and store book objects)
- get book details and get all books from the list of objects
Lets say, we need a book borrowing process (what books are borrowed and what books
are available for borrowing). Implement logics to integrate this requirement in the above
system. Design the classes with a clear focus on adhering to the Single Responsibility
Principle(SRP) which represents that "A module should be responsible to one, and
only one, actor."
"""

from typing import List, Union

class Book:
    def __init__(self, title: str, author: str, isbn: str, genre: str, availability: bool):
        """
        Initialize a Book object.

        Parameters:
            title (str): Title of the book.
            author (str): Author of the book.
            isbn (str): ISBN of the book.
            genre (str): Genre of the book.
            availability (bool): Whether the book is available for borrowing or not.
        """
        self.title = title
        self.author = author
        self.isbn = isbn
        self.genre = genre
        self.availability = availability

class LibraryCatalog:
    """
    Manages the collection of books in the library catalog.
    """
    def __init__(self):
        """
        Initialize an empty LibraryCatalog with an empty list to store book objects.
        """
        self._books = []
    
    def add_book(self, book: Book) -> None:
        """
        Add a book to the catalog.

        Parameters:
            book (Book): The Book object to be added to the catalog.
        """
        self._books.append(book)
    
    def get_book_details(self, isbn: str) -> Union[Book, None]:
        """
        Get the details of a book by ISBN.

        Parameters:
            isbn (str): The ISBN of the book to retrieve.

        Returns:
            Book or None: The Book object if found, or None if the book is not in the catalog.
        """
        for book in self._books:
            if book.isbn == isbn:
                return book
        return None
    
    def get_all_books(self) -> List[Book]:
        """
        Get a list of all books in the catalog.

        Returns:
            List[Book]: A list containing all Book objects in the catalog.
        """
        return self._books

    def borrow_book(self, isbn: str) -> bool:
        """
        Borrow a book from the catalog.

        Parameters:
            isbn (str): The ISBN of the book to borrow.

        Returns:
            bool: True if the book was successfully borrowed, False otherwise.
        """
        book = self.get_book_details(isbn)
        if book and book.availability:
            book.availability = False
            return True
        return False

    def return_book(self, isbn: str) -> bool:
        """
        Return a borrowed book to the catalog.

        Parameters:
            isbn (str): The ISBN of the book to return.

        Returns:
            bool: True if the book was successfully returned, False otherwise.
        """
        book = self.get_book_details(isbn)
        if book and not book.availability:
            book.availability = True
            return True
        return False

def main():
    library = LibraryCatalog()

    # Adding books to the catalog
    book1 = Book("Title1", "Author1", "ISBN1", "Genre1", True)
    book2 = Book("Title2", "Author2", "ISBN2", "Genre2", False)
    library.add_book(book1)
    library.add_book(book2)

    # Borrowing a book
    isbn_to_borrow = "ISBN2"
    if library.borrow_book(isbn_to_borrow):
        print(f"Book with ISBN '{isbn_to_borrow}' is borrowed.")
    else:
        print(f"Book with ISBN '{isbn_to_borrow}' is not available for borrowing.")

    # Returning a book
    isbn_to_return = "ISBN2"
    if library.return_book(isbn_to_return):
        print(f"Book with ISBN '{isbn_to_return}' is returned.")
    else:
        print(f"Book with ISBN '{isbn_to_return}' was not borrowed.")

    # Getting all books
    all_books = library.get_all_books()
    if all_books:
        print("All books in the catalog:")
        for book in all_books:
            print(f"{book.title} by {book.author}, ISBN: {book.isbn}, Genre: {book.genre}, Availability: {book.availability}")
    else:
        print("No books found in the catalog.")

if __name__ == "__main__":
    main()
    


        
