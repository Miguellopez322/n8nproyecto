FROM python:3.11-slim
 
WORKDIR /scripts
 
# Instalar librerías de Python
RUN pip install --no-cache-dir requests pandas python-docx openpyxl matplotlib
 
# Instalar Nano y Vim
RUN apt-get update && apt-get install -y openssh-server nano && rm -rf /var/lib/apt/lists/*
 
# Instalar OpenSSH
RUN apt-get update && apt-get install -y openssh-server && rm -rf /var/lib/apt/lists/*
 
# Crear usuario para SSH
RUN useradd -m -s /bin/bash pythonuser
RUN echo "pythonuser:TuPasswordAqui" | chpasswd
 
# Crear carpeta para SSH (no falla si ya existe)
RUN mkdir -p /var/run/sshd
 
# Permitir login con password
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
 
# Exponer el puerto SSH
EXPOSE 22
 
# Comando para mantener el contenedor corriendo y levantar SSH
CMD ["/usr/sbin/sshd","-D"]