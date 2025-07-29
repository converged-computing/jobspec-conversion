#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/kel-github/imaging_cert_value_7T_pipeline/cluster-scripts/run-mriqc.sh
