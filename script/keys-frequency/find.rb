# Поиск самых популярных последовательностей символов


require 'pry'
files = Dir.glob("/FOLDER_WITH_CODE/**/*.ts").reject {|f| f =~ /node_modules/}
p "files: #{files.size}"

result = Hash.new(0)
shingle_size = 1

files.each do |file|
	content = File.read(file)
	

	i = 0
	while i < content.size - shingle_size
		shingle = content[i..i + shingle_size - 1]

		if shingle !~ /^[a-zA-Z0-9 ]+$/
			result[shingle] += 1
		end
		i += 1
	end

end

puts result.keys.size
puts result.sort_by {|_key, value| -value}.take(50).map { |k, v| "#{k}\t#{v}"}

# Most frequently symbols:
# Ruby: _ : . , ' ( ) = @ { } " [ ] ? |
# TS:   ; , : ( ) . { } = / _ < > - [ ]
# Both: _ : . , ( ) = { } [ ]



#
# Ruby
# _  : . , ' ( ) = @ { } " [ ] ? | - # / < & ! > % * + $ ; \ `
# _ : 292031
# : : 159646
# . : 109548
# , : 73649
# ' : 49233
# ( : 45629
# ) : 45629
# = : 26148
# @ : 19231
# { : 17499
# } : 17499
# " : 15661
# [ : 14385
# ] : 14381
# ? : 11502
# | : 8900
# - : 8175
# # : 8118
# / : 6103
# < : 5012
# & : 4085
# ! : 2854
# > : 2796
# % : 2311
# * : 1187
# + : 582
# о : 527
# $ : 477
# и : 432
# ; : 384
# е : 340
# \ : 330
# а : 313
# н : 311
# с : 301
# т : 272
# п : 224
# в : 218
# л : 198
# ` : 194
# р : 189


# TypeScript
# ; ' , : ( ) . { } = / _ > - [ ] < | ? & * @ ! ` " $ # + % \ ^
# ; : 24748
# ' : 24013
# , : 19498
# : : 18228
# ( : 18038
# ) : 18034
# . : 16281
# { : 14709
# } : 14709
# = : 13521
# / : 12048
# _ : 8352
# > : 7139
# - : 4625
# [ : 4615
# ] : 4615
# < : 3651
# | : 3533
# ? : 2479
# & : 1090
# * : 578
# @ : 485
# ! : 455
# ` : 340
# " : 308
# $ : 241
# # : 166
# + : 133
# % : 47
# \ : 38
# ^ : 11

