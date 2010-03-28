class syslog::centos inherits syslog::base {
    Package[syslog]{
        name => 'sysklogd',
    }

    file{'/etc/sysconfig/syslog':
        source => [ "puppet://$server/modules/site-syslog/config/CentOS/${fqdn}/syslog", 
                    "puppet://$server/modules/site-syslog/config/CentOS/syslog.${lsbmajdistrelease}", 
                    "puppet://$server/modules/site-syslog/config/CentOS/syslog", 
                    "puppet://$server/modules/site-config/CentOS/syslog.${lsbmajdistrelease}", 
                    "puppet://$server/modules/syslog/config/CentOS/syslog" ],
        notify => Service['syslog'],
        owner => root, group => 0, mode => 0644;
    }
}
