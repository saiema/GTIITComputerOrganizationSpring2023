/*
Books filtering app.

This program read books from a file and print out those that match a specific author.

Arguments:

The book's file: A file containing one line per book, ending with a new line character, and with the format: string,string,int,int,int
                 Strings can be of up to 40 characters, and they don't require quotes (simple or double).

The author to filter: The full name of an author, this name will be used as is and the filtering is case sensitive.
*/
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>

#define STRING_MAX 40
#define BOOKS_MAX 40

/*
Definition of Book, the isLended field is considered as a boolean value (0 for False, not 0 for True)
*/
typedef struct Book {
    char title[STRING_MAX];
    char author[STRING_MAX];
    int pages;
    int id;
    int isLended;
} Book;

/*
Given an array of books, a size, and a string representing a particular author.
This function will return an array of pointers to those books that belong to the requested author.
The returned array must end with a 0 to denote it's ending
*/
extern Book ** filterBooksByAuthor(Book * books, int size, char * author);

/*
Prints a Book into standard output
*/
void printBook(const Book * book);

/*
Given a file name, and one already created array.
This function will parse books from the file and stored them in the provided array.
The result is how many books were loaded, or -1 if there was an error when opening the file.
*/
int parseBooksFromFile(char * file, Book books[BOOKS_MAX]);

int main(int argc, char ** argv) {
    if (argc != 3) {
        printf("Wrong usage\nUsage: ./filterBooks <path to books file> <author to filter>\n");
        return 1;
    }
    char * booksFile = argv[1];
    char * authorToFilter = argv[2];
    Book myBooks[BOOKS_MAX];
    int booksRead = parseBooksFromFile(booksFile, myBooks);
    if (booksRead < 0) {
        printf("An error occurred while trying to open file %s\n", booksFile);
        return 2;
    }
    printf("Books read: %d\n", booksRead);
    Book ** authorBooks = filterBooksByAuthor(myBooks, booksRead, authorToFilter);
    printf("Filtered books for author %s:\n", authorToFilter);
    int current = 0;
    while (authorBooks[current]) {
        printBook(authorBooks[current]);
        current++;
        if (authorBooks[current]) printf("\n");
    }
    printf("Amount of filtered books for author %s: %d\n", authorToFilter, current);
    return 0;
}

void printBook(const Book * book) {
    printf("Author: %s\nTitle: %s\nPages: %d\nID: %d\nIs Lended: %s\n",
        book->author, book->title, book->pages, book->id, book->isLended?"TRUE":"FALSE"
    );
}

int parseBooksFromFile(char * file, Book books[BOOKS_MAX]) {
    FILE* filepointer = fopen(file, "r");
    if (!filepointer) {
        return -1;
    }
    int ret = 0;
    int i = 0;
    while (ret != EOF && i < BOOKS_MAX) {
        ret = fscanf(
            filepointer,
            "%40[^,],%40[^,],%d,%d,%d\n",
            books[i].author,
            books[i].title,
            &books[i].pages,
            &books[i].id,
            &books[i].isLended
        );
        if (ret != EOF) {
            i++;
        }
    }
    return i;
}