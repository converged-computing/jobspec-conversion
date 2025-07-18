#!/bin/bash
#FLUX: --job-name=cowy-dog-2585
#FLUX: --queue=a100_shared
#FLUX: -t=3540
#FLUX: --urgency=16

module load cmake/3.15.3
module load gcc/7.5.0
module load cuda/11.1
for i in 0{9..9};
do
    echo
      echo "reading matrix: $i";
        #  echo "reading H"
          hfile="mats/a200/block_H_matrix_ACTIVSg200_AC_$i.mtx"
        #  echo "reading Ds"
          Dsfile="mats/a200/block_Dd_matrix_ACTIVSg200_AC_$i.mtx"
      #  echo "reading jc"
          jcfile="mats/a200/block_J_matrix_ACTIVSg200_AC_$i.mtx"
      #  echo "reading jd"
          jdfile="mats/a200/block_Jd_matrix_ACTIVSg200_AC_$i.mtx"
       #   echo "reading rx"
          rxfile="mats/a200/block_rx_ACTIVSg200_AC_$i.mtx"
        #  echo "reading rs"
          rsfile="mats/a200/block_rs_ACTIVSg200_AC_$i.mtx"
         # echo "reading ry"
          ryfile="mats/a200/block_ry_ACTIVSg200_AC_$i.mtx"
        #  echo "reading ryd"
          rydfile="mats/a200/block_ryd_ACTIVSg200_AC_$i.mtx"
        #  echo "reading permutation"
      #    permfile="/people/rege393/Hybrid_dev/perm_test/permutation.mtx"
       #   echo "reading permuted and scaled matrices"
 #         permJfile="/people/rege393/Hybrid_dev/perm_test/perm_J_ACTIVSg200_AC_09.mtx"
  #        permHfile="/people/rege393/Hybrid_dev/perm_test/perm_H_ACTIVSg200_AC_09.mtx"
        srun ./hybrid_solver $hfile $Dsfile $jcfile $jdfile $rxfile $rsfile $ryfile $rydfile 2 10000.0
        #$permfile $permJfile $permJtfile $permHfile
      done 
