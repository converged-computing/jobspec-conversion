#!/bin/bash
#FLUX: --job-name=frigid-snack-3491
#FLUX: -t=86400
#FLUX: --urgency=16

python -u -c "import PyHipp as pyh; \
import time; \
pyh.FreqSpectrum(saveLevel=1); \
pyh.FreqSpectrum(loadHighPass=True, pointsPerWindow=3000, saveLevel=1);\
print(time.localtime());"
