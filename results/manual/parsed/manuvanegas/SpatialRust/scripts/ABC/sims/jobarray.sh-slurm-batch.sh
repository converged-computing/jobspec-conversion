#!/bin/bash
#SBATCH --job-name=ABC
#SBATCH --output=logs/ABC/sims/o-%A-%a.o
#SBATCH --error=logs/ABC/sims/o-%A.e
#SBATCH --mail-user=mvanega1@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=04:00:00
#SBATCH --partition=public
#SBATCH --array=1-50

export SLURM_NODEFILE='`scripts/generate_pbs_nodefile.pl`'

module purge
module load julia/1.8.2
ulimit -s 262144
echo `date +%F-%T`
echo $SLURM_JOB_ID
echo $SLURM_JOB_NODELIST
export SLURM_NODEFILE=`scripts/generate_pbs_nodefile.pl`
cp $SLURM_NODEFILE logs/ABC/nodefiles/nodes_${SLURM_ARRAY_TASK_ID}
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/ABC/sims/runABC.jl \
16 $SLURM_ARRAY_TASK_ID $SLURM_NTASKS 4000 #2500 # 250 #500
