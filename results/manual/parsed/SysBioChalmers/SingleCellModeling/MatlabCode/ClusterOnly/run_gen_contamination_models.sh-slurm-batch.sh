#!/bin/bash
#SBATCH --account=C3SE2022-1-16
#SBATCH --mail-user=gustajo@chalmers.se
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --time=5-00:00:00
#SBATCH --partition=vera

module load MATLAB/2019a
module load GCCcore/10.3.0
module load GCCcore/11.2.0
module load Gurobi/9.5.0
matlab -nodesktop -nodisplay -nojvm -r "generate_contamination_models(${SLURM_ARRAY_TASK_ID}); exit" < /dev/null &
wait
