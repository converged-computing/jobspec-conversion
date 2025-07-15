#!/bin/bash
#FLUX: --job-name=xterm
#FLUX: --queue=gui
#FLUX: -t=345600
#FLUX: --urgency=16

date; hostname; pwd;
unset XDG_RUNTIME_DIR
module purge; module load gui/2 xterm
/apps/gui/2.0.0/bin/start_gui_app xterm
date
