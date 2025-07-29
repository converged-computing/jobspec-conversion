#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/anagainaru/ADIOS2-addons/DataStreaming/cpp_codes/batch_ssc_summit.sh
