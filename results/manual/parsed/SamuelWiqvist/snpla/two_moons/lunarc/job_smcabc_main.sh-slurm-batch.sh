#!/bin/bash
#SBATCH --job-name=smcabc
#SBATCH --account=lu2020-2-7
#SBATCH --output=lunarc_output/lunarc_output_smcabc_%j.out
#SBATCH --error=lunarc_output/lunarc_output_smcabc_%j.err
#SBATCH --mail-user=samuel.wiqvist@matstat.lu.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=lu
#SBATCH: --exclusive

MAX_SEED_VAL=10
for ((i=1;i<=$MAX_SEED_VAL;i++)); do
FILE="job_smcabc_${i}.sh"
mkdir -p lunarc_output
echo >> $FILE
cat > $FILE << EOF
ml load GCC/8.3.0
ml load CUDA/10.1.243
ml load OpenMPI/3.1.4
ml load PyTorch/1.6.0-Python-3.7.4
python /home/samwiq/snpla/'seq-posterior-approx-w-nf-dev'/'two_moons'/run_script_smcabc.py 1 2 $i 10
EOF
sbatch $FILE
done
