#include <stdlib.h>
#include <stdio.h>

typedef struct Book {
    char * author;
    char * tittle;
    int pages;
    int id;
    int isLended;
} Book;

extern Book * filterBooksByAuthor(Book books[], int size, char * author);
extern unsigned int countFilteredBooksByAuthor(Book books[], int size, char * author);
void printBook(Book book);

void main(void) {
    Book b1 = {"Isaac Asimov", "The Caves of Steel", 224, 42, 0};
    Book b2 = {"Isaac Asimov", "The Naked Sun", 187, 43, 0};
    Book b3 = {"Isaac Asimov", "Mirror Image", 82, 101, 1};
    Book b4 = {"Isaac Asimov", "The Robots of Dawn", 419, 44, 1};
    Book b5 = {"Isaac Asimov", "Robots and Empire", 383, 45, 0};
    Book b6 = {"J. R. R. Tolkien", "The Hobbit", 310, 62, 0};
    Book b7 = {"J. R. R. Tolkien", "The Lord of the Rings", 9250, 63, 1};
    Book b8 = {"J. R. R. Tolkien", "The Adventures of Tom Bombadil", 304, 64, 0};
    Book b9 = {"J. R. R. Tolkien", "The Silmarillion", 365, 65, 0};
    Book b10 = {"Douglas Adams", "The Hitchhiker's Guide to the Galaxy", 400, 72, 1};
    Book myBooks[10] = {b1, b2, b3, b4, b5, b6, b7, b8, b9, b10};
    unsigned int iasimovBooksCount = countFilteredBooksByAuthor(myBooks, 10, "Isaac Asimov");
    Book * iasimovBooks = filterBooksByAuthor(myBooks, 10, "Isaac Asimov");
    printf("There are %d books of Isaac Asimov\nBooks:\n", iasimovBooksCount);
    for (int b = 0; b < iasimovBooksCount; b++) {
        printBook(iasimovBooks[b]);
        if (b + 1 < iasimovBooksCount) {
            printf("\n");
        }
    }
}

void printBook(Book book) {
    printf("Author: %s\nTitle: %s\nPages: %d\nID: %d\nIs Lended: %s\n",
        book.author, book.tittle, book.pages, book.id, book.isLended?"TRUE":"FALSE"
    );
}