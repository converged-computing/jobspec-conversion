#!/bin/bash
#SBATCH --job-name=sample
#SBATCH --output=slurm.%N.%j.out
#SBATCH --error=slurm.%N.%j.err
#SBATCH --mail-user=username@wistar.org
#SBATCH --mail-type=begin,end,fail
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3GB
#SBATCH --time=00:01:00

module load apptainer
apptainer pull docker://<image>
if ! test -f container.sif; then
  echo "Container does not exist...building"
  apptainer build container.sif recipe.def
fi
apptainer exec container.sif <command>
