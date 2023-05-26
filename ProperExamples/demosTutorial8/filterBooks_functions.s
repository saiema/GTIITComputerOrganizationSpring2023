.global filterBooksByAuthor
.type filterBooksByAuthor function

.text

/*
 .EQU BOOK_SIZE, ???
 .EQU AUTHOR_OFFSET, ???

*/
/*
Given an array of books, a size, and a string representing a particular author.
This function will return an array of pointers to those books that belong to the requested author.
The returned array must end with a 0 to denote it's ending

The returned array must be allocated into the heap, and it will have one more element than the amount of
books returned to allocate the 0 at the end.
*/
filterBooksByAuthor:
    /*TODO: implement*/
