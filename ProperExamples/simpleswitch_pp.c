# 0 "simpleswitch.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 0 "<command-line>" 2
# 1 "simpleswitch.c"
int canEnterClassroom(int category) {
  int result;
  switch(category) {
    case 301:
    case 302:
    case 303: {result = 1; break;}
    case 102:
    case 103: {result = 0; break;}
    default: return 0;
  }
}
