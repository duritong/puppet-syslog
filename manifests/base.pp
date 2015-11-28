# basic syslog stuff
class syslog::base {
  package{'syslog':
    ensure => present,
  }

  file{'/etc/syslog.conf':
    source  => [ "puppet:///modules/site_syslog/config/${::fqdn}/syslog.conf",
                  "puppet:///modules/site_syslog/config/${::domain}/syslog.conf",
                  "puppet:///modules/site_syslog/config/${::operatingsystem}/syslog.conf",
                  'puppet:///modules/site_syslog/config/syslog.conf',
                  "puppet:///modules/syslog/config/${::operatingsystem}/syslog.conf",
                  'puppet:///modules/syslog/config/syslog.conf'],
    notify  => Service['syslog'],
    require => Package['syslog'],
    owner   => root,
    group   => 0,
    mode    => '0644';
  }

  service{'syslog':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['syslog'],
  }
}
