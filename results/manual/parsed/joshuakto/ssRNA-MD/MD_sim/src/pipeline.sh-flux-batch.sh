#!/bin/bash
#FLUX: --job-name=bricky-nunchucks-3182
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --priority=16

SRC=/work/donglab/ching.ki/ssRNA-MD/MD_sim/src
DATA=/work/donglab/ching.ki/ssRNA-MD/VAE/data/gro
source $SRC/load_MD_tools.sh
pdb_file=${1##*/}		# remove string leading last /
run_id=${pdb_file%.*}_$2_$3 	# remove string trailing last .
temp_dir=/scratch/ching.ki/$run_id
[ -d $temp_dir ] &&
	 rm -r $temp_dir &&
	 echo "removed old "$temp_dir" to create new one for this run"
mkdir "$temp_dir"
echo "Created new "$temp_dir
cd "$temp_dir"
bash $SRC/solvate.sh $1 $2 $3 $SRC 
python $SRC/convert_prmtop-rst7_to_top-gro.py rna 
MDP_DIR=$SRC/md_params
gmx grompp -f $MDP_DIR/minim.mdp -c rna.gro -p rna.top -o em.tpr
gmx mdrun -v -deffnm em 
gmx grompp -f $MDP_DIR/nvt.mdp -c em.gro -r em.gro -p rna.top -o nvt.tpr
gmx mdrun -deffnm nvt
gmx grompp -f $MDP_DIR/npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt  -p rna.top -o npt.tpr
gmx mdrun -deffnm npt
gmx grompp -f $MDP_DIR/md.mdp -c npt.gro -t npt.cpt  -p rna.top -o md_0_1.tpr
gmx mdrun -deffnm md_0_1 -nb gpu
gmx convert-trj -f md_0_1.xtc -s md_0_1.tpr -o $run_id".gro"
eval "$(conda shell.bash hook)"
conda activate py38
python -c "import mdtraj as md; pdb=md.load('$1'); t=md.load('$run_id.gro'); rna_idx=t.top.select(f'resi<{pdb.n_residues}'); rna=t.atom_slice(rna_idx); rna.save('$DATA/filtered_$run_id.gro')"
