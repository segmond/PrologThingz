/*  Include file depends on local installation */
#include <gmp.h>
#include <SWI-Prolog.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

/* 
 * I've always wanted partial addition, can't stand that instantiation fault crap 
 * a + b = c
 * c - a = b
 * c - b = a
 * Have it handle big numbers, yeaaah.
 */

foreign_t
pl_add(term_t a, term_t b, term_t c)
{ 
    char *copy;
    char *s, *q;
    int rval;
    mpz_t aval, bval, cval, res;
    int aset, bset, cset;
    int i_cnt = 0;

    aset = bset = cset = 0;
    mpz_init(aval);
    mpz_init(bval);
    mpz_init(cval);
    mpz_init(res);

    if ( !PL_get_mpz(a, aval) ) {
        aset = 1;
        i_cnt++;
    }
    if ( !PL_get_mpz(b, bval) ) {
        bset = 1;
        i_cnt++;
    }
    if ( !PL_get_mpz(c, cval) ) {
        cset = 1;
        i_cnt++;
    }
    if (i_cnt > 1) {
        return PL_warning("add/3: instantiation fault");
    }
    if (aset == 1) {
        mpz_sub(res,cval,bval);
        rval = PL_unify_mpz(a, res);
    } else if (bset == 1) {
        mpz_sub(res,cval,aval);
        rval = PL_unify_mpz(b, res);
    } else {
        mpz_add(res,aval,bval);
        rval = PL_unify_mpz(c, res);
    }

    mpz_clear(aval);
    mpz_clear(bval);
    mpz_clear(cval);
    mpz_clear(res);
    return rval;
}

install_t
install()
{ PL_register_foreign("add", 3, pl_add, 0);
}
