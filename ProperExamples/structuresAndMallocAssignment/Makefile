# Builds the filterBooks program.
build: 
	gcc filterBooks.c filterBooks_functions.s -o filterBooks

# Builds the filterBooks program adding debugging information.
build-debug:
	gcc -ggdb filterBooks.c filterBooks_functions.s -o filterBooks

# Runs the filterBooks program with a file containing no books
# and something for the author, the program should work correctly.
empty_file = noBooks.txt
author_for_empty = "42"
run-empty: build
	./filterBooks $(empty_file) $(author_for_empty)

# Runs the filterBooks program with a file containing a mix of books from several authors
# and "Isaac Asimov" as author, the program should output 5 books of this author.
mix_file = myBooks.txt
author_for_mix = "Isaac Asimov"
run-mix: build
	./filterBooks $(mix_file) $(author_for_mix)

# Runs the filterBooks program with a file containing only books from Isaac Asimov
# and "Isaac Asimov" as author, the program should output 5 books of this author.
all_asimov_file = asimovBooks.txt
asimov = "Isaac Asimov"
run-allsame: build
	./filterBooks $(all_asimov_file) $(asimov)

# Executes gdb with the filterBooks executable compiled with debugging information.
debug: build-debug
	gdb filterBooks

# Deletes the executable file.
clean:
	rm -f filterBooks
