all: lowercase

lowercase: lowercase.so
	gcc -shared -o lowercase.so lowercase.o

lowercase.so: lowercase.c
	gcc -I /usr/lib/swi-prolog/include/ -fpic -c lowercase.c
clean:
	rm -rf *o
