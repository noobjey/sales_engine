# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rake', :task => 'test' do
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('test/test_helper.rb')  { "test" }
end
