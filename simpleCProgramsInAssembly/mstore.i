# 0 "mstore.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 0 "<command-line>" 2
# 1 "mstore.c"
long mult2(long, long);

void multscore(long x, long y, long *dest) {
  long t = mult2(x, y);
  *dest = t;
}
