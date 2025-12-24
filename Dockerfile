FROM python:3.11-slim

# ---- system deps + Node.js 22.x ----
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates git build-essential \
 && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
 && apt-get install -y --no-install-recommends nodejs \
 && rm -rf /var/lib/apt/lists/*

# ---- python deps ----
RUN pip install --no-cache-dir uv

WORKDIR /app
COPY . /app

# ---- install project deps (repo provides this) ----
RUN npm run setup:all

# ---- show versions in build logs (helpful) ----
RUN node -v && npm -v && python -V

EXPOSE 3000 5001

CMD ["npm", "run", "dev"]
