# Hiera CDB module

This module provides an alternative backend for hiera to do faster lookups from YAML files.

It provides a face to compile your YAML/json (since json is YAML) to cdb, and a hiera backend for performing lookus.


# Why CDB?

I've been a huge [djb](http://cr.yp.to/djb.html) fan for a very long time, and cdb has always seemed really awesome to me.
When I first started working with hiera and hearing about the limitations, I thought CDB seemed like a perfect fit.

Since a hiera yaml backend is effectively a flat hash, we can compile the top level of that hash into something much more efficient to look up and not have to parse the entire YAML file on every lookup.
This is especially important, I think, for hieras like mine which have a rather large 'global.yaml' file (you could probably argue that I shouldn't have such a large global.yaml, but I do).

CDB itself is public domain, in [benchmarks](http://qdbm.sourceforge.net/benchmark.pdf) it's proven to be really fast, and the compiled files it creates are [portable](http://cr.yp.to/cdb/cdb.txt), and since we're not trying to do on-the-fly modification of the files, only precompilation, it's a good match!

# Usage

To compile your yaml or json files into cdb, use the `hiera_cdb` face:

    puppet hiera_cdb compile /etc/puppet/hiera/global.yaml

To configure hiera to use cdb, in `/etc/puppet/hiera.yaml`:

    ---
    :backends:
      - cdb
    :cdb:
      :datadir: /etc/puppet/hiera/global.yaml
    :hierarchy:
      - node/%{fqdn}
      - environment/%{environment}
      - global

# Requirements

This requires the `libcdb-ruby` gem to be installed. This, itself, has its own dependencies. On Ubuntu you need the `libcdb-dev` and `libcdb1` packages installed.

Note that the `libcdb-ruby` gem requires ruby 1.9.2 or better for installation. I may switch out the cdb library required at some point to make it more compatible.

If you simply `include hiera_cdb` in your master's catalog it should take care of this for you. Note that I have not tested this part on anything other than ubuntu, so YMMV and please send PRs for any portability concerns!

# TODO

I'd like to make a 'make'-like function for the face which will walk your hiera datadir and compile everything for you, as if you had a Makefile in the top level of your hiera data dir (which is actually what I do)


# License

Copyright 2013 3dna Corp

This project is released under the BSD 3-clause license. Please see LICENSE for more information.


# Contact

Jeremy Kitchen <jeremy@nationbuilder.com>


# Support

Please log tickets and issues at our [github project page](https://github.com/3dna/puppet-hiera-cdb)
