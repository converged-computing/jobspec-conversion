#!/bin/bash
#SBATCH --job-name=CAN_EXHAUSTIVE
#SBATCH --account=sprinkjm
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=70
#SBATCH --mem=300gb
#SBATCH --time=8-08:00:00
#SBATCH --partition=standard
#SBATCH --qos=user_qos_sprinkjm

pwd; hostname; date
now=$(date +"%Y_%m_%d_%H_%M_%S")
echo "CPUs per task: $SLURM_CPUS_PER_TASK"
module load matlab/r2020b
ulimit -u 63536
echo $now
matlab -nodisplay -nosplash -softwareopengl < /home/u27/rahulbhadani/CANExhaustiveSearch/CorrSignal_impl.m > /home/u27/rahulbhadani/CANExhaustiveSearch/output_pbs_$now.txt
date
