FROM python:3.11-slim

# Variables d'environnement
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PIP_TRUSTED_HOST=pypi.org files.pythonhosted.org

# Création et définition du répertoire de travail
WORKDIR /app

# Installation des dépendances système et des certificats
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        gcc \
        python3-dev \
        libc-dev \
        ca-certificates \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Installation des dépendances Python avec --trusted-host
COPY requirements.txt .
RUN pip install --no-cache-dir --trusted-host pypi.org --trusted-host files.pythonhosted.org -r requirements.txt

# Copie du projet
COPY . .

# Port à exposer
EXPOSE 8000

# Commande par défaut
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]