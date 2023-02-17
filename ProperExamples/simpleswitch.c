int canEnterClassroom(int category) {  
  int result;
  switch(category) {
    case 111:
    case 112:
    case 113: {result = 1; break;}
    case 116:
    case 117: 
    case 118: {result = 0; break;}
    default: return 0;
  }
}
