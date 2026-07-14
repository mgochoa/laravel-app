include .env
export

.PHONY: ssh

SSH := C:\WINDOWS\Sysnative\OpenSSH\ssh.exe

ssh:
	$(SSH) -i $(DEPLOY_SSH_KEY) $(DEPLOY_USER)@$(DEPLOY_HOST)
