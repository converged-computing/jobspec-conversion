#!/bin/bash
#SBATCH --job-name=Test_dam
#SBATCH --output=TEST.txt
#SBATCH --mail-user=sbrialmont@student.ulg.ac.be
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=400
#SBATCH --time=01:40:00

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK '

Para="../Playgrounds/Dam_Para.kzr"
Geom="../Playgrounds/Dam_Geom.kzr"
TestName="dam"
module load openmpi/1.6.4/gcc-4.9.2 
module load cmake/3.5.2 
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK 
mpirun sph $Para $Geom $TestName 
