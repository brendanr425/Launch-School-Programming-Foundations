flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones.each_with_object({}) do |ele, hash|
  hash[ele] = flintstones.index(ele)
end