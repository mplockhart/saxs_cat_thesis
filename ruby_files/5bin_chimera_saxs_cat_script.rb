file = File.open('5bin_chimera.com', 'w')

total_pdbs = 1002
pdbs_1_167_total = 167
pdbs_1_167 = 1
pdbs_168_334_total = 167
pdbs_168_334 = 1
pdbs_335_501_total = 167
pdbs_335_501 = 1
pdbs_502_668_total = 167
pdbs_502_668 = 1
pdbs_669_835_total = 167
pdbs_669_835 = 1
pdbs_836_1002_total = 167
pdbs_836_1002 = 1
models = 1
write = 1
rmsd = 1


file.puts 'open 5ao5_modeller.pdb'

until pdbs_1_167 == (pdbs_1_167_total + 1)
	file.puts "open 5bin_initial-1-167_#{pdbs_1_167}.pdb"
	pdbs_1_167 += 1
end

until pdbs_168_334 == (pdbs_168_334_total + 1)
	file.puts "open 5bin_initial-168-334_#{pdbs_168_334}.pdb"
	pdbs_168_334 += 1
end

until pdbs_335_501 == (pdbs_335_501_total + 1)
	file.puts "open 5bin_initial-335-501_#{pdbs_335_501}.pdb"
	pdbs_335_501 += 1
end

until pdbs_502_668 == (pdbs_502_668_total + 1)
        file.puts "open 5bin_initial-502-668_#{pdbs_502_668}.pdb"
        pdbs_502_668 += 1
end

until pdbs_669_835 == (pdbs_669_835_total + 1)
        file.puts "open 5bin_initial-669-835_#{pdbs_669_835}.pdb"
        pdbs_669_835 += 1
end

until pdbs_836_1002 == (pdbs_836_1002_total + 1)
        file.puts "open 5bin_initial-836-1002_#{pdbs_836_1002}.pdb"
        pdbs_836_1002 += 1
end


until models == (total_pdbs + 1)
	file.puts "mmaker \#0:300-400 \##{models}:300-400"
	models += 1
end

until rmsd == (total_pdbs + 1)
	file.puts "rmsd \#0 \##{rmsd}"
	rmsd += 1
end

#until write == (total_pdbs + 1)
#	file.puts "write format pdb \##{write} 3bin_initial_aligned_#{write}.pdb"
#	write += 1
#end

