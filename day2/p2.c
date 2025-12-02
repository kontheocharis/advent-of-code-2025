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

      for (long div = 2; div <= len; ++div)
      {
        if (len % div != 0)
          continue;

        for (long k = 0; k < len / div; ++k)
        {

          int saved = -1;
          for (long j = 0; j < div; ++j)
          {

            int idx = j * len / div + k;
            int curr = buf[idx] - '0';
            if (saved == -1)
            {
              saved = curr;
            }
            else
            {
              if (curr != saved)
              {
                goto outer;
              }
            }
          }
        }
        total += i;
        goto invalid;

      outer:
        continue;
      }

    invalid:
      continue;
    }

    idx = strtok_r(NULL, ",", &a);
  }

  printf("%ld\n", total);

  return 0;
}