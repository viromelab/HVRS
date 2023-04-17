#!/bin/bash
#
#cp reconstructed/total_stats.tsv .
declare -a TOOLS=("coronaSPAdes" "Haploflow" "LAZYPIPE" "metaSPAdes" "metaviralSPAdes" "PEHaplo" "QuRe" "QVG" "SPAdes" "SSAKE" "TRACESPipe" "TRACESPipeLite" "VirGenA" "ViSpA")
#declare -a list
#declare -p list
#
rm -rf cnt*
mkdir cnt3
mkdir cnt0
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
  $(cat ../total_stats.tsv | tr ',' '.' | grep "${i}-" | awk '$ 15 == "3" { print $0 } ' | awk '{if ($1=="DS9" || $1=="DS10" || $1=="DS11" || $1=="DS12" || $1=="DS13" || $1=="DS14" || $1=="DS15" || $1=="DS16") {print $0}}' > "${tool}")
  echo "$(sort -t$'\t' -k13 -n ${tool})" > ${tool}
  cd ..
  
  cd cnt0 
  $(cat ../total_stats.tsv | tr ',' '.' | grep "${i}-" | awk '$15 == "0" { print $0 }' | awk '{if ($1=="DS1" || $1=="DS2" || $1=="DS3" || $1=="DS4" || $1=="DS5" || $1=="DS6" || $1=="DS7" || $1=="DS8") {print $0}}' > "${tool}")
  echo "$(sort -t$'\t' -k13 -n ${tool})" > ${tool}
  cd ..
done
#
list_cnt3=($(ls cnt3))  
list_cnt0=($(ls cnt0))
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
    set yrange [94:100.5]
    set xrange [0:42]
    set key outside right bottom
    set xtics auto
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    os = 94
    do for [ file in "${list_cnt0[@]}"]{  
      set key at 64, os
      plot file u 13:5 title file with linespoints linestyle count
      count = count + 1
      os = os + 0.47
      unset offsets
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCD_cnt0.pdf"
    set datafile separator "\t"
    set yrange [0:1]
    set xrange [0:42]
    set key outside right bottom
    set xtics auto
    set ytics auto
    set ylabel "NCD"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    os = 0
    do for [ file in "${list_cnt0[@]}"]{  
      set key at 64, os
      plot file u 13:6 title file with linespoints linestyle count
      count = count + 1
      os = os + 0.072
      unset offsets
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cnt0.pdf"
    set datafile separator "\t"
    set yrange [0:0.11]
    set xrange [0:42]
    set key outside right bottom
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    os = 0
    do for [ file in "${list_cnt0[@]}"]{  
      set key at 64, os
      plot file u 13:7 title file with linespoints linestyle count
      count = count + 1
      os = os + 0.008
      unset offsets
    }
EOF
#
cp *.pdf ..
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
    set yrange [94:100.5]
    set xrange [0:42]
    set key outside right bottom
    set xtics auto
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    os = 94
    do for [ file in "${list_cnt3[@]}"]{  
      set key at 64, os
      plot file u 13:5 title file with linespoints linestyle count
      count = count + 1
      os = os + 0.47
      unset offsets
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCD_cnt3.pdf"
    set datafile separator "\t"
    set yrange [0:1]
    set xrange [0:42]
    set key outside right bottom
    set xtics auto
    set ytics auto
    set ylabel "NCD"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    os = 0
    do for [ file in "${list_cnt3[@]}"]{  
      set key at 64, os
      plot file u 13:6 title file with linespoints linestyle count
      count = count + 1
      os = os + 0.072
      unset offsets
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cnt3.pdf"
    set datafile separator "\t"
    set yrange [0:0.13]
    set xrange [0:42]
    set key outside right bottom
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    os = 0
    do for [ file in "${list_cnt3[@]}"]{  
      set key at 64, os
      plot file u 13:7 title file with linespoints linestyle count
      count = count + 1
      os = os + 0.0095
      unset offsets
    }
EOF
#
cp *.pdf ..
cd ..
#
#
#set multiplot
#plot file u 13:5 title file with linespoints linestyle count
#rm -rf total_stats.tsv
#, "" u 13:5:5 with labels offset char 0,1
#plot "total_stats.tsv" using 13:6:(sprintf("(%d, %d)", $1, $2)) with labels notitle
#set key at 100., 100.
