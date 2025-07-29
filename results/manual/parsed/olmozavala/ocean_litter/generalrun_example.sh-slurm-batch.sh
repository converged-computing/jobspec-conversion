#!/bin/bash
#SBATCH --job-name=20YEAR_MONTH
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64G
#SBATCH --time=20:00:00

module load intel-openmpi
module load anaconda3.7.3
cmd="srun /gpfs/home/osz09/.conda/envs/py3_parcels_mpi/bin/python 0_WorldLitter.py ${c_start_date}:0 ${c_end_date}:0 True True False ${run_name}_${c_start_date}_${c_end_date}"
`$cmd > 'CurrentRun20YEAR_MONTH.log'`
