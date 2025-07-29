#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mickaellalande/PhD/local/ESA_CCI_snow/snowCCI_preprocess_MODIS_gricad_v1-2002.sh
