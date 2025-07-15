#!/bin/bash
#FLUX: --job-name=fat-cupcake-0846
#FLUX: -N=25
#FLUX: --queue=general
#FLUX: -t=72000
#FLUX: --priority=16

module load slurm_setup
module load amber
source /lrz/sys/applications/amber/amber18/amber.sh
module load namd
n_drugs=1
ldrugs="g15"
n_replicas=25
echo "Running equilibration and simulation on " $((1*$SLURM_JOB_NUM_NODES/$n_drugs)) " nodes or " $((1*$SLURM_NTASKS/$n_drugs)) " cores" 
echo "Running analysis on " $((1*$SLURM_JOB_NUM_NODES/$n_replicas)) " nodes or " $((1*$SLURM_NTASKS/$n_replicas)) " cores" 
path_uqnamd=/hppfs/work/pn72qu/di36yax3/tmp/uq_namd2
path_template=${path_uqnamd}/template
for drug in $ldrugs; do
    cd $drug/build
    tleap -s -f tleap.in > tleap.log
    bash ${path_template}/$drug/build/compute_dimensions.sh
    awk -f ${path_template}/$drug/build/constraint.awk complex.pdb ${path_template}/$drug/constraint/prot.pdb > ../constraint/cons.pdb
    cd ../fe/build
    ante-MMPBSA.py -p ../../build/complex.prmtop -c com.top -r rec.top -l lig.top -s :129-100000 -n :128
    cd ../../../
done
for step in {0..2}; do
    for drug in $ldrugs; do
        if [ -s ${drug}/build/complex.prmtop ]; then
           srun -N $((1*$SLURM_JOB_NUM_NODES/$n_drugs)) -n $((1*$SLURM_NTASKS/$n_drugs)) namd2 +replicas ${n_replicas} ${drug}/replica-confs/eq$step-replicas.conf &
           sleep 5
        fi
    done
    wait
done
for step in {1..1}; do
    for drug in $ldrugs; do
        if [ -s ${drug}/build/complex.prmtop ]; then
           srun -N $((1*$SLURM_JOB_NUM_NODES/$n_drugs)) -n $((1*$SLURM_NTASKS/$n_drugs)) namd2 +replicas ${n_replicas} ${drug}/replica-confs/sim$step-replicas.conf &
           sleep 5
        fi
    done
    wait
done
for drug in $ldrugs; do
    for i in $(seq 1 $n_replicas); do
        cd $drug/fe/mmpbsa/rep$i
        srun -N 1 -n 48 MMPBSA.py.MPI -i ${path_template}/mmpbsa.in -sp ../../../build/complex.prmtop -cp ../../build/com.top -rp ../../build/rec.top -lp ../../build/lig.top -y ../../../replicas/rep$i/simulation/sim1.dcd &
        sleep 3
        cd ../../../../
    done
done
wait
for drug in $ldrugs; do
    for i in $(seq 1 $n_replicas); do
        cd $drug/fe/mmpbsa/rep$i
        srun -n 1 -N 1 xargs -d '\n' -I cmd -P 9 /bin/bash -c 'cmd'  <<EOF &
cat _MMPBSA_complex_gb.mdout.{0..47} > _MMPBSA_complex_gb.mdout.all
cat _MMPBSA_complex_gb_surf.dat.{0..47} > _MMPBSA_complex_gb_surf.dat.all
cat _MMPBSA_complex_pb.mdout.{0..47} > _MMPBSA_complex_pb.mdout.all
cat _MMPBSA_ligand_gb.mdout.{0..47} > _MMPBSA_ligand_gb.mdout.all
cat _MMPBSA_ligand_gb_surf.dat.{0..47} > _MMPBSA_ligand_gb_surf.dat.all
cat _MMPBSA_ligand_pb.mdout.{0..47} > _MMPBSA_ligand_pb.mdout.all
cat _MMPBSA_receptor_gb.mdout.{0..47} > _MMPBSA_receptor_gb.mdout.all
cat _MMPBSA_receptor_gb_surf.dat.{0..47} > _MMPBSA_receptor_gb_surf.dat.all
cat _MMPBSA_receptor_pb.mdout.{0..47} > _MMPBSA_receptor_pb.mdout.all
EOF
        sleep 3
        cd ../../../../
    done
done
wait
for drug in $ldrugs; do
    for i in $(seq 1 $n_replicas); do
        cd $drug/fe/mmpbsa/rep$i
        rm _MMPBSA_*.{0..47} reference.frc *.pdb *.inpcrd *.mdin* *.out
        cd ../../../../
    done
done
echo "drug,binding_energy_avg" > output.csv
for drug in $ldrugs; do
    rm tmp.output.csv
    for i in $(seq 1 $n_replicas); do
        cd $drug/fe/mmpbsa/rep$i
        tmp_str=$(awk '{if(index($0, "DELTA TOTAL")> 0) {count++}; if(count>1) { print $3; count=0}} ' ./FINAL_RESULTS_MMPBSA.dat)
        cd ../../../../
        echo "$tmp_str" >> tmp.output.csv
    done
    tmp_str=$(awk '{ sum += $1; n++ } END { if (n > 0) print sum / n; }' tmp.output.csv)
    echo "$drug,$tmp_str" >> output.csv
done
