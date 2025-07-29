#!/bin/bash
#SBATCH --job-name=”mice_run_500_ADJ”
#SBATCH --account=pa210503
#SBATCH --output=runs/outputs/mice_run_500_ADJ.out.log
#SBATCH --error=runs/errors/mice_run_500_ADJ.error.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=56G
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1

cd /users/pa21/ptzouv/tkaravangelis/mice
module purge
module load gnu/8 cuda/10.1.168 intelmpi/2018 pytorch/1.7.0
source /users/pa21/ptzouv/tkaravangelis/venv/bin/activate
start=$(date +%s.%N)
srun python /users/pa21/ptzouv/tkaravangelis/scripts/run_mice_with_steps.py
deactivate
end=$(date +%s.%N)
runtime=$( echo "$end - $start" | bc -l )
echo "Total script time $runtime"
