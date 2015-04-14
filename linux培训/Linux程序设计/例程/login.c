#include <sys/types.h>
#include <sys/socket.h> /* netinet/in.h needs it */
#include <netinet/in.h>
#include <net/if.h>
#include <sys/un.h>


#define LOG_TELNET_PATH 	"/tmp/logger_telnet"


int login_main(int argc UNUSED_PARAM, char **argv)
{

	    struct sockaddr_un sa;
	    struct sockaddr_un server_sa;
	    int sa_len = 0;
	    int server_sa_len = 0;
	    int local_sock = -1;
        
	    sa.sun_family = AF_UNIX;
	    sa_len = sprintf(sa.sun_path, LOG_TELNET_PATH"_%lx_%lx", getpid(), time(NULL));
	    sa_len += sizeof(sa.sun_family);
	
	    server_sa.sun_family = AF_UNIX;
	    strncpy(server_sa.sun_path, LOG_TELNET_PATH, sizeof(server_sa.sun_path));
	    server_sa_len = sizeof(server_sa.sun_family) + strlen(server_sa.sun_path);

	    local_sock = socket(AF_UNIX, SOCK_DGRAM, 0);

	    if (-1 == local_sock)
	    {
	         unlink(sa.sun_path);
           close(local_sock);
           return EXIT_FAILURE;
	    }

	    if (0 > bind(local_sock, (struct sockaddr *) &sa, sa_len))
	    {
      	    unlink(sa.sun_path);
            close(local_sock);
            return EXIT_FAILURE;
	    }
    
             int num;
            struct in_addr addr;
            inet_aton(log_msg, &addr);

            num = sendto(local_sock, &addr, sizeof(struct in_addr), 0, (const struct sockaddr*)&server_sa, server_sa_len);
            
           if (num != sizeof(struct in_addr))
            {
                unlink(sa.sun_path);
                close(local_sock);
                return EXIT_FAILURE;
            }
        
            unlink(sa.sun_path);
            close(local_sock);
        }


}
