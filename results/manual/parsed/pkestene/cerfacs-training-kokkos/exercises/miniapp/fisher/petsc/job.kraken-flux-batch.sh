#!/bin/bash
#FLUX: --job-name="petsc-miniapp-test"
#FLUX: --queue=gpua30
#FLUX: -t=600
#FLUX: --priority=16

mpirun ./main -ts_monitor -snes_monitor -ksp_monitor
