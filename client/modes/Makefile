CC = grcc
CFLAGS = -d .

all: modes

MODES = tetrapol.py tetra.py nfm.py mfm.py wfm.py raw.py multimon.py dsd.py
#MODES =  multimon.py

%.py: %.grc
	$(CC) $(CFLAGS) $<

modes: $(MODES)

clean:
	rm -fr *.py

