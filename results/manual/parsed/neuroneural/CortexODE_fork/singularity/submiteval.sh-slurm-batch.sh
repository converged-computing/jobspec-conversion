#!/bin/bash
#SBATCH --job-name=ctodeval
#SBATCH --account=psy53c17
#SBATCH --output=jobs/out%A.out
#SBATCH --error=jobs/error%A.err
#SBATCH --mail-user=washbee1@student.gsu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:V100:1
#SBATCH --mem=60g
#SBATCH --time=1-00:00:00
#SBATCH --exclude=arctrdgn002,arctrddgx001

sleep 5s
module load singularity/3.10.2
singularity exec --nv --bind /data/users2/washbee/speedrun/:/speedrun,/data/users2/washbee/speedrun/CortexODE_fork:/cortexode /data/users2/washbee/containers/speedrun/cortexODE_bm_sandbox/ /cortexode/singularity/eval.sh &
wait
sleep 10s
