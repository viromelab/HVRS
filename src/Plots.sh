#!/bin/bash
#
cp reconstructed/total_stats.tsv .
declare -a TOOLS=("coronaSPAdes" "Haploflow" "IRMA" "LAZYPIPE" "metaSPAdes" "metaviralSPAdes" "PEHaplo" "QuRe" "QVG" "SPAdes" "SSAKE" "TRACESPipe" "TRACESPipeLite" "VirGenA" "ViSpA" "V-pipe")
#declare -a list
#declare -p list
#
rm -rf cnt*
rm -rf cvg*
#rm -rf Graphs
mkdir cnt3
mkdir cnt0
mkdir cvg2
mkdir cvg5
mkdir cvg10
mkdir cvg20
mkdir cvg40
mkdir Graphs
i=""
declare ans
check_condition() {
  is_fst_set=$(printf '%s\n' "${FIRST_SET[@]}" | grep -w -- $dataset)
  
  if [ ! -z "$cov_2" ]
    then
    ans=1 
  else
    ans=0
  fi
}

for tool in "${TOOLS[@]}" 
  do
  
  i=$(echo "$tool" | tr '[:upper:]' '[:lower:]' )
  
  cd cnt3  
  $(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS9" || $1=="DS10" || $1=="DS11" || $1=="DS12" || $1=="DS13" || $1=="DS14" || $1=="DS15" || $1=="DS16") {print $0}}' > "${tool}")
  echo "$(sort -t$'\t' -k13 -n ${tool})" > ${tool}
  cd ..
  
  cd cnt0 
  $(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS1" || $1=="DS2" || $1=="DS3" || $1=="DS4" || $1=="DS5" || $1=="DS6" || $1=="DS7" || $1=="DS8") {print $0}}' > "${tool}")
  echo "$(sort -t$'\t' -k13 -n ${tool})" > ${tool}
  cd ..
  
  cd cvg2 
  $(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS9" || $1=="DS17" || $1=="DS18" || $1=="DS19" || $1=="DS20" || $1=="DS21" || $1=="DS22" || $1=="DS23" || $1=="DS24") {print $0}}' > "${tool}")
  echo "$(sort -t$'\t' -k 14 ${tool})" > ${tool}
  cd ..
  
  cd cvg5 
  $(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS10" || $1=="DS25" || $1=="DS26" || $1=="DS27" || $1=="DS28" || $1=="DS29" || $1=="DS30" || $1=="DS31" || $1=="DS32") {print $0}}' > "${tool}")
   echo "$(sort -t$'\t' -k 14 ${tool})" > ${tool}
  cd ..
  
  cd cvg10
  $(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS11" || $1=="DS33" || $1=="DS34" || $1=="DS35" || $1=="DS36" || $1=="DS37" || $1=="DS38" || $1=="DS39" || $1=="DS40") {print $0}}' > "${tool}")
   echo "$(sort -t$'\t' -k 14 ${tool})" > ${tool}
  cd ..
  
  cd cvg20 
  $(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS13" || $1=="DS41" || $1=="DS42" || $1=="DS43" || $1=="DS44" || $1=="DS45" || $1=="DS46" || $1=="DS47" || $1=="DS48") {print $0}}' > "${tool}")
  echo "$(sort -t$'\t' -k 14 ${tool})" > ${tool}
  cd ..
  
  cd cvg40 
  $(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS16" || $1=="DS49" || $1=="DS50" || $1=="DS51" || $1=="DS52" || $1=="DS53" || $1=="DS54" || $1=="DS55" || $1=="DS56") {print $0}}' > "${tool}")
  echo "$(sort -t$'\t' -k 14 ${tool})" > ${tool}
  cd ..
  
  
done
#
list_cnt3=($(ls cnt3))  
list_cnt0=($(ls cnt0))
list_cvg2=($(ls cvg2))
list_cvg5=($(ls cvg5))
list_cvg10=($(ls cvg10))
list_cvg20=($(ls cvg20))
list_cvg40=($(ls cvg40))
#  
#printf "${list[*]} \n\n"
#
cd cnt0
#
gnuplot << EOF
    reset
    
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 100.5
    ymin = 90
    offset = ( ymax - ymin ) / 16.0   
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Identity"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1 
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'
    
    count = 1

    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      set style line count
      plot file u 13:5 title file with linespoints linestyle count
      
      count = count + 1
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NCSD"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  

    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'
    
    count = 1

    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      plot file u 13:6 title file with linespoints linestyle count
      
      count = count + 1
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  

    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'
    
    count = 1

    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      plot file u 13:7 title file with linespoints linestyle count
      
      count = count + 1
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 4000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Number of bases reconstructed"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      plot file u 13:16 title file with linespoints linestyle count
      
      count = count + 1
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Minimum scaffold length"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      plot file u 13:17 title file with linespoints linestyle count
      
      count = count + 1
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 140000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Maximum scaffold length"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1

    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'  
    
    count = 1

    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      plot file u 13:18 title file with linespoints linestyle count
      
      count = count + 1
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 60000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average scaffold length"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  

    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'
    
    count = 1

    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      plot file u 13:19 title file with linespoints linestyle count
      
      count = count + 1
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_wout_n_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 4000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Number of bases reconstructed (excluding N)"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      plot file u 13:20 title file with linespoints linestyle count
      
      count = count + 1
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_wout_n_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Minimum scaffold length (excluding N)"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  

    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'
    
    count = 1

    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      plot file u 13:21 title file with linespoints linestyle count
      
      count = count + 1
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_wout_n_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 140000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Maximum scaffold length (excluding N)"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1 

    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b' 
    
    count = 1

    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      plot file u 13:22 title file with linespoints linestyle count
      
      count = count + 1
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_wout_n_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 60000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average scaffold length (excluding N)"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      plot file u 13:23 title file with linespoints linestyle count
      
      count = count + 1
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 0.015
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      plot file u 13:24 title file with linespoints linestyle count
      
      count = count + 1
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_wout_n_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 0.015
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed (excluding N)"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  

    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'
    
    count = 1
    
    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      plot file u 13:25 title file with linespoints linestyle count
      
      count = count + 1
      ymax = ymax - offset
      
    }
EOF
#
cp *.pdf ../Graphs
cd ..
#
#
#
cd cnt3
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cnt3.pdf"
    set datafile separator "\t"
    
    ymax = 100.5
    ymin = 60
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Identity"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:5 title file with linespoints linestyle count
      
      count = count + 1
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cnt3.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NCSD"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1 

    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b' 
    
    count = 1

    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:6 title file with linespoints linestyle count
      
      count = count + 1
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cnt3.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1
    
    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:7 title file with linespoints linestyle count
      count = count + 1  
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_cnt3.pdf"
    set datafile separator "\t"
    
    ymax = 5000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Number of bases reconstructed"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:16 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_cnt3.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Minimum scaffold length"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:17 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_cnt3.pdf"
    set datafile separator "\t"
    
    ymax = 140000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Maximum scaffold length"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:18 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_cnt3.pdf"
    set datafile separator "\t"
    
    ymax = 60000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average scaffold length"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:19 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_wout_n_cnt3.pdf"
    set datafile separator "\t"
    
    ymax = 5000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Number of bases reconstructed (excluding N)"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:20 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_wout_n_cnt3.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Minimum scaffold length (excluding N)"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:21 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_wout_n_cnt3.pdf"
    set datafile separator "\t"
    
    ymax = 140000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Maximum scaffold length (excluding N)"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:22 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_wout_n_cnt3.pdf"
    set datafile separator "\t"
    
    ymax = 60000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average scaffold length (excluding N)"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:23 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_cnt3.pdf"
    set datafile separator "\t"
    
    ymax = 0.025
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:24 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_wout_n_cnt3.pdf"
    set datafile separator "\t"
    
    ymax = 0.025
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed (excluding N)"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:25 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
cp *.pdf ../Graphs
cd ..
#
#
cd cvg2
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cvg2.pdf"
    set datafile separator "\t"
    ymax = 100.5
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Identity"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:5 title file with linespoints linestyle count
      count = count + 1
      
     

      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cvg2.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NCSD"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:6 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cvg2.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:7 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_cvg2.pdf"
    set datafile separator "\t"
    
    ymax = 3000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Number of bases reconstructed"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:16 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_cvg2.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Minimum scaffold length"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:17 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_cvg2.pdf"
    set datafile separator "\t"
    
    ymax = 140000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Maximum scaffold length"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:18 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_cvg2.pdf"
    set datafile separator "\t"
    
    ymax = 60000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average scaffold length"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:19 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_wout_n_cvg2.pdf"
    set datafile separator "\t"
    
    ymax = 3000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Number of bases reconstructed (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:20 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_wout_n_cvg2.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Minimum scaffold length (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:21 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_wout_n_cvg2.pdf"
    set datafile separator "\t"
    
    ymax = 140000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Maximum scaffold length (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:22 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_wout_n_cvg2.pdf"
    set datafile separator "\t"
    
    ymax = 60000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average scaffold length (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:23 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_cvg2.pdf"
    set datafile separator "\t"
    
    ymax = 0.16
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:24 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_wout_n_cvg2.pdf"
    set datafile separator "\t"
    
    ymax = 0.16
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:25 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
cp *.pdf ../Graphs
cd ..
#
#
#
cd cvg5
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cvg5.pdf"
    set datafile separator "\t"
    ymax = 100.5
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Identity"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:5 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cvg5.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NCSD"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:6 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cvg5.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:7 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_cvg5.pdf"
    set datafile separator "\t"
    
    ymax = 6000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Number of bases reconstructed"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:16 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_cvg5.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Minimum scaffold length"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:17 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_cvg5.pdf"
    set datafile separator "\t"
    
    ymax = 140000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Maximum scaffold length"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:18 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_cvg5.pdf"
    set datafile separator "\t"
    
    ymax = 60000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average scaffold length"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:19 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_wout_n_cvg5.pdf"
    set datafile separator "\t"
    
    ymax = 6000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Number of bases reconstructed (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:20 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_wout_n_cvg5.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Minimum scaffold length (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:21 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_wout_n_cvg5.pdf"
    set datafile separator "\t"
    
    ymax = 140000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Maximum scaffold length (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:22 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_wout_n_cvg5.pdf"
    set datafile separator "\t"
    
    ymax = 60000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average scaffold length (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:23 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_cvg5.pdf"
    set datafile separator "\t"
    
    ymax = 0.14
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:24 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_wout_n_cvg5.pdf"
    set datafile separator "\t"
    
    ymax = 0.14
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:25 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
cp *.pdf ../Graphs
cd ..
#
#
#
cd cvg10
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cvg10.pdf"
    set datafile separator "\t"
    ymax = 100.5
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Identity"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:5 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cvg10.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NCSD"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:6 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cvg10.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:7 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_cvg10.pdf"
    set datafile separator "\t"
    
    ymax = 5500000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Number of bases reconstructed"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:16 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_cvg10.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Minimum scaffold length"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:17 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_cvg10.pdf"
    set datafile separator "\t"
    
    ymax = 200000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Maximum scaffold length"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:18 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_cvg10.pdf"
    set datafile separator "\t"
    
    ymax = 60000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average scaffold length"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:19 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_wout_n_cvg10.pdf"
    set datafile separator "\t"
    
    ymax = 5500000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Number of bases reconstructed (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:20 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_wout_n_cvg10.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Minimum scaffold length (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:21 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_wout_n_cvg10.pdf"
    set datafile separator "\t"
    
    ymax = 200000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Maximum scaffold length (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:22 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_wout_n_cvg10.pdf"
    set datafile separator "\t"
    
    ymax = 60000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average scaffold length (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:23 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_cvg10.pdf"
    set datafile separator "\t"
    
    ymax = 0.10
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:24 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_wout_n_cvg10.pdf"
    set datafile separator "\t"
    
    ymax = 0.10
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:25 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
cp *.pdf ../Graphs
cd ..
#
#
#
cd cvg20
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cvg20.pdf"
    set datafile separator "\t"
    ymax = 100.5
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Identity"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:5 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cvg20.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NCSD"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:6 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cvg20.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:7 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_cvg20.pdf"
    set datafile separator "\t"
    
    ymax = 7000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Number of bases reconstructed"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:16 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_cvg20.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Minimum scaffold length"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:17 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_cvg20.pdf"
    set datafile separator "\t"
    
    ymax = 1500000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Maximum scaffold length"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:18 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_cvg20.pdf"
    set datafile separator "\t"
    
    ymax = 325000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average scaffold length"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:19 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_wout_n_cvg20.pdf"
    set datafile separator "\t"
    
    ymax = 7000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Number of bases reconstructed (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:20 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_wout_n_cvg20.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Minimum scaffold length (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:21 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_wout_n_cvg20.pdf"
    set datafile separator "\t"
    
    ymax = 1500000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Maximum scaffold length (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:22 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_wout_n_cvg20.pdf"
    set datafile separator "\t"
    
    ymax = 325000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average scaffold length (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:23 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_cvg20.pdf"
    set datafile separator "\t"
    
    ymax = 0.06
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:24 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_wout_n_cvg20.pdf"
    set datafile separator "\t"
    
    ymax = 0.06
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:25 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
cp *.pdf ../Graphs
cd ..
#
#
#
cd cvg40
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cvg40.pdf"
    set datafile separator "\t"
    ymax = 100.5
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Identity"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:5 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cvg40.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NCSD"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:6 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cvg40.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:7 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_cvg40.pdf"
    set datafile separator "\t"
    
    ymax = 7500000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Number of bases reconstructed"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:16 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_cvg40.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Minimum scaffold length"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:17 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_cvg40.pdf"
    set datafile separator "\t"
    
    ymax = 1000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Maximum scaffold length"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:18 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_cvg40.pdf"
    set datafile separator "\t"
    
    ymax = 200000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average scaffold length"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:19 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_wout_n_cvg40.pdf"
    set datafile separator "\t"
    
    ymax = 7500000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Number of bases reconstructed (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:20 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_wout_n_cvg40.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Minimum scaffold length (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:21 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_wout_n_cvg40.pdf"
    set datafile separator "\t"
    
    ymax = 1000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Maximum scaffold length (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:22 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_wout_n_cvg40.pdf"
    set datafile separator "\t"
    
    ymax = 200000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average scaffold length (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:23 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_cvg40.pdf"
    set datafile separator "\t"
    
    ymax = 0.06
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:24 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_wout_n_cvg40.pdf"
    set datafile separator "\t"
    
    ymax = 0.06
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed (excluding N)"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:25 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
cp *.pdf ../Graphs
cd ..
./Plots2.sh
#
#
