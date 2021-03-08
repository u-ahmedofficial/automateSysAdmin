# automateSysAdmin
A Collection of scripts to automate the task of System Administrator in a Network.

##### For Mail Server Setup in Linux Follow
* Install the postfix, mailutils `sudo apt install mailutils && sudo apt install postfix`
* When it asks for domain (internet), insert any domain of your desire
* After installation edit: `sudo vi /etc/postfix/main.cf`
* In the `relayhost = [smtp.gmail.com]:587`
* You can insert any SMTP details of your choice.
* After every change reload postfix: `sudo postfix reload`
* Create file: `sudo vi /etc/postfix/sasl/sasl_passwd`
* Paste the username and password for account to be used. `[smtp.gmail.com]:587 umair@gmail.com:password123`
* Map the Password: `sudo postmap /etc/postfix/sasl/sasl_passwd`

##### USAGE
* For Single Email Syntax:
`echo "TEST EMAIL BODY" | mail -s "TEST EMAIL SUBJECT SMTP" umair@gmail.com`
* For Multiple Emails Syntax:
`echo "TEST EMAIL BODY" | mail -s "TEST EMAIL SUBJECT SMTP" umair@gmail.com ahmed@gmail.com`
* For CC Syntax: `echo "TEST EMAIL BODY" | mail -s "TEST EMAIL SUBJECT SMTP" umair@gmail.com ahmed@gmail.com -c khan@gmail.com` 
