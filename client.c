/* client.c */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <math.h>

#define MAXLINE 80
#define SERV_PORT 30000

int main(int argc, char *argv[])
{
	struct sockaddr_in servaddr;
	char buf[MAXLINE];
	int sockfd, n;

	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	bzero(&servaddr, sizeof(servaddr));
	servaddr.sin_family = AF_INET;
	inet_pton(AF_INET, "192.168.2.23", &servaddr.sin_addr);
	servaddr.sin_port = htons(SERV_PORT);
	connect(sockfd, (struct sockaddr *)&servaddr, sizeof(servaddr));
	
	long long int i=0;
	double temp = 0;
	
	
	while(1){
		temp = sin(i*3.14f/1000.0f);
		write(sockfd, &temp, 8);
		sleep(0.001);
		i++;
	}
	
	
	close(sockfd);
	return 0;
}
