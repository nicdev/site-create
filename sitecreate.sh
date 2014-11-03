#!/bin/bash

# LAMP/LEMP stack site creation (Ubuntu)

# Prompt for the name of the site
echo -n "Domain Name: "
read domain

# Location of site files
echo -n "Where do you want to create the site's directory [ENTER for /var/www/$domain]: "
read root_location

if [ ! $root_location ]
then
	root_location="/var/www/$domain"
fi

# Check whether the directory exists or create it
if [ ! -e "$root_location" ]
then
	mkdir -p $root_location > /dev/null 2>&1

	if [ $? != 0 ]
	then
		echo "Directory creation failed. Check permissions."
		exit 1
	else
		echo "Directory $root_location created"
	fi
else
	echo "Directory already exists"
fi

# @TODO Working on Apache first, NGINX to follow 

# Create basic Apache site config file
# site_config=$(printf "<VirtualHost *:80>\n \
#                         DocumentRoot \"%s\" \n \
#                         ServerName %s \n \
#                         ServerAlias %s \n \
#                         DirectoryIndex index.php index.html \n \
#                 </VirtualHost>" "$root_location" "$domain" "www.$domain") 

#@TODO add error checking, no overwrite, etc
conf_file=$domain.conf
# echo $site_config;
# print $site_config > /etc/apache2/sites-available/$conf_file

echo "<VirtualHost *:80>" > /etc/apache2/sites-available/$conf_file
echo "DocumentRoot $root_location" >> /etc/apache2/sites-available/$conf_file
echo "ServerName $domain" >> /etc/apache2/sites-available/$conf_file
echo "ServerAlias www.$domain" >> /etc/apache2/sites-available/$conf_file
echo "DirectoryIndex index.php index.html" >> /etc/apache2/sites-available/$conf_file
echo "</VirtualHost>" >> /etc/apache2/sites-available/$conf_file

a2ensite $domain.conf

service apache2 reload

echo "Done and done."

# if [ $? != 0 ]
# then
#       "that didnt quite work"
# fi

# if [ $? != 0 ]
# then
# 	"that didnt quite work"
# fi
