require 'puppet/face/hiera_cdb'
require 'yaml'
require 'libcdb'

Puppet::Face.define(:hiera_cdb, '0.1.0') do
  action :compile do
    summary 'compile a yaml or json file to cdb'
    description <<-EOT
      loads a .yml, .yaml, .json file looping through each top-level key
      and adding an entry to the cdb file of the same name
    EOT
    when_invoked do |filename, options|
      cdb_filename = "#{filename.gsub /\.(ya?ml|json)$/, ''}.cdb"
      LibCDB::CDB.open(cdb_filename, 'w') do |cdb|
        hash = YAML.load(File.open(filename))
        hash.each do |key, value|
          cdb[key] = value.to_yaml
        end
      end
    end
  end
end
