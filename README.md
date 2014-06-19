# Dockerfile for FreshRSS

This file is destined to configure a virtual environment for FreshRSS. It is
based on Centos 6.

**Please note it is only for developers or testing!**

If you have some troubles to use this image, feel free to contact me at
dev@marienfressinaud.fr.


## In 3 steps

```
$ docker pull marienfressinaud/freshrss
$ git clone https://github.com/marienfressinaud/FreshRSS.git FreshRSS
$ docker run -t -i -v /path/to/FreshRSS:/var/www/html -p 8080:80 marienfressinaud/freshrss
```

In case of troubles, please refer to the rest of this document.


## In details
### Get the FreshRSS image

First get the Docker image on your PC:

```
$ docker pull marienfressinaud/freshrss
```

Or:

```
$ git clone https://github.com/marienfressinaud/docker-freshrss.git docker-freshrss
$ docker build -t marienfressinaud/freshrss docker-freshrss
```

### Get FreshRSS

Note image does NOT include FreshRSS source code! You should first get the code
from Github:

```
$ git clone https://github.com/marienfressinaud/FreshRSS.git FreshRSS
```

### Run a FreshRSS container

To use FreshRSS image, you should run it and mount your local FreshRSS
directory in the corresponding running container. Do not forgive to map port
```8080``` (or anyone else) on port ```80```:

```
$ docker run -t -i -v /path/to/FreshRSS:/var/www/html -p 8080:80 marienfressinaud/freshrss
```

Now, you have access to a shell where you can do whatever you want (you have a
root access!). In a basic usage, you should not have need of this shell. Just
keep it open and read the next section :)

- apache UID is 1000 and GID is 100. Note that you can have to change these
  values to match with owner of source code. To do that: ```usermod -u NEW_UID
  -g NEW_GID apache```
- Credentials for the MySQL database: ```root``` / ```bede```
- You have access to FreshRSS source code in ```/var/www/html``` (be careful, if you
  change it, it is changed on the host OS too)
- If you want to install new packages, remember you use a Centos: ```yum
  install``` command is your friend…


## Install FreshRSS
Last step is to install FreshRSS. Don't worry, you will not have to do that
next time.

1. Open a web browser on [127.0.0.1:8080](http://127.0.0.1:8080)
2. Follow the different steps. Only information for database matter:
	- Host: ```localhost```
	- Username: ```root```
	- Password: ```bede```
	- Base: ```freshrss```
	- Prefix: ```freshrss_```
3. Once FreshRSS is installed, enjoy!

Changements about feeds (e.g. adding a feed, refresh items) are not saved when
the container is stopped!


## Configure an alias

Command line to start FreshRSS container is a bit long. You can add an alias in
your ```.bashrc```:

```
alias start-freshrss='docker run -t -i -v /path/to/FreshRSS:/var/www/html -p 8080:80 marienfressinaud/freshrss'
```


### Keep container in background
You may have no need of a shell. You can change ```-t``` argument by ```-d```:

```
alias start-freshrss='docker run -d -i -v /path/to/FreshRSS:/var/www/html -p 8080:80 marienfressinaud/freshrss'
```
