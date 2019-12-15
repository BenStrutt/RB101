munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |k,v|
  v['age_group'] = 'kid' if v['age'] > 0 && v['age'] < 18
  v['age_group'] = 'adult' if v['age'] > 17 && v['age'] < 65
  v['age_group'] = 'senior' if v['age'] > 64
end

p munsters