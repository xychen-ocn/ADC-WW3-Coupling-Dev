#!/bin/bash --login

#SBATCH --constraint=hatteras
#SBATCH --job-name=test-ssd-contrl
#SBATCH -p batch
#SBATCH --time=72:00:00
#SBATCH -n 81
##SBATCH --mem-per-cpu=5GB
#SBATCH --mail-user=xychen@uri.edu
#SBATCH --mail-type=ALL
#SBATCH --output=ww3_testSSD.out
#SBATCH --error=ww3_testSSD.err


rootdir=/projects/ees/dhs-crc/xychen/NCEP-CPL-ADC-WW3/test_ssdWindStress
scptdir=$rootdir/script/bash
nemsdir=$rootdir/input/nems_configure
adcdir=$rootdir/input/adcirc
ww3dir=$rootdir/input/realww3
atmdir=$rootdir/input/wind

NEMSDir=/projects/ees/dhs-crc/xychen/ADC-WW3-HBL-NEMS/
NEMSexe=${NEMSDir}/NEMS/exe_ww3
adcexe=${NEMSDir}/ADCIRC/work
ww3exe=${NEMSDir}/WW3/model/exe
# modify work directory accordingly
runtype=atm2wav2ocn
#workdir=$rootdir/work/${runtype}_prototype_xycwork
workdir=`pwd`
np_adc=80
np_ww3=0
np_atm=1

# complete the following model run info:
totpets=$(( ${np_adc} + ${np_ww3} + ${np_atm} ))
echo totpets=$totpets
styear=2017
stmon=11
stday=24
sthr=1
stmin=0
stsec=0
nhr=120.0

if [[ ! -d $workdir ]]; then
   mkdir -p $workdir
fi
# enter work directory:
cd ${workdir}
rm -f PET*.*LogFile
rm -f wmesmf*.nc
rm -f field_*.nc
rm -f weightmatrix*.nc



# adcprep:
${adcexe}/adcprep --np ${np_adc} --partmesh
${adcexe}/adcprep --np ${np_adc} --prepall 

#

## ================ launch NEMS.x ============== ##
 ln -s ${NEMSexe}/NEMS.x .
srun -n ${totpets} NEMS.x
#mpirun -np ${totpets} NEMS.x

## =============== Retrieve information from WW3 ==================== ##
if [[ 1 -eq 0 ]]; then
for ig in $grdn_arry; do
  cd grd_$ig
  ln -s ../out_grd.$ig out_grd.ww3
  ${ww3exe}/ww3_ounf >ounf.out
  cd ../
done
fi
