#!/bin/bash

# datasets

#c__ic50 e__ic50 o__ic50 h__ic50 c_e__ic50 c_h__ic50 c_o__ic50 e_h__ic50 e_o__ic50 h_o__ic50 c_e_h__ic50 c_e_o__ic50 e_h_o__ic50 c_e_h_o__ic50

#c__acta e__acta o__acta h__acta c_e__acta c_h__acta c_o__acta e_h__acta e_o__acta h_o__acta c_e_h__acta c_e_o__acta e_h_o__acta c_e_h_o__acta

#sc__sauc se__sauc so__sauc sh__sauc sc_se__sauc sc_sh__sauc sc_so__sauc se_sh__sauc se_so__sauc sh_so__sauc sc_se_sh__sauc sc_se_so__sauc se_sh_so__sauc sc_se_sh_so__sauc

#sc__sic50 se__sic50 so__sic50 sh__sic50 sc_se__sic50 sc_sh__sic50 sc_so__sic50 se_sh__sic50 se_so__sic50 sh_so__sic50 sc_se_sh__sic50 sc_se_so__sic50 se_sh_so__sic50 sc_se_sh_so__sic50

# WARNING: make sure that SET matches the data!!!!!!
DATAPANEL=ccle
REQMEM=64
EXPFOLD=1   

for DATA in c_e__ic50 c_h__ic50 c_o__ic50 e_h__ic50 e_o__ic50 ; do
        for HIDCOMP in 24 50 100; do

                FNAME=sub_"$DATA"_"$HIDCOMP"_"$EXPFOLD"
                echo 'Executable = /usr/bin/Rscript' > $FNAME
                echo 'Universe = vanilla' >> $FNAME
                echo "Error = stderr/gbca_$DATA.$HIDCOMP.err."'$(Cluster).$(Process)' >> $FNAME
                echo "Output = stdout/gbca_$DATA.$HIDCOMP.out."'$(Cluster).$(Process)' >> $FNAME
                echo "K=$HIDCOMP" >> $FNAME
                echo 'RREST=50' >> $FNAME
                echo "SET=$DATAPANEL" >> $FNAME
                echo "EXP=$EXPFOLD" >> $FNAME
                echo "request_memory = $REQMEM GB" >> $FNAME
                echo "Arguments = --vanilla code/run.R cv gbca  $DATA"  ' $(K) $(RREST) $(SET) $(EXP) results/cv/' >> $FNAME
                echo 'queue' >> $FNAME

        done
done
