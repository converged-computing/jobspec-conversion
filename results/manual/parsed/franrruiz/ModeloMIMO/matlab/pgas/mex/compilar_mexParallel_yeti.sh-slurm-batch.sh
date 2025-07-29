#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/franrruiz/ModeloMIMO/matlab/pgas/mex/compilar_mexParallel_yeti.sh
