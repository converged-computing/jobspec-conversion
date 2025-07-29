#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=12000
#SBATCH --time=1-00:00:00

echo $SLURM_JOBID - `hostname` - $SPINN_FLAGS >> ~/spinn_machine_assignments.txt
module load python/intel/2.7.12 pytorch/intel/20170125 protobuf/intel/3.1.0
python -m spinn.models.fat_classifier  --noshow_progress_bar $SPINN_FLAGS
