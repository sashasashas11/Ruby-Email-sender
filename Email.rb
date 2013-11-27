def prepare_email(template_file, variable_file, destination_filename)

	template = File.open(template_file, 'r') { |file| file.read }

	File.open(variable_file, 'r') do |f|
		f.each do |line|
			key, value = line.chomp.split("=")
			template = template.gsub("%" + key + "%", value)
		end
	end

	File.open(destination_filename, 'w') { |file| file.write template }
end

prepare_email "hello.template", "hello.var", "destination.txt"


#Email
#-- read_template
#-- read_variables
#-- get_body
#
#Sender
#-- send
#
#email = Email.new(template, variable_file)
#sender = Sender.new
#sender.send(email.get_body)
#
class Email

	attr_reader :template, :variable_file

	def initialize template_file, variable_file
		@template = template_file
		@variable_file = variable_file
	end

	def read_template
		@template = File.open(@template, 'r') { |file| file.read }
	end

	def read_variables
		variables = {}
		File.open(@variable_file, 'r') do |f|
			f.each do |line|
				key, value = line.chomp.split('=')
			 variables[key] = value
			end

			variables
		end
	end

	def get_body
		template = read_template
		variables = read_variables

		variables.each do |key, value|
			template = template.gsub("%" + key + "%", value)
		end

		template
	end


end

email = Email.new('hello.template', 'hello.var')
p email.get_body
 #email.variable_file