# Flux batch script equivalent

# Resources
--nodes=3
--cores=96
--time=05:00:00
--context=haswell

# Job name
--job-name=prob-multiproc

# Output file
--output-dir=logs
--output-file=%j.out

# Load software
module load pytorch/v1.6.0

# Application command
srun -n 96 -c 2 python $HOME/mldas/mldas/assess.py probmap -c $HOME/mldas/configs/assess.yaml -o $SCRATCH/probmaps --mpi