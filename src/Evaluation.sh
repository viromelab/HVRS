#!/bin/bash
#
declare -a DATASETS=("DS1" "DS2" "DS3");
#declare -a DATASETS=("DS1");
declare -a VIRUSES=("SVA" "B19" "HPV" "VZV");
#
D_PATH="reconstructed";
#
cd $D_PATH
echo "Dataset	File	Nr_bases	Total_Nr_Aligned_Bases	SNPs	AvgIdentity	Time	Mem	%CPU" > total_stats.tsv
for dataset in "${DATASETS[@]}" #analyse each virus
  do
  printf "$dataset\n";	  
  #for virus in "${VIRUSES[@]}" #analyse each virus
    #do
  for file in `cd ${dataset};ls -1 ${file} *.fa*` #for each fasta file in curr dir
  do 	 
    printf "\n\nFile: $file\nDataset: $dataset \n\n"; #print file name, virus and dataset	  
    #cp $dataset/$file G_A.fa; #reference
    #cp ../$dataset.fa G_B.fa #query
    #
    dnadiff $dataset/$file ../$dataset.fa ; #run dnadiff
    #quast $dataset/$file -r ../$dataset.fa ; #run quast
    #mv quast_results/results_*_*_*_*_* quast_results/results_${dataset}_$file
    #
    IDEN=`cat out.report | grep "AvgIdentity " | head -n 1 | awk '{ print $2;}'`;  #retrieve results
    ALBA=`cat out.report | grep "AlignedBases " | head -n 1 | awk '{ print $2;}'`;
    SNPS=`cat out.report | grep TotalSNPs | awk '{ print $2;}'`;
    TBASES=`cat out.report | grep "TotalBases" | awk '{ print $2;}'`;
    AUX="$(cut -d')' -f1 <<< "$ALBA")"
    PERALBA="$(cut -d'(' -f2 <<< "$AUX")"
    TALBA="$(cut -d'(' -f1 <<< "$ALBA")"    
    NRBASES=`cat out.report | grep "TotalBases" | awk '{ print $2;}'`;  
    
    file_wout_extension="$(cut -d'.' -f1 <<< $file)"
    TIME=`cat $dataset/$file_wout_extension-time.txt | grep "TIME" | awk '{ print $2;}'`;
    MEM=`cat $dataset/$file_wout_extension-time.txt | grep "MEM" | awk '{ print $2;}'`;
    CPU_P=`cat $dataset/$file_wout_extension-time.txt | grep "CPU_perc" | awk '{ print $2;}'`;
    
    #ds/file	tbases	alignedbases	snps	avg_identity
    echo "$dataset	$file	$NRBASES	$TALBA	$SNPS	$IDEN	$TIME	$MEM	$CPU_P" >> total_stats.tsv
    printf "%s\t%s\t%s\n" "$ALBA" "$IDEN" "$SNPS";
    rm -f G_A.fa G_B.fa ; #remove tmp files
  done
done
#
