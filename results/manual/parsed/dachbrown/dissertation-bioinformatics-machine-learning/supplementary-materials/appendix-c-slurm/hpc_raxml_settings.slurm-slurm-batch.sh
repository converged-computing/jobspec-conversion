#!/bin/bash
#FLUX: --job-name=raxml_900_ws_PW
#FLUX: --queue=Pisces
#FLUX: -t=1209600
#FLUX: --urgency=16

echo "======================================================"
echo "Start Time  : $(date)"
echo "Submit Dir  : $SLURM_SUBMIT_DIR"
echo "Job ID/Name : $SLURM_JOBID / $SLURM_JOB_NAME"
echo "Node List   : $SLURM_JOB_NODELIST"
echo "Num Tasks   : $SLURM_NTASKS total [$SLURM_NNODES nodes @ $SLURM_CPUS_ON_NODE CPUs/node]"
echo "======================================================"
echo ""
RAXML_BIN="raxmlHPC-MPI-AVX2"
RAXML_VER="8.2.12"
RAXML_SEQ="/scratch/dbrow208/galick_gun_working_dir/subset_900/results_Roary_no_split/core_gene_alignment.aln"
RAXML_OUT="900_ws_core_opt_PAIRWISE_DIST"
STARTING_TREE="/scratch/dbrow208/galick_gun_working_dir/subset_900/RAxML_bestTree.with_split"
UNROOTED_TREE="/scratch/dbrow208/galick_gun_working_dir/subset_900/RAxML_bestTree.900_ws_core_opt"
PW_REF_TREE="/scratch/dbrow208/galick_gun_working_dir/subset_900/RAxML_rootedTree.900_ws_core_opt.ROOTED"
RAXML_OPTS="-f x -p 1234 -m GTRGAMMA -t $PW_REF_TREE"
cd $SLURM_SUBMIT_DIR
module load raxml/${RAXML_VER}-mpi
srun --mpi=pmix_v3 $RAXML_BIN -s $RAXML_SEQ -n $RAXML_OUT -N $SLURM_NTASKS_PER_NODE $RAXML_OPTS
echo ""
echo "======================================================"
echo "End Time   : $(date)"
echo "======================================================"
