FILELIST		:= p1.y p1.flex

all: p1

p1.tab.c p1.tab.h:	p1.y
	bison -d p1.y

lex.yy.c: p1.flex p1.tab.h
	flex p1.flex

p1: lex.yy.c p1.tab.c p1.tab.h
	gcc -o p1 p1.tab.c lex.yy.c

test: all
	./p1 < test.txt

clean:
	rm -f p1 p1.tab.c lex.yy.c p1.tab.h

tar: $(FILELIST)
	tar -zcvf p1.tar.gz $^