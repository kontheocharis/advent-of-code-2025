#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char input[8192];
char buf[256];

int main(int c, char **args)
{
  scanf("%s", input);

  char *a, *b;

  char *idx = strtok_r(input, ",", &a);
  long total = 0;

  while (idx != NULL)
  {
    char *idx2 = strtok_r(idx, "-", &b);
    long start = atol(idx2);
    idx2 = strtok_r(NULL, "-", &b);
    long end = atol(idx2);

    for (long i = start; i <= end; i++)
    {
      memset(buf, 0, 256);
      sprintf(buf, "%ld", i);
      long len = strlen(buf);

      if (len % 2 != 0)
        continue;

      for (long j = 0; j < len / 2; ++j)
      {
        if (buf[j] != buf[j + len / 2])
        {
          goto valid;
        }
      }
      printf("found invalid: %ld\n", i);
      total += i;
    valid:
      continue;
    }

    idx = strtok_r(NULL, ",", &a);
  }

  printf("%ld\n", total);

  return 0;
}
