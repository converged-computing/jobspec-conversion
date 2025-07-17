#!/bin/bash
#FLUX: --job-name=rpllfp
#FLUX: -t=86400
#FLUX: --urgency=16

<<<<<<< HEAD
=======
>>>>>>> upstream/main
python -u -c "import PyHipp as pyh; \
import time; \
pyh.RPLLFP(saveLevel=1); \
print(time.localtime());"
<<<<<<< HEAD
=======
>>>>>>> upstream/main
