#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/file.h>
#include "ancistrus.h"
#include "common.h"

int lock(const char *lock_path) {
int fd, i;

if((fd=open(lock_path, O_CREAT|O_WRONLY|O_TRUNC,S_IRUSR|S_IWUSR))<0) return -1;
	for(i=0;i<LOCK_TIMEOUT;i++) {				//give a termination tryout time loop
		if(!lockf(fd, F_LOCK, 0)) {			//lock success
		DBG("Lock file: %s succeeded at cycle: %d, fd lock: %d\n", lock_path, i+1, fd);
		return fd;
		}
		else usleep(1000000);				//delay for another cycle
	}
close(fd);							//can't lock: close fd & return fail code
return -1;
}

int unlock(int fd, const char *lock_path) {
int err=1;

	if(fd>=0) {
	err=lockf(fd, F_ULOCK, 0);
	close(fd);
	unlink(lock_path);
	DBG("fd: %d unlock() returning code: %d\n", fd, err);
	}
return err;
}

int checknumrange(const char* value, int start, int end) {
char num[20];

if(value != NULL) snprintf(num, sizeof(num), "%d", atoi(value));
if(value == NULL || strcmp(value, num) || atoi(value)<start || atoi(value)>end) return 1;
else return 0;
}

int checkportrange(char* portrange, char separator) {
char ports[12], *startport, *endport;
int err=0;

	if(portrange == NULL) err=1;
	else {
	strncpy(ports, portrange, sizeof(ports));				//save orig portrange
	startport=ports;
		if((endport=strchr(ports, separator)) == NULL) err=1;		//separate start & end port: separator miss is error
		else {
		*(endport++)='\0';						//chop separator & point to end port
			if(atoi(startport) > atoi(endport)) err=1;		//avoid inverted interval
			else {
			err+=checkport(startport);				//check ports
			err+=checkport(endport);
			}
		}
	}
return err;
}

