#define OP_HALT     110
#define OP_INC      111
#define OP_DEC      112
#define OP_MUL2     113
#define OP_DIV2     114
#define OP_ADD7     115
#define OP_NEG      116

int executeOperation(unsigned int op, int initval) {
    int val = initval;
    switch (op) {
        case OP_HALT:
            return val;
        case OP_INC:
            val++;
            break;
        case OP_DEC:
            val--;
            break;
        case OP_MUL2:
            val *= 2;
            break;
        case OP_DIV2:
            val /= 2;
            break;
        case OP_ADD7:
            val += 7;
            break;
        case OP_NEG:
            val = -val;
            break;
        default:
            return val;
    }
}
