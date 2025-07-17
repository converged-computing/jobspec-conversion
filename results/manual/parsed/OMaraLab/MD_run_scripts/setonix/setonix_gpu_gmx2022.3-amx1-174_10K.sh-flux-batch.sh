#!/bin/bash
#FLUX: --job-name=cowy-pedo-2838
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --urgency=16

export GMX_MAXBACKUP='-1'

module load PrgEnv-cray
module load rocm craype-accel-amd-gfx90a
module load gcc/12.1.0
module load gromacs-amd-gfx90a/2022.3.amd1_174
module list
export GMX_MAXBACKUP=-1
unset OMP_NUM_THREADS
GMX='srun -l -u -c 8 gmx'
GMXMDRUN='srun -l -u -c 8 gmx mdrun -nb gpu -bonded gpu -pin on -update gpu -ntomp 8 -ntmpi 1 -maxh 9.95'
errexit ()
{
    errstat=$?
    if [ $errstat != 0 ]; then
        # A brief nap so slurm kills us in normal termination
        # Prefer to be killed by slurm if slurm detected some resource excess
        sleep 5
        echo "Job returned error status $errstat - stopping job sequence $SLURM_JOB_NAME at job $SLURM_JOB_ID"
        exit $errstat
    fi
}
if [ ! -f ${SLURM_JOB_NAME}.tpr ]; then
    $GMX grompp -f ${SLURM_JOB_NAME}.mdp -c ${SLURM_JOB_NAME}_start.gro -o ${SLURM_JOB_NAME}.tpr -p ${SLURM_JOB_NAME}.top  -n ${SLURM_JOB_NAME}.ndx -maxwarn 2 &> ${SLURM_JOB_NAME}_grompp_${SLURM_JOB_ID}.txt
fi
$GMXMDRUN -v -deffnm ${SLURM_JOB_NAME} -cpi ${SLURM_JOB_NAME}.cpt || errexit
steps_done=`perl -n -e'/Statistics over (\d+) steps using (\d+) frames/ && print $1' ${SLURM_JOB_NAME}.log`
steps_wanted=`perl -n -e'/nsteps\s*=\s*(\d+)/ && print $1' ${SLURM_JOB_NAME}.mdp`
if (( steps_done < steps_wanted )); then
    echo "Job ${SLURM_JOB_NAME} terminated with ${SLURM_JOB_NAME}/${SLURM_JOB_NAME} steps finished." 
    echo "Submitting next job in sequence ${SLURM_JOB_NAME}."
    sbatch ${SLURM_JOB_NAME}
fi
echo $SLURM_JOB_NODELIST  # print node id to the end of output file for benchmarking / identifying troublesome nodes
echo "CLUSTERID=SETONIX GPU" # print which cluster was used, so if a system is run on multiple systems I can separate the log files for benchmarking
