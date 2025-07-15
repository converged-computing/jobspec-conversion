#!/bin/bash
#FLUX: --job-name=psycho-milkshake-1338
#FLUX: -c=48
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --priority=16

export SINGULARITY_TMPDIR='/scratch/user/uqadaqu1/tmp/ '

echo "CLUSTERID=BUNYA-A100-GPU" # print which cluster was used, so if a system is run on multiple systems I can separate the log files for benchmarking
module list
export SINGULARITY_TMPDIR=/scratch/user/uqadaqu1/tmp/ 
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
GMX='singularity run --nv /scratch/user/uqadaqu1/containers/gromacs_2023.sif gmx'
GMXMDRUN=GMXMDRUN='singularity run --nv /scratch/user/uqadaqu1/containers/gromacs_2023.sif gmx mdrun -ntmpi 4 -ntomp 8 -pin on -pme cpu -dlb yes -maxh 9.95'
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
sed -i 's|\r|\n|g' slurm-${SLURM_JOB_ID}.out
echo $SLURM_JOB_NODELIST  # print node id to the end of output file for benchmarking / identifying troublesome nodes
