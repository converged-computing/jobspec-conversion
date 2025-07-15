#!/bin/bash
#FLUX: --job-name=doopy-fudge-1656
#FLUX: --urgency=16

export src='$pd/src'
export sesnm='main'

ssh user@grace.hpc.yale.edu #Instead of this
ssh grace #Do this
sbatch --export=A=5,b='test' jobscript.sbatch #see link for more examples
/opt/cisco/anyconnect/bin/vpn connect access.yale.edu
vpn connect access.yale.edu
vpn disconnect
module avail R #find the most recent version of R
module load Apps/R/3.5.1-generic
/gpfs/apps/bin/groupquota.sh #see report on group quota
umask 0002 #add this to ~/.bashrc file to make sure files you create are going to be editable and movable by your fellow group members
RNGkind("L'Ecuyer-CMRG") #set random numbers
cores <- strtoi(Sys.getenv('SLURM_CPUS_PER_TASK', unset=1)) #for testing on hpc
cl <- startMPIcluster(verbose=TRUE,logdir='mylogdir') #MPI_*.out files will be written to mylogdir
registerDoMPI(cl)
setRngDoMPI(cl) #set each worker to receive a different stream of random numbers
--mem-per-cpu=32G
-J myjob  #job name
-e --error. default is slurm-%j.out
-o --output. default is slurm-%j.out
export src=$pd/src
export sesnm=main
t=23:59:59
p=day
J=umap4_2k
mail=NONE
log=umap4_2k.log
mem=64G
sbatch -p $p -t $t -J $J -e $log -o $log --mail-type $mail --mem-per-cpu $mem $src/main/umap/umap-sbatch.sh 
module load R
Rscript --vanilla $src/main/umap/umap.r $sesnm
salloc -t 2:00:00 --mem=16G
module load R
R
cran <- 'http://lib.stat.cmu.edu/R/CRAN/'
install.packages('umap',repos=cran)
q()
Rscript --vanilla $src/main/umap/umap.r main $hvs 10 data/umap_10 --db $db -e hypervol -c $ctfs
srun --pty -p interactive -c 1 -t 0:30:00 --mem-per-cpu=20000 bash #start an interactive session with 20GB of memory
sbatch myscript.sh #submit the job. parameters and script defined in myscript.sh
srun --pty -p interactive -n 4 bash #equest four tasks for an hour, you could use
srun --pty -p interactive -n 4 bash 
mpirun -n 4 R --slave -f ~/projects/whitestork/src/scripts/hv/nichetest_hpc.r --args $job
squeue -l -u bc447 #see job status for user bc447
squeue -p interactive #see job status for interactive queue
sacct -j <jobid> --format=JobID,JobName,Partition,AllocCPUS,MaxRSS,Elapsed
sacct -u <username> --format=JobID,JobName,Partition,AllocCPUS,MaxRSS,Elapsed
sacct --format="Elapsed" -j <jobid> #Just output how much time has elapsed for the job
scancel <jobid>
srun --pty -p interactive -n 4 bash #request four tasks in the interactive queue
module load Apps/R
module load Apps/R/3.5.1-generic
module load Rpkgs/DOMPI
mpirun -n 4 R --slave -f myscript.r #use mpi run to kick off the script using four parallel processes
mpirun -np 1 #only start script on one task
sbatch myscript_sbatch.sh
ssh bc447@omega.hpc.yale.edu #log in to omega
qsub -q fas_devel -I #request interactive queue on fas_devel
module load Apps/R/3.3.2-generic #uses specific version
module load Apps/R #uses default version
module avail 
/lustre/home/client/apps/fas/Rpkgs/RCPP/1.12.1/3.2
/lustre/home/client/fas/jetz/bc447/R/x86_64-pc-linux-gnu-library/3.2/
