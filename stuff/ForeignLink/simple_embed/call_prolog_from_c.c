/*  Include file depends on local installation */
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


    return rval;
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
    foo("bye seg");
}
