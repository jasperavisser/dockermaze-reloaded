
char create_mac(char* cmd, int cmd_len) {
	char mac = 0;
	for (int i = 0; i < cmd_len; i++) mac = mac ^ cmd[i];
	return mac;
}
