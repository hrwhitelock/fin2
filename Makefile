
EDITOR = /usr/bin/vim
INDENT = /usr/bin/indent

CC        = clang
LDFLAGS   = -O
CFLAGS    = -Weverything -Wextra -pedantic $(LDFLAGS)
#LDLIBS    = -lm -lgsl -lgslcblas
LDLIBS    = $(shell gsl-config --libs)
GNUPLOT = gnuplot
.SUFFIXES:
.SUFFIXES:  .c .o .h .gp .res .png

.PHONY: edit clean veryclean

target    = main

$(target): $(target).o integrand.o
	$(CC) $(LDFLAGS) $^ -o $@ $(LDLIBS)

edit : $(target).c
	$(EDITOR) $<
	$(INDENT) $<
res: main
	./main > res

show: res plot.gp
	$(GNUPLOT) plot.gp
	eog plot.png

clean : 
	rm -f *.o
	rm -f *.*~
	rm  -f $(target)
