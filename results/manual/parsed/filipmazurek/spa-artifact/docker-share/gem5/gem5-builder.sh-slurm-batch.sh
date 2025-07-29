#!/bin/bash
#SBATCH --output=compilation.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=9
#SBATCH --mem=1024

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/hpc/group/brownlab/fjm7/miniconda3/envs/gem5_env/lib'

. "/hpc/group/brownlab/fjm7/miniconda3/etc/profile.d/conda.sh"
conda activate gem5_env
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/hpc/group/brownlab/fjm7/miniconda3/envs/gem5_env/lib
python `which scons` build/X86/gem5.fast PROTOCOL=MESI_Two_Level -j 9
