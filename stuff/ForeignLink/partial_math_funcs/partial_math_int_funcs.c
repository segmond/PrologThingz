/*  Include file depends on local installation */
#include <SWI-Prolog.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

/* 
 * I've always wanted partial addition, can't stand that instantiation fault crap 
 * a + b = c
 * c - a = b
 * c - b = a
 */

foreign_t
pl_add(term_t a, term_t b, term_t c)
{ 
    char *copy;
    char *s, *q;
    int rval, res;
    int aval, bval, cval;
    int aset, bset, cset;
    int i_cnt = 0;

    aset = bset = cset = 0;

    if ( !PL_get_integer(a, &aval) ) {
        aset = 1;
        i_cnt++;
    }
    if ( !PL_get_integer(b, &bval) ) {
        bset = 1;
        i_cnt++;
    }
    if ( !PL_get_integer(c, &cval) ) {
        cset = 1;
        i_cnt++;
    }
    if (i_cnt > 1) {
        return PL_warning("add/3: instantiation fault");
    }
    if (aset == 1) {
        res = cval - bval;
        rval = PL_unify_integer(a, res);
    } else if (bset == 1) {
        res = cval - aval;
        rval = PL_unify_integer(b, res);
    } else {
        res = aval + bval;
        rval = PL_unify_integer(c, res);
    }

    return rval;
}

install_t
install()
{ PL_register_foreign("add", 3, pl_add, 0);
}
