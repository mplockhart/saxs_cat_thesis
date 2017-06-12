#!/usr/local/bin/ruby -w

require 'benchmark'

time = Benchmark.measure do

#	puts 'Running CNS runs'
#	system('./parallel_cns.sh')

	puts 'Making Chimera script.'
	system('ruby chimera_saxs_cat_script.rb')

	puts 'Aligning models in Chimera'
	system %(
  		source ~/.bashrc
  		shopt -s expand_aliases
  		chimera --nogui chimera_saxs_cat_script.com > 3bin_compare.log
	)
	system("grep 'angstrom' 3bin_compare.log > 3bin_rmsd.log")
	system('pluma 3bin_rmsd.log &')

end

puts "This took #{time}"
