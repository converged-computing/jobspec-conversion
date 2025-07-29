#!/bin/bash
#SBATCH --job-name=train_new_1
#SBATCH --output=Malmadhu_0.out
#SBATCH --mail-user=venkata.kesav@students.iiit.ac.in
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --mem=2048
#SBATCH --time=4-00:00:00
#SBATCH --nodelist=gnode017

echo "loading cuda, cudnn modules"
echo "running python script"
python3 /home2/patanjali.b/A_3_Part-2/3_0.py
echo "Execution completed"
deactivate
echo "------END------"
