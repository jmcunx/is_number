/*
 * Copyright (c) 2011 ...  2023 2024
 *     John McCue <jmccue@jmcunx.com>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 * Simple prog to check for numeric strings
 */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#ifdef HAVE_JLIB
#include <j_lib2.h>
#else
#define JLIB2_CHAR_NULL  ((char) '\0')
#endif /* HAVE_JLIB */

#ifndef TRUE
#define TRUE 1
#endif
#ifndef FALSE
#define FALSE 0
#endif

#ifndef HAVE_JLIB
/*
 * j2_is_numr() -- determines if all characters are numeric
 */
int j2_is_numr(char *s)

{
  if (s == (char *) NULL)
    return((int) FALSE); /* NULL pointer */
  
  for ( ; (*s) != JLIB2_CHAR_NULL; s++)
    {
      if ( ! isdigit((int)(*s)) )
	return(FALSE);
    }
  
  return(TRUE);

} /* j2_is_numr() */
#endif /* not HAVE_JLIB */

int main(int argc, char **argv)
{

  int r;

  argv++;
  for ( ; (*argv) != NULL; argv++)
    {
      r = j2_is_numr((*argv));
      if ( ! r )
	exit(EXIT_FAILURE);
    }

  exit(EXIT_SUCCESS);
}
