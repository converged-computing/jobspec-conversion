#!/bin/bash
#FLUX: --job-name=performance-Cosmo
#FLUX: --queue=CPUQ
#FLUX: -t=3600
#FLUX: --urgency=16

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR}
echo "Job Name:          $SLURM_JOB_NAME"
echo "Working directory: $SLURM_SUBMIT_DIR"
echo "Job ID:            $SLURM_JOB_ID"
echo "Nodes used:        $SLURM_JOB_NODELIST"
echo "Number of nodes:   $SLURM_JOB_NUM_NODES"
echo "Cores (per node):  $SLURM_CPUS_ON_NODE"
echo "Total cores:       $SLURM_NTASKS"
echo "Array Task ID:     $SLURM_ARRAY_TASK_ID"
idx=`printf "%02i" $SLURM_ARRAY_TASK_ID`
echo "Index:             $idx"
cat /proc/cpuinfo
module purge
module load OpenCV/4.5.3-foss-2021a-contrib
module load CMake/3.20.1-GCCcore-10.3.0
module load SymEngine/0.7.0-GCC-10.3.0
module load SciPy-bundle/2021.05-foss-2021a
module list
source $HOME/torch-3.9.6/bin/activate
time python3 Python/datagen.py --csvfile Datasets/performance.csv  --mask --nterms 50 --amplitudes Python/CosmoSim/100.txt
