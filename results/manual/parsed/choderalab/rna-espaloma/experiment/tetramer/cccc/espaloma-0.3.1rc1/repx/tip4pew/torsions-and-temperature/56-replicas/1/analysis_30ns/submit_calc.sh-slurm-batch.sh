#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/choderalab/rna-espaloma/experiment/tetramer/cccc/espaloma-0.3.1rc1/repx/tip4pew/torsions-and-temperature/56-replicas/1/analysis_30ns/submit_calc.sh
