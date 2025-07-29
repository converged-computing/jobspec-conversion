#!/bin/bash
#SBATCH --job-name=s1
#SBATCH --output=s1.%j.out
#SBATCH --mail-user=nkozak@stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00

module purge
module load openmpi
module load anaconda3 
module load julia 
eval "$(conda shell.bash hook)"
conda activate env_CS238
cd /home/nkozak/CS238/explore_states
python3 s1.py
tail -n 1000 s1*.out > end_s1.out
rm s1*.out
cd /home/nkozak/CS238/explore_states/s1/backGround
rm -r 1*
rm -r 2*
rm -r 3*
rm -r 4*
rm -r 5*
rm -r 6*
rm -r 7*
rm -r 8*
rm -r 9*
rm -r processor*
zip -r VTK.zip VTK
rm -r VTK
zip -r postProcessing.zip postProcessing
rm -r postProcessing
mkdir /scratch/users/nkozak/CS238/explore_states/s1
mv /home/nkozak/CS238/explore_states/s1/backGround /scratch/users/nkozak/CS238/explore_states/s1/.
