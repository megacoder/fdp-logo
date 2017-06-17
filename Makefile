.SUFFIXES: .png .svg

H	=500
W	=500

.svg.png:
	batik -d $@ -h $H -w $W $^

TARGETS=								\
	logo-16x16.png							\
	logo-32x32.png							\
	logo-64x64.png							\
	logo-128x128.png						\
	logo-256x256.png						\
	logo-500x500.png

TARGET	=logo-$Hx$W.png

default:	${TARGET}

all:
	for x in ${TARGETS}; do						\
		geom=$$(echo $$x | sed -e 's/.*-//' -e 's/\.png//');	\
		H=$$(echo $$geom | sed -e 's/x.*//');			\
		W=$$(echo $$geom | sed -e 's/.*x//');			\
		${MAKE} H=$$H W=$$W logo-$$geom.png;			\
	done

logo.png: logo.svg
	batik -d $@ -h $H -w $W $^

logo-$Hx$W.png: logo.png
	move-if-change logo.png $@

clean:

distclean clobber: clean
	${RM} ${TARGETS}
