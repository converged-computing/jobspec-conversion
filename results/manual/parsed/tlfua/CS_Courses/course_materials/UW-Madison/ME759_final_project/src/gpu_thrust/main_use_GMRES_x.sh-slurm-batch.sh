#!/bin/bash
#FLUX: --job-name=main_use_GMRES
#FLUX: --queue=wacc
#FLUX: -t=600
#FLUX: --urgency=16

srun main_use_GMRES
