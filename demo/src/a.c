#include <stdio.h>

extern void print_msg(char *msg);

int main(void)
{
  print_msg("Hello World");

#ifdef FOO
  printf("FOO = %d\n", FOO);
#endif
}
