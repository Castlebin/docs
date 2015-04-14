static void logger_monitor(void)
{
	fd_set read_set;
	struct timeval tv;
	int maxfd, nfd;
	int sa_msg_len = 0, sa_ioctl_len = 0, sa_telnet_len = 0, sa_client_len = 0;
	int msg_sock = IP_INVALID_SOCKET;
	int ioctl_sock = IP_INVALID_SOCKET;
       int telnet_sock = IP_INVALID_SOCKET;
	int client_sock = IP_INVALID_SOCKET;
	struct sockaddr_un sa_msg, sa_ioctl, sa_telnet;
	
	
  telnet_sock = ipcom_socket(IP_AF_UNIX, IP_SOCK_DGRAM, 0);
       
	if (telnet_sock == IP_INVALID_SOCKET)
	{
		goto err_out;
	}
    
	sa_telnet.sun_family = IP_AF_UNIX;
	ipcom_strncpy(sa_telnet.sun_path, LOG_TELNET_PATH, sizeof(sa_telnet.sun_path));
	sa_telnet_len = sizeof(sa_telnet.sun_family) + ipcom_strlen(sa_telnet.sun_path);
    
  ipcom_unlink(LOG_TELNET_PATH);
       
	if (ipcom_bind(telnet_sock, (const struct Ip_sockaddr *) &sa_telnet, sa_telnet_len) < 0) {
		LOGGER_DOUT_ERROR("bind error: %s", ipcom_strerror(ipcom_errno));
		goto err_out;
	}
    
	DOUT_TRACE("ipcom_listen...............");
	if (ipcom_listen(ioctl_sock, LOG_IOCTL_MAX_CLIENT) < 0) {
		LOGGER_DOUT_ERROR("listen error: %s", ipcom_strerror(ipcom_errno));
		goto err_out;
	}
	
	while(1)
	{
		FD_ZERO(&read_set);
    FD_SET(telnet_sock, &read_set);
    
    maxfd = IP_MAX(maxfd, telnet_sock);
              
		tv.tv_sec = 16;
		tv.tv_usec = 0;


		nfd = select(maxfd + 1, &read_set, NULL, NULL, &tv);

		if (nfd < 0)
		{
			LOGGER_DOUT_ERROR("select error");
			break;
		}
		else if (nfd == 0)
		{
			continue;
		}
        

		if (FD_ISSET(telnet_sock, &read_set))
		{
      char addr[32] = {'\0'};
      
			if (sizeof(logger_msg) != ipcom_recvfrom(telnet_sock, addr, sizeof(LOGGER_MSG), 0, IP_NULL, IP_NULL))
			{
          printf("msg = %s__\n", addr);
          DOUT_TRACE("msg = %s__\n", addr);
			}
			//printf("receive an  telnet log\n");
            

       LOGGER_ID_LOG2(UCM_MOD_ID_IPFILTER
                  , LOGGER_PRIORITY_NOTICE
                  , 10010001
                  , LOGGER_PARAM_IPV4, ipcom_inet_addr(addr)
                  , LOGGER_PARAM_STRING, "telnet");

		}
        
	}
	
	return;
}