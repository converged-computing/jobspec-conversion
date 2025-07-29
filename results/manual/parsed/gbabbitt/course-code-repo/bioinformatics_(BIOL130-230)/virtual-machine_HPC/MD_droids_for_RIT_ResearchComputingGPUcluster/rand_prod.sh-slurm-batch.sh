#!/bin/bash
#SBATCH --job-name=test_2
#SBATCH --account=silico
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user=mr8236@rit.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=10G
#SBATCH --time=1-00:00:00
#SBATCH --partition=tier3
#SBATCH --constraint=vram40|vram32

spack unload --all
spack load amber@20 /6r7gnm4
protein="${1}REDUCED" #name of the REDUCED pdb filed
echo "Start random run(${SLURM_JOB_ID}) # ${SLURM_ARRAY_TASK_ID}"
start_time=$SECONDS
pmemd.cuda -O -i ${protein}_rand${SLURM_ARRAY_TASK_ID}.in -o rand_${protein}_${SLURM_ARRAY_TASK_ID}.out -p wat_${protein}.prmtop -c eq_${protein}.rst -r rand_${protein}_${SLURM_ARRAY_TASK_ID}.rst -x rand_${protein}_${SLURM_ARRAY_TASK_ID}.nc -inf rand_${protein}_${SLURM_ARRAY_TASK_ID}.info
end_time=$SECONDS
elapsed=$(( end_time - start_time ))
eval "echo Random run ${SLURM_ARRAY_TASK_ID} elapsed time: $(date -ud "@$elapsed" +'$((%s/3600/24)) days %H hr %M min %S sec')"
echo "Random run # ${SLURM_ARRAY_TASK_ID} finished"
echo " "
echo "Start production run(${SLURM_JOB_ID}) # ${SLURM_ARRAY_TASK_ID}"
start_time=$SECONDS
pmemd.cuda -O -i ${protein}_prod.in -o prod_${protein}_${SLURM_ARRAY_TASK_ID}.out -p wat_${protein}.prmtop -c rand_${protein}_${SLURM_ARRAY_TASK_ID}.rst -r prod_${protein}.rst -x prod_${protein}_${SLURM_ARRAY_TASK_ID}.nc -inf prod_${protein}_${SLURM_ARRAY_TASK_ID}.info
end_time=$SECONDS
elapsed=$(( end_time - start_time ))
eval "echo Production run ${SLURM_ARRAY_TASK_ID} elapsed time: $(date -ud "@$elapsed" +'$((%s/3600/24)) days %H hr %M min %S sec')"
echo "Production run #${SLURM_ARRAY_TASK_ID} finished"
