#!/bin/bash
#SBATCH --job-name=tasktest
#SBATCH --account=psy53c17
#SBATCH --output=out%A-%a.out
#SBATCH --error=error%A-%a.err
#SBATCH --mail-user=washbee1@student.gsu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=1g
#SBATCH --time=00:01:00
#SBATCH --partition=qTRDGPUH

sleep 5s
echo $SLURM_ARRAY_TASK_ID 
sleep 5s
