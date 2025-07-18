#!/bin/bash
#FLUX: --job-name=NNmd
#FLUX: --queue=npl
#FLUX: --urgency=16

export OMP_NUM_THREADS='40 # Hyperthreading'

module load gcc/8.4.0/1 cuda/10.2 cuda/11.1
module spider openmpi/4.0.3/1
source ~/scratch-shared/npl_miniconda/etc/profile.d/conda.sh
conda activate deepmd_gpu_poly
export OMP_NUM_THREADS=40 # Hyperthreading
for i in {0..7}; do
    # Navigate to the directory
    cd "sys$i" || continue  # If the directory doesn't exist, skip to the next iteration
    # Copy necessary files
    cp ../../../pybash/lammpsDeltaNNmd.in .
    cp ../../../initVASPtoLMP/sys${i}_init.data .
    intI=$i
    # Find the file that matches the pattern and extract the part of the filename
    #for file in sys${i}*_init.data; do
    #    if [[ -f "$file" ]]; then
    #        # Extract the specific part of the filename
    #        # This assumes the filename format is sys<number>_something_init.data
    #        intI=$(echo "$file" | sed -E "s/sys${i}_(.*)_init\.data/\1/")
    #        break  # Assuming only one file matches, we break after the first match
    #    fi
    #done
    # Generate a random seed using the Python script
    seed=$(python ../../../randInt.py)
    # Run the command with srun
    srun  lmp -i lammpsDeltaNNmd.in -v struct $intI -v seed $seed > "${SLURM_JOB_ID}.out"
    # Return to the original directory
    cd ..
done
all_done=false
while [ "$all_done" != true ]; do
    all_done=true
    for i in {0..7}; do
        if [ ! -f "./sys$i/doneMDsys$i" ]; then
            all_done=false
            break
        fi
    done
    sleep 10  # Wait for 10 seconds before checking again
done
for i in {0..7}; do
    rm -f "./sys$i/doneMDsys$i"
done
echo DONE_NNmd!!
touch doneMDflag
