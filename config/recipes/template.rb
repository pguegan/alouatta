def template(from, to, options = {})
  erb = File.read(File.expand_path("../../templates/#{from}.erb", __FILE__))
  put ERB.new(erb).result(binding), to
end