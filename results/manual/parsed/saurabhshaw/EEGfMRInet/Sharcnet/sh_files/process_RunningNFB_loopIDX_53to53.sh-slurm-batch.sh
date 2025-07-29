#!/bin/bash
#SBATCH --account=rrg-beckers
#SBATCH --output=/home/shaws5/projects/def-beckers/shaws5/Research_code/EEGnet/Sharcnet/out_files/process_RunningNFB_loopIDX_53to53-Node%N-JobID%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=00:02:50

module load matlab
cd /home/shaws5/projects/def-beckers/shaws5/Research_code/EEGnet/Sharcnet/sub_files
matlab -nodesktop -nosplash -nodisplay -r "run('process_RunningNFB_loopIDX_53to53.m'); exit"
