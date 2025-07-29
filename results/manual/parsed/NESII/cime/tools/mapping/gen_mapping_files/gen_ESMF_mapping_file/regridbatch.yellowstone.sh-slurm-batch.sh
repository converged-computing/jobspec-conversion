#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/NESII/cime/tools/mapping/gen_mapping_files/gen_ESMF_mapping_file/regridbatch.yellowstone.sh
