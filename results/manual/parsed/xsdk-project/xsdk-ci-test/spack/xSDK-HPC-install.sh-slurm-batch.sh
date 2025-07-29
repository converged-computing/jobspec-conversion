#!/bin/bash
#SBATCH --job-name=XSDK_TEST
#SBATCH --output=XSDK_TEST_1.out
#SBATCH --error=XSDK_TEST_1.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=28

XSDKINSTALL="#!/bin/bash
spack install xsdk<COMPILERS>"
for i in $(./spack/bin/spack compilers | grep @)
do
    rm -rf $i
    mkdir $i
    cd $i
    FILENAME=xsdk-install-$i.sh
    echo "$XSDKINSTALL" >> "$FILENAME"
    sed -i '' 's/\<COMPILERS\>/'%$i'/g' $FILENAME
    sh $FILENAME
    cd ../
done
