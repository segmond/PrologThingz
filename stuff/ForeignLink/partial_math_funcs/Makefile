all: partial_math_funcs

partial_math_funcs: partial_math_funcs.so
	gcc -shared -o partial_math_funcs.so partial_math_funcs.o

partial_math_funcs.so: partial_math_funcs.c
	gcc -I /usr/lib/swi-prolog/include/ -lgmp -fpic -c partial_math_funcs.c
clean:
	rm -rf *o
