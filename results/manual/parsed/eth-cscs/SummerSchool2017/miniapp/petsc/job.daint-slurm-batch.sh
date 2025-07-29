#!/bin/bash
#FLUX: --job-name=petsc-miniapp-test
#FLUX: -t=600
#FLUX: --urgency=16

srun ./main -ts_monitor -snes_monitor -ksp_monitor 
