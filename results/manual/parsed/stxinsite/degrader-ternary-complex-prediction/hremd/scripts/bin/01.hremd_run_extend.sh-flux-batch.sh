#!/bin/bash
#FLUX: --job-name=swampy-arm-4340
#FLUX: --exclusive
#FLUX: -t=1800
#FLUX: --priority=16

module load cuda
source /bgfs01/insite/utsab.shrestha/programs/gmx_plumed4/gromacs-2018.8/install_dir/bin/GMXRC.bash
source /bgfs01/insite/utsab.shrestha/programs/gmx_plumed4/plumed-2.5.4/sourceme.sh
NumReplicas=20			#Total number of replicas to be used.
HremdMaxH=0.1                   #Maximum hours for production HREMD.
				#Keep "HremdMaxH" always slightly less than the walltime.
RepEx=500			#Attempt replica exchange every 500 MD steps, i.e., 1 ps.
CheckPt=5			#Write checkpoint file for MD run every 5 minutes.
if [[ $NumReplicas -gt $SLURM_NPROCS ]]; then
    echo "ERROR: Number of replicas greater than the number of tasks allocated for this job. This will disrupt MPI scheduling."
    exit 1
fi
touch plumed.dat
mpirun -np $NumReplicas -mca btl sm,self,tcp --oversubscribe gmx_mpi mdrun -cpi -cpt $CheckPt -maxh $HremdMaxH -plumed plumed.dat -replex $RepEx -hrex -multi $NumReplicas
rm *#*
