#!/bin/bash

#$ -S /bin/csh       
#$ -V                 
#$ -cwd

source /mnt/fls01-home01/mqbpkml3/software/cns_solve_1.3/cns_solve_env

cns < 3bin_1-167.inp > 1_initial.log
cns < 3bin_168-334.inp > 2_initial.log
cns < 3bin_335-501.inp > 3_initial.log
cns < 3bin_502-668.inp > 4_initial.log
cns < 3bin_669-835.inp > 5_initial.log
cns < 3bin_836-1002.inp > 6_initial.log
cns < 4bin_1-167.inp > 7_initial.log
cns < 4bin_168-334.inp > 8_initial.log
cns < 4bin_335-501.inp > 9_initial.log
cns < 4bin_502-668.inp > 10_initial.log
cns < 4bin_669-835.inp > 11_initial.log
cns < 4bin_836-1002.inp > 12_initial.log
cns < 5bin_1-167.inp > 13_initial.log
cns < 5bin_168-334.inp > 14_initial.log
cns < 5bin_335-501.inp > 15_initial.log
cns < 5bin_502-668.inp > 16_initial.log
cns < 5bin_669-835.inp > 17_initial.log
cns < 5bin_836-1002.inp > 18_initial.log
