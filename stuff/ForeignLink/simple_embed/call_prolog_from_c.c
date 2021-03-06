/*  Include file depends on local installation */
// swipl-ld call_prolog_from_c.c  ; ./a.out
#include <SWI-Prolog.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdio.h>

void foo(const char *str) { printf("got -> %s\n", str); }

int mystuff(const char *str)
{
    static predicate_t p;
    qid_t qid;
    int rval;
    term_t a0 = PL_new_term_refs(1);

    if (!p) {
        p = PL_predicate("print", 1, NULL);
    }

    PL_put_atom_chars(a0, str);

    qid = PL_open_query(NULL, PL_Q_NORMAL, p, a0);
    rval = PL_next_solution(qid);
    PL_close_query(qid);

    // broken? print/1, write/1 is not working, is it sending the output else where?

    return rval;
}

int count_stats(const char *str)
{
    fid_t fid = PL_open_foreign_frame();
    term_t goal  = PL_new_term_ref();
    term_t a1    = PL_new_term_ref();
    term_t a2    = PL_new_term_ref();
    functor_t s2 = PL_new_functor(PL_new_atom("statistics"), 2);
    int atoms;

    PL_put_atom_chars(a1, str);
    PL_cons_functor(goal, s2, a1, a2);
    PL_call(goal, NULL);         /* call it in current module */

    PL_get_integer(a2, &atoms);
    PL_discard_foreign_frame(fid);

    return atoms;
}

int main(int argc, char *argv[]) {
    char *av[10];
    int ac = 0;

    av[ac++] = argv[0];
    av[ac++] = "-x";
    av[ac++] = "mystate";
    av[ac]   = NULL;
    // we can pass in av instead of argv, maybe to load our program?

    if (!PL_initialise(argc, argv)) {
        PL_halt(1);
    }
    foo("hello seg");
    mystuff("hello world");
    printf("Total number of atoms is %d\n", count_stats("atoms"));
    printf("Total number of functors is %d\n", count_stats("functors"));
    foo("bye seg");
}
