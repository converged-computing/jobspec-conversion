#!/bin/bash
#SBATCH --output=code_%A.out
#SBATCH --mail-user=zhiqiang.liao@aalto.fi
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=8G
#SBATCH --time=5-00:00:00

echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
cd /scratch/work/liaoz1/papers/WRCNLS/simu/ill2/
module load julia
srun julia -t $SLURM_CPUS_PER_TASK ill.jl
