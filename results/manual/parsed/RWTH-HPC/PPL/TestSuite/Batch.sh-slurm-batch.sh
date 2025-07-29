#!/bin/bash
#SBATCH --job-name=Testing
#SBATCH --output=output.txt
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=48
#SBATCH --gres=gpu:volta:2
#SBATCH --mem-per-cpu=100G
#SBATCH --time=10:00:00
#SBATCH --partition=c18g

module unload intel
module unload intelmpi
module load cuda/110
module load gcc/9
module load openmpi/4.0.3
echo; export; echo;  nvidia-smi; echo
cd ~/Master/out
make runall
$MPIEXEC $FLAGS_MPI_BATCH ./bin/Pattern_Test.exe
