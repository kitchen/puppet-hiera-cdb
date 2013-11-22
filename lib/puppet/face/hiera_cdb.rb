# encoding utf-8

require 'puppet/face'

Puppet::Face.define(:hiera_cdb, '0.1.0') do
  license "BSD 3-clause"
  copyright "3dna Corp", 2013
  author "Jeremy Kitchen <jeremy@nationbuilder.com>"
  summary "compile hiera yaml files to cdb"
  description <<-DESCRIPTION
    The 'hiera_cdb' Face provides tools to build cdb files for use with
    the cdb hiera backend.
  DESCRIPTION

  examples <<-EXAMPLES
    # compile a hiera yaml file to a cdb
    % puppet hiera_cdb compile /etc/puppet/hiera/global.yaml
  EXAMPLES

  notes <<-NOTES
    This is a work in progress, please report any issues to our github page.

    Check README.md for more information.
  NOTES
end
