# TJ_Tool


## Transparent Journalism Tool

By _Público_ (http://www.publico.es)

Project webpage (Spanish): http://www.periodismotransparente.es/


## What is TJ_Tool?

This tool tries to automate the detection of transparency elements in a news article. 
It's integreted in the publisher's CMS, but it can be used as a standalone tool too.

## Architecture

TJ_Tool is pluggable in any CMS. Its components are:

- Core backend: it provides all the logic, definitions, configuration, security and authentication, API calls, an administrative interface and the output products: *Transparency Map*, *Economic Calculator*, *Transparency Calculator* and reports.
Implemented as a Symfony 3 project.
- Connectors: simple backend and frontend scripts that acts as bridge between a particular CMS and the core backend. Implemented as a Silex backend and Bootstrap frontend.
- Frontend adaptor: scripts that are embebed in the CMS in order to load the connector into the CMS.
- Frontend widgets: scripts and assets used to render in the public webpage widgets or resources that links the output products. Each publisher *decides* which products are shown in the webpage.

_Público_ offers in this project branch an integration example with Wordpress.

## Project structure

```
CMS-Wordpress: adapter for Wordpress
 |
 ----> publico-tjtool: Wordpress plugin (wp-content/plugins/publico-tjtool)

TJ_Tool Connector: bridge between CoreBackend and external CMS.

TJ_Tool Core Backend: administrator inteface, API endpoint, products generator.
```


## Requirements

* PHP 7.0 or greater
* Extensions: xml, mbstring, mysql, intl, curl
* Elastic Search server
* Mysql Server 5.5 or greater

It can be deployed to any web server, example configuration for Apache:

*/etc/apache2/sites-enabled/001-backend.conf*

```
<VirtualHost *:80>
    ServerName backend.tjt-wp-server 

    ServerAdmin webmaster@localhost
    DocumentRoot /home/tjt/www/backend/web

    ErrorLog ${APACHE_LOG_DIR}/backend-error.log
    CustomLog ${APACHE_LOG_DIR}/backend-access.log combined
    <Directory /home/tjt/www/backend/web>   
        Require all granted
        AllowOverride All
    </Directory>
</VirtualHost>
```


*/etc/apache2/sites-enabled/002-connector.conf*

```
<VirtualHost *:80>
    ServerName connector.tjt-wp-server 

    ServerAdmin webmaster@localhost
    DocumentRoot /home/tjt/www/connector/web

    ErrorLog ${APACHE_LOG_DIR}/connector-error.log
    CustomLog ${APACHE_LOG_DIR}/connector-access.log combined
    <Directory /home/tjt/www/connector/web> 
        Require all granted
        AllowOverride All
    </Directory>
</VirtualHost>
```

*/etc/apache2/sites-enabled/003-wordpress.conf*

```
<VirtualHost *:80>
    ServerName wordpress.tjt-wp-server 

    ServerAdmin webmaster@localhost
    DocumentRoot /home/tjt/www/wordpress

    ErrorLog ${APACHE_LOG_DIR}/wordpress-error.log
    CustomLog ${APACHE_LOG_DIR}/wordpress-access.log combined
    <Directory /home/tjt/www/wordpress> 
        Require all granted
        AllowOverride All
    </Directory>
</VirtualHost>
```


## Virtual Machine install

Download .ova file and import it into Virtual Box

http://www.periodismotransparente.es/ova/TJ_Tool_Wordpres_Integration.ova

Credentials:

- User (sudo enabled): tjt
- Password: tjt

Hostname: 

- tjt-wp-server
- backend.tjt-wp-server
- connector.tjt-wp-server
- wordpress.tjt-wp-server


### Setup

The Virtual Box image is configured as “bridge”. The guest will adquire its own IP address.
Log-in the virtual machine and run “ifconfig” in order to know its IP.

In your workstation, edit your hosts file in order to access the virtual machine.

Linux, MacOSX: /etc/hosts
Windows: C:\Windows\System32\drivers\etc\hosts
 
Add this line to your hosts file (change VIRTUAL-MACHINE-IP to the virtual machine IP)

VIRTUAL-MACHINE-IP	tjt-wp-server backend.tjt-wp-server connector.tjt-wp-server wordpress.tjt-wp-server

Now, you can access, using the provided credentials:

SSH: ssh tjt@tjt-wp-server
Wordpress: http://wordpress.tjt-wp-server/wp-admin/
TJ_Tool backend: http://backend.tjt-wp-server/admin/dashboard

### Virtual machine components

Mysql (data: /var/lib/mysql)
Root user, password: tjt

*Database TJ_Tool*
- DB name: tjt
- DB user: tjt
- DB password: tjt

*Database Wordpres*
- DB name: wp
- DB user: wp
- DB password: wp


Apache
- Vhost: backend.tjt-wp-server in /home/tjt/www/backend
- Vhost: connector.tjt-wp-server in /home/tjt/www/connector
- Vhost: wordpress.tjt-wp-server in /home/tjt/www/wordpress


Wordpress /wp-admin
- Admin user: tjt
- Password: tjt


TJ_Tool backend http://backend.tjt-wp-server/admin

ROLE_SUPER_ADMIN
- User: admin
- Password: admin

ROLE_ADMIN
- User: admin1
- Password: admin1

ROLE_AUTHOR_ADMIN
- User: admin2
- Password: admin2

ROLE_JOURNALIST
- User: journalist
- Password: journalist



