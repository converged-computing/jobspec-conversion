#!/bin/bash
#FLUX: --job-name=boopy-leopard-5364
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export NTASKS='$(echo "$SLURM_NNODES*$(echo $SLURM_TASKS_PER_NODE | cut -d '(' -f 1)" | bc -l)'

module purge
module load matlab/R2023b
module load anaconda3/2023.9 
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export NTASKS=$(echo "$SLURM_NNODES*$(echo $SLURM_TASKS_PER_NODE | cut -d '(' -f 1)" | bc -l)
start_time=$(date +%s.%N)
matlab -nodisplay -nosplash -r polar_analytical_solution
python ./images2gif.py
end_time=$(date +%s.%N)
elapsed_seconds=$(echo "$end_time - $start_time" | bc)
integer_part=$(echo "$elapsed_seconds" | cut -d '.' -f 1)
hours=$(printf "%02d" $(echo "$integer_part / 3600" | bc))
minutes=$(printf "%02d" $(echo "($integer_part / 60) % 60" | bc))
seconds=$(printf "%02d" $(echo "$integer_part % 60" | bc))
echo
echo "Elapsed time: $hours:$minutes:$seconds"
