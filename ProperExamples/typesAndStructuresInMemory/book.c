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

void main(void) {
    printf("Size of Book is %ld\n", sizeof(struct Book));
    struct Book myBook;
    myBook.title = "The Hitchhiker's Guide to the Galaxy";
    myBook.author = "Douglas Adams";
    myBook.bookID = 42;
    myBook.isLended = 0;
    myBook.lastUserID = -1;
    printBook(myBook);
}

void printBook(struct Book book) {
    printf("Title: %s\n", book.title);
    printf("Author: %s\n", book.author);
    printf("Book ID: %d\n", book.bookID);
    printf("Is the book lended? %s\n", book.isLended?"YES":"NO");
    printf("ID of the last user: %d\n", book.lastUserID);
}