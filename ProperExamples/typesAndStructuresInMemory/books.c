#include <stdlib.h>
#include <stdio.h>

struct Book {
    char * title;   //8 bytes in total (64 bits)
    char * author;  //8 bytes in total (64 bits)
    int bookID;     //4 bytes in total (32 bits)
    int isLended;   //4 bytes in total (32 bits)
    int lastUserID; //4 bytes in total (32 bits)
};

void printBook(struct Book book);
void printBooks(struct Book * books, int size);
void initializeBooks(struct Book * books, int size);

void main(void) {
    printf("Size of Book is %ld\n", sizeof(struct Book));
    struct Book myBooks[10];
    initializeBooks(myBooks, 10);
    printBooks(myBooks, 10);
    myBooks[4].title = "The Hitchhiker's Guide to the Galaxy";
    myBooks[4].author = "Douglas Adams";
    myBooks[4].bookID = 42;
    myBooks[4].isLended = 0;
    myBooks[4].lastUserID = -1;
    printBooks(myBooks, 5);
}

void initializeBooks(struct Book * books, int size) {
    for (int i = 0; i < size; i++) {
        books[i].title = "N/A";
        books[i].author = "N/A";
        books[i].bookID = -1;
        books[i].isLended = 0;
        books[i].lastUserID = -1;
    }
}

void printBooks(struct Book * books, int size) {
    for (int i = 0; i < size; i++) {
        printBook(books[i]);
        if (i + 1 < size) {
            printf("\n");
        }
    }
}

void printBook(struct Book book) {
    printf("Title: %s\n", book.title);
    printf("Author: %s\n", book.author);
    printf("Book ID: %d\n", book.bookID);
    printf("Is the book lended? %s\n", book.isLended?"YES":"NO");
    printf("ID of the last user: %d\n", book.lastUserID);
}