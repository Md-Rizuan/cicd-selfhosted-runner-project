I have created three instances. 
one is for nginx rest two is for app-server and db server. 
all the instances was in same vpc and same security groups. But only nginx-server had the public ip rest of the two have only single private IP. We just forward nginx reverse froxy to app-server and db server. 


Architecture Setup was:
 Internet
                        |
                        v
          +---------------------------+
          |   Presentation Layer      |
          |      Nginx EC2 Server     |
          |      (Public Access)      |
          +---------------------------+
                        |
                        | Private Communication
                        v
          +---------------------------+
          |    Application Layer      |
          | Django + Gunicorn Server  |
          |        EC2 Instance       |
          +---------------------------+
                        |
                        | Private Communication
                        v
          +---------------------------+
          |       Data Layer          |
          |    PostgreSQL Server      |
          |        EC2 Instance       |
          +---------------------------+

          In here only nginx ec2 server will access from the public. 


          Nginx Server Security Group:

          HTTP:80
          Source:0.0.0.0/0
          SSH:22

          Application Server:
          Custom TCP:8000
          SSH:22
          Source: Nginx Security Group(Important)
          Db Server:
          PgSQL: 5432
          Source: Application Security Group


          Then I install required nginx, app in app server pulling from the gitlab then setup postgres in db server.

          Configure the django Database settings.

Connectiviy between layrs:

Browser
   ↓
Nginx Public IP
   ↓ port 8000
Django App Server
   ↓ port 5432
PostgreSQL Server


Nginx → Django App
proxy_pass http://172.31.15.163:8000;

All the screenshots here: 

https://drive.google.com/drive/folders/1B-OfVWj0z5YGI1a9KXIhgFrTUfxd0GJ7?usp=sharing