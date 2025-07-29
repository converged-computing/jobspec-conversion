#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/LadaOndris/hand-recognition/src/metacentrum/train_jgrp2o_msra.sh
