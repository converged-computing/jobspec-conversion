#!/bin/bash
#FLUX: --job-name=ase_vasp
#FLUX: -n=48
#FLUX: --exclusive
#FLUX: --queue=amd
#FLUX: --urgency=16

export ASE_VASP_COMMAND='mpirun -np $SLURM_NTASKS vasp_std'
export VASP_PP_PATH='/home/graeme/vasp/'

pwd; hostname; date
if [[ $( lscpu | grep AMD ) ]]; then ml swap vasp vasp_amd; fi
ml list
if [[ $(( SLURM_ARRAY_TASK_MAX + 1 )) != $SLURM_ARRAY_TASK_COUNT ]]; then
    echo "Please configure the SLURM array correctly"
    exit 1
fi
traj_path="/home/sung/UFMin/ilgar/data/B/high_entropy/B.traj"
out_traj_prefix="B"
echo "Index $SLURM_ARRAY_TASK_ID of $SLURM_ARRAY_TASK_MAX in job $SLURM_ARRAY_JOB_ID"
if [[ -d $SLURM_ARRAY_TASK_ID ]]; then
    echo "Directory $SLURM_ARRAY_TASK_ID already exists."
    exit 1
fi
mkdir $SLURM_ARRAY_TASK_ID
cd $SLURM_ARRAY_TASK_ID
export ASE_VASP_COMMAND="mpirun -np $SLURM_NTASKS vasp_std"
export VASP_PP_PATH="/home/graeme/vasp/"
cp ../ase_vasp_run.py .
python ase_vasp_run.py $traj_path $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT $out_traj_prefix
if [[ $SLURM_ARRAY_TASK_ID == 0 ]]; then
    cd ..
    # wait for others in the array to finish
    while true; do
        if [[ $( squeue -j $SLURM_ARRAY_JOB_ID | wc -l ) == 2 ]]; then
            break
        fi
        echo "Waiting for others..."
        sleep 10
    done
    # collect all array traj files
    python ase_vasp_cleanup.py $SLURM_ARRAY_TASK_COUNT $out_traj_prefix
fi
