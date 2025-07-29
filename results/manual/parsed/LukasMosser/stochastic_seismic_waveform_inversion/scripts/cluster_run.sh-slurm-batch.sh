#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/LukasMosser/stochastic_seismic_waveform_inversion/scripts/cluster_run.sh
