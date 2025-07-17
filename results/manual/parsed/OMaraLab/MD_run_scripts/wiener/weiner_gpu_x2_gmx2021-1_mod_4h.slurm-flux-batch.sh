#!/bin/bash
#FLUX: --job-name=stanky-pot-2656
#FLUX: -c=28
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

export OMP_NUM_THREADS='7'
export MV2_ENABLE_AFFINITY='0'

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
module purge
module load gnu7/7.3.0
module load cuda/9.1.85.3
module load mvapich2/2.2
module load gromacs/2021.1
module list
export OMP_NUM_THREADS=7
export MV2_ENABLE_AFFINITY=0
GMX='mpirun -n 1 gmx_mpi'
GMXMDRUN='mpirun -n 4 gmx_mpi mdrun -maxh 3.95 -nb gpu'
if [ ! -f ${SLURM_JOB_NAME}.tpr ]; then
    $GMX grompp -f ${SLURM_JOB_NAME}.mdp -c ${SLURM_JOB_NAME}_start.gro -o ${SLURM_JOB_NAME}.tpr -p ${SLURM_JOB_NAME}.top  -n ${SLURM_JOB_NAME}.ndx -maxwarn 1 &> ${SLURM_JOB_NAME}_grompp_${SLURM_JOB_ID}.txt
fi
$GMXMDRUN -v -deffnm ${SLURM_JOB_NAME} -cpi ${SLURM_JOB_NAME}.cpt || errexit
steps_done=`perl -n -e'/Statistics over (\d+) steps using (\d+) frames/ && print $1' ${SLURM_JOB_NAME}.log`
steps_wanted=`perl -n -e'/nsteps\s*=\s*(\d+)/ && print $1' ${SLURM_JOB_NAME}.mdp`
if (( steps_done < steps_wanted )); then
    echo "Job ${SLURM_JOB_NAME} terminated with ${SLURM_JOB_NAME}/${SLURM_JOB_NAME} steps finished." 
    echo "Submitting next job in sequence ${SLURM_JOB_NAME}."
    sbatch ${SLURM_JOB_NAME}.sh
fi
sed -i 's|\r|\n|g' slurm-${SLURM_JOB_ID}.out
cp ${SLURM_JOB_NAME}.log lastlog.txt
echo $SLURM_JOB_NODELIST  # print node id to the end of output file for benchmarking / identifying troublesome nodes
echo "CLUSTERID=Weiner GPU" # print which cluster was used, so if a system is run on multiple systems I can separate the log files for benchmarking
