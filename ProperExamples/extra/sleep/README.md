# Example on synchronization and use of the sleep function

This is a simple example on process synchronization. The program _sleepyFileReader_ takes
a file as argument and will continuously read the first byte of the file and do some action
according to that byte.

The program will read the first byte and act accordingly:
- For 'h'|'H' will print a greeting message.
- For 'T'|'t' will print the current time and date.
- For 'E'|'e'|'X'|'x' will quit.
- For 'L'|'l' will show the list of supported commands.

After reading a byte, it will overwrite it with _0_.

To try this program you should open the file with another program to write commands.

# Synchronization

The way this program synchronize with another process using the same file is by checking
if the first byte is not _0_, evaluating the first byte, writing a _0_ at the beginning of
the file. After each iteration it will _sleep_ by _2_ seconds.

# Suggested problems to solve

1. Extend the functionality of the program so full strings can be used instead of just one byte (character).
2. Make a _writer_ program, instead of relying in a text editor to change the file content.
3. Use _nmap_ instead of using _write_, _read_, and _lseek_.