#!/bin/bash
#FLUX: --job-name=gmgpolar-setup
#FLUX: -t=300
#FLUX: --urgency=16

origin_NOT_coarse=0	# origin_NOT_coarse
theta_aniso=0		# theta_aniso
smoother=3		    # smoother (3,13)
DirBC_Interior=1	#  DirBC_Interior (0/1)
R0=1e-8		        # r (1e-8/1e-5/1e-2)
R=1.3			    # R
fac_ani=3		    # a
nr_exp=4		    # n
mod_pk=2		    # mod_pk=1: Shafranov geometry
prob=6			    # Prob=7: Simulate solution (23) of Bourne et al.
alpha_coeff=2
beta_coeff=1
extrapolation=1		# E
debug=0
v1=1
v2=1
maxiter=300
res_norm=3
rel_red_conv=1e-11
nodes=1
ranks=1     # number of MPI Ranks
cores=128    # set OpenMP Num Threads to maximum number of cores requested
create_grid=0
if [ $create_grid ]
then
cd ..
mkdir -p angles_files/Rmax"$R"/aniso"$fac_ani"/
mkdir -p radii_files/Rmax"$R"/aniso"$fac_ani"/
for divideBy2 in 0 1 2 3 4 5 6 7 8     # create different grid sizes
do
	## ATTENTION / REMARK: 
	## Please note that these calls will abort/segfault as creation of grids and computation in one step
	## is not yet supported by GMGPolar. We will make this functionality available in a future commit.
	## Please ignore abort/segfault for the calls in this loop.
	# mod_pk has no effect on the creation of grids as the set of (r,theta) is
	# the same for all geometries, only the mapping F(r,theta) -> (x,y) changes.
	./build/gmgpolar_simulation -n $nr_exp -a $fac_ani --mod_pk 0 --DirBC_Interior $DirBC_Interior --divideBy2 $divideBy2 -r $R0  --smoother $smoother --verbose 2 --debug $debug --extrapolation $extrapolation --optimized 1 $ --v1 $v1 --v2 $v2 -R $R --prob $prob  --maxiter $maxiter --alpha_coeff $alpha_coeff --beta_coeff $beta_coeff --res_norm $res_norm --write_radii_angles 1 --f_grid_r "radii_files/Rmax"$R"/aniso"$fac_ani"/divide"$divideBy2".txt" --f_grid_theta "angles_files/Rmax"$R"/aniso"$fac_ani"/divide"$divideBy2".txt"
done
fi
echo "#!/bin/bash" > run_gmgpolar_sbatch.sh
echo "#SBATCH --job-name=gmgpolar" >> run_gmgpolar_sbatch.sh
echo "#SBATCH --output=slurm-%A-p$prob-r$nr_exp-dbt7-mpk$mod_pk-s$smoother-e$extrapolation--N$nodes-R$ranks-maxC$cores.out" >> run_gmgpolar_sbatch.sh
echo "#SBATCH --error=slurm-%A-p$prob-r$nr_exp-dbt7-mpk$mod_pk-s$smoother-e$extrapolation--N$nodes-R$ranks-maxC$cores.err" >> run_gmgpolar_sbatch.sh
echo "#SBATCH -N $nodes" >> run_gmgpolar_sbatch.sh
echo "#SBATCH -n $ranks" >> run_gmgpolar_sbatch.sh
echo "#SBATCH -c $cores" >> run_gmgpolar_sbatch.sh
echo "#SBATCH --threads-per-core=1" >> run_gmgpolar_sbatch.sh
echo "#SBATCH --cpu-freq=1800000" >> run_gmgpolar_sbatch.sh
echo "#SBATCH -t 1600" >> run_gmgpolar_sbatch.sh
echo "#SBATCH --exclusive" >> run_gmgpolar_sbatch.sh
echo "module purge" >> run_gmgpolar_sbatch.sh
echo "module load likwid/5.2.2" >> run_gmgpolar_sbatch.sh
echo "# potentially run benchmark on machine" >> run_gmgpolar_sbatch.sh
echo "# srun --cpus-per-task=$((cores)) likwid-bench -i 1000 -t stream_avx_fma -w S0:500MB:64" >> run_gmgpolar_sbatch.sh
echo "let divideBy2=7" >> run_gmgpolar_sbatch.sh
max_threads=$((cores))
echo "let m=1" >> run_gmgpolar_sbatch.sh
echo "while [ \$m -le $max_threads ]; do" >> run_gmgpolar_sbatch.sh
echo "let mminus1=m-1" >> run_gmgpolar_sbatch.sh
echo "# for testing that pin works correctly, potentially use likwid-pin beforehand" >> run_gmgpolar_sbatch.sh
echo "# srun --cpus-per-task=\$m likwid-pin -c N:0-\$mminus1 ./build/gmgpolar_simulation --openmp \$m --matrix_free 1 -n $nr_exp -a $fac_ani --mod_pk $mod_pk --DirBC_Interior $DirBC_Interior --divideBy2 0 -r $R0 --smoother $smoother -E $extrapolation --verbose 2 --debug $debug --optimized 1 --v1 $v1 --v2 $v2 -R $R --prob $prob --maxiter $maxiter --alpha_coeff $alpha_coeff --beta_coeff $beta_coeff --res_norm $res_norm --f_grid_r "radii_files/Rmax"$R"/aniso"$fac_ani"/divide"\$divideBy2".txt" --f_grid_theta "angles_files/Rmax"$R"/aniso"$fac_ani"/divide"\$divideBy2".txt" --rel_red_conv $rel_red_conv" >> run_gmgpolar_sbatch.sh
echo "srun --cpus-per-task=\$m likwid-perfctr -f -m -C 0-\$mminus1 -g FLOPS_DP ./build/gmgpolar_simulation --openmp \$m --matrix_free 1 -n $nr_exp -a $fac_ani --mod_pk $mod_pk --DirBC_Interior $DirBC_Interior --divideBy2 0 -r $R0 --smoother $smoother -E $extrapolation --verbose 2 --debug $debug --optimized 1 --v1 $v1 --v2 $v2 -R $R --prob $prob --maxiter $maxiter --alpha_coeff $alpha_coeff --beta_coeff $beta_coeff --res_norm $res_norm --f_grid_r "radii_files/Rmax"$R"/aniso"$fac_ani"/divide"\$divideBy2".txt" --f_grid_theta "angles_files/Rmax"$R"/aniso"$fac_ani"/divide"\$divideBy2".txt" --rel_red_conv $rel_red_conv" >> run_gmgpolar_sbatch.sh
echo "let m=m*2" >> run_gmgpolar_sbatch.sh
echo "done;" >> run_gmgpolar_sbatch.sh
echo "let m=1" >> run_gmgpolar_sbatch.sh
echo "while [ \$m -le $max_threads ]; do" >> run_gmgpolar_sbatch.sh
echo "let mminus1=m-1" >> run_gmgpolar_sbatch.sh
echo "srun --cpus-per-task=\$m likwid-perfctr -f -m -C 0-\$mminus1 -g MEM_DP ./build/gmgpolar_simulation --openmp \$m --matrix_free 1 -n $nr_exp -a $fac_ani --mod_pk $mod_pk --DirBC_Interior $DirBC_Interior --divideBy2 0 -r $R0 --smoother $smoother -E $extrapolation --verbose 2 --debug $debug --optimized 1 --v1 $v1 --v2 $v2 -R $R --prob $prob --maxiter $maxiter --alpha_coeff $alpha_coeff --beta_coeff $beta_coeff --res_norm $res_norm --f_grid_r "radii_files/Rmax"$R"/aniso"$fac_ani"/divide"\$divideBy2".txt" --f_grid_theta "angles_files/Rmax"$R"/aniso"$fac_ani"/divide"\$divideBy2".txt" --rel_red_conv $rel_red_conv" >> run_gmgpolar_sbatch.sh
echo "let m=m*2" >> run_gmgpolar_sbatch.sh
echo "done;" >> run_gmgpolar_sbatch.sh
sbatch run_gmgpolar_sbatch.sh
