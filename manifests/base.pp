class syslog::base {
    package{syslog:
        ensure => present,
    }

    file{'/etc/syslog.conf':
        source => [ "puppet://$server/modules/site-syslog/config/${fqdn}/syslog.conf", 
                    "puppet://$server/modules/site-syslog/config/${domain}/syslog.conf",
                    "puppet://$server/modules/site-syslog/config/${operatingsystem}/syslog.conf",
                    "puppet://$server/modules/site-syslog/config/syslog.conf", 
                    "puppet://$server/modules/syslog/config/${operatingsystem}/syslog.conf",
                    "puppet://$server/modules/syslog/config/syslog.conf"],
        notify => Service['syslog'],
        require => Package['syslog'],
        owner => root, group => 0, mode => 0644;
    }

    service{syslog:
        ensure => running,
        enable => true,
        hasstatus => true,
        require => Package['syslog'],
    }
}
