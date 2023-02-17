# 0 "operationEvaluator.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 0 "<command-line>" 2
# 1 "operationEvaluator.c"
# 9 "operationEvaluator.c"
int executeOperation(unsigned int op, int initval) {
    int val = initval;
    switch (op) {
        case 0x0:
            return val;
        case 0x1:
            val++;
            break;
        case 0x2:
            val--;
            break;
        case 0x3:
            val *= 2;
            break;
        case 0x4:
            val /= 2;
            break;
        case 0x5:
            val += 7;
            break;
        case 0x6:
            val = -val;
            break;
        default:
            return val;
    }
}
