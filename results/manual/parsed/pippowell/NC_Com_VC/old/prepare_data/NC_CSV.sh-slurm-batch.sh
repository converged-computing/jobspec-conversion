#!/bin/bash
#SBATCH --output=output_5595q.o%j
#SBATCH --error=errors_5595q.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=12:00:00

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/home/p/ppowell/miniconda3/envs/EEG_Vis_CL/lib/'

echo "running in shell: " "$SHELL"
echo "*** loading spack modules ***"
source ~/.bashrc
conda activate EEG_Vis_CL
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/p/ppowell/miniconda3/envs/EEG_Vis_CL/lib/
echo $LD_LIBRARY_PATH
echo "*** set workdir ***"
/home/student/p/ppowell/miniconda3/envs/EEG_Vis_CL/bin/python create_nc_csv.py "$@"
