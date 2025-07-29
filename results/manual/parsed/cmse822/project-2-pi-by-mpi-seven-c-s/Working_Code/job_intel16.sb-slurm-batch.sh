#!/bin/bash
#SBATCH --job-name=calc_pi
#SBATCH --output=output/pi_job_%A_%a.out
#SBATCH --error=output/pi_job_%A_%a.err
#SBATCH --nodes=64
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:15:00
#SBATCH --array=0-2
#SBATCH --nodelist=lac-[250-253,256-261,302-317]

cd ~/Documents/project-2-pi-by-mpi-seven-c-s/Nick_Work            ### change to the directory where your code is located
num_darts=(1000 1000000 1000000000)
for cpus in 1 2 4 8 16 32 64
do 
    output=$(mpiexec -n $cpus ./pi ${num_darts[$SLURM_ARRAY_TASK_ID]})
    echo -e "${output},${cpus},${num_darts[$SLURM_ARRAY_TASK_ID]} "
done
