#!/bin/bash
#SBATCH --job-name=IP_ddpg
#SBATCH --account=def-whitem
#SBATCH --output=/home/sungsu/scratch/output_log/IP/ddpg/%A%a.out
#SBATCH --error=/home/sungsu/scratch/output_log/IP/ddpg/%A%a.err
#SBATCH --mail-user=slurmjob@gmail.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2048M
#SBATCH --time=01:00:00
#SBATCH --array=0-89:1

ENV_NAME=InvertedPendulum-v2
AGENT_NAME=ddpg
module load singularity/2.5
echo Running..$ENV_NAME $AGENT_NAME $SLURM_ARRAY_TASK_ID
singularity exec -B /scratch /home/sungsu/rl-docker-private-tf1.8.0-gym0.10.3-py35.simg python3 ../main.py --env_json ../jsonfiles/environment/$ENV_NAME.json --agent_json ../jsonfiles/agent/$AGENT_NAME.json --index $SLURM_ARRAY_TASK_ID
