munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

male_munsters = munsters.select{|name, stats| stats["gender"] == "male"}
sum_of_ages = 0
male_munsters.each_value{|stats| sum_of_ages += stats["age"]}
# sum_of_ages => 444