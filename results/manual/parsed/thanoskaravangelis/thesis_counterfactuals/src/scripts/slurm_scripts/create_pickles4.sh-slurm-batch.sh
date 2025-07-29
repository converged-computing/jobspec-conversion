#!/bin/bash
#SBATCH --job-name=pickle5_files
#SBATCH --account=pa210503
#SBATCH --output=runs/outputs/pickles5.out.log
#SBATCH --error=runs/errors/pickles5.error.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=56G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1

cd /users/pa21/ptzouv/tkaravangelis/mice
module purge
module load gnu/8 cuda/10.1.168 intelmpi/2018 pytorch/1.7.0
source /users/pa21/ptzouv/tkaravangelis/venv/bin/activate
start=$(date +%s.%N)
srun python3 /users/pa21/ptzouv/tkaravangelis/scripts/create_news_pickle.py /users/pa21/ptzouv/tkaravangelis/mice_newsgroups/results/newsgroups/edits/grad_noun_new newsgroups grad_noun_new
deactivate
end=$(date +%s.%N)
runtime=$( echo "$end - $start" | bc -l )
echo "Total script time $runtime"
