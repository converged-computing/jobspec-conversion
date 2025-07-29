#!/bin/bash
#SBATCH --job-name=tld
#SBATCH --output=jobs/job.%J.out
#SBATCH --error=jobs/job.%J.err
#SBATCH --mail-user=magnus.kaut@student.uni-tuebingen.de
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1080ti:1
#SBATCH --mem=30G
#SBATCH --time=1-23:59:59
#SBATCH --partition=week

cd /home/stud125/TrafficLightDetection/StateDetection
singularity exec --nv /home/stud125/sdc_gym_amd64.simg python -u /home/stud125/TrafficLightDetection/StateDetection/train.py --max_keep 1200 --num_epochs 15 --log_interval 5000 --device "cuda"
echo DONE!
