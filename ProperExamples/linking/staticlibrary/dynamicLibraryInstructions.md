# Compiling and running demo using a dynamic library

First start by compiling both `string.s` and `stdutils.s` with:

```Bash
gcc -c -z noexecstack string.s -o string.o
gcc -c -z noexecstack stdutils.s -o stdutils.o
gcc -shared -z noexecstack -o libastd.so string.o stdutils.o
```

After that compile `demo.s` using the just generated `astd` shared library with:

```Bash
gcc -o demo -z noexecstack -z lazy -z norelro demo.s -L "$PWD" -l astd
```

_note: the `-z lazy -z norelro` flags are use to ensure that address resolution will be done only when a function from a dynamic library is called_

To execute the program, first you need to set the `LD_LIBRARY_PATH` environment variable

```Bash
export LD_LIBRARY_PATH="."
```

_note: this will only work on the current bash session_

Finally execute `./demo (string)*` where `(string)*` means _"zero or more strings"_.
