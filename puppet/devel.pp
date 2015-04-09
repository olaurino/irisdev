
$home_dir = "/home/vagrant"

exec { "update":
  command => "/usr/bin/apt-get update",
}

class { 'python' :
  version    => 'system',
  pip        => true,
  dev        => true,
}

class iris-dev {
  package {['openjdk-7-jdk',
    'gsettings-desktop-schemas',
    'python-numpy',
    'python-tk',
    'python-scipy',
    'maven',
    'bison',
    'flex',
    'gfortran']:
    ensure => present,
    require => Exec['update']
  }
}

include iris-dev

include git

vcsrepo { "${home_dir}/sherpa-samp":
  ensure   => present,
  provider => git,
  source => "https://github.com/ChandraCXC/sherpa-samp",
  revision => "release/iris-2.1",
  user => "vagrant",
}

vcsrepo { "${home_dir}/sherpa":
  ensure   => present,
  provider => git,
  source => "https://github.com/olaurino/sherpa",
  revision => "develop",
  user => "vagrant",
}

vcsrepo { "${home_dir}/iris":
  ensure   => present,
  provider => git,
  source => "file:///vagrant/iris",
  revision => "release/2.1",
  user => "vagrant",
}

vcsrepo { "${home_dir}/sedstacker":
  ensure   => present,
  provider => git,
  source => "https://github.com/jbudynk/sedstacker",
  revision => "release/iris2.1",
  user => "vagrant",
}

python::pip { 'sampy':
  pkgname => 'sampy',
  require => Class['python'],
}

python::pip { 'astlib':
  pkgname => 'astlib',
  require => Class['python'],
}

python::pip { 'sherpa':
  pkgname => 'sherpa',
  url => "file://${home_dir}/sherpa",
  require => [Class['python'], Vcsrepo["${home_dir}/sherpa"]],
}

python::pip { 'sedstacker':
  pkgname => 'sedstacker',
  url => "file://${home_dir}/sedstacker",
  require => [Class['python'], Vcsrepo["${home_dir}/sedstacker"]],
}

python::pip { 'sherpa-samp':
  pkgname => 'sherpa-samp',
  url => "file://${home_dir}/sherpa-samp",
  require => [Python::Pip['astlib'],
    Python::Pip['sampy'],
    Python::Pip['sherpa'],
    Python::Pip['sedstacker'],
    Vcsrepo["${home_dir}/sherpa-samp"]],

}

file {'bashrc':
  path    => "${home_dir}/.bashrc",
  ensure  => present,
  content => "export IRIS_EXTRA_FLAGS=\"-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005\"
alias iris=\"${home_dir}/iris/iris/target/Iris --test\"
",
}
