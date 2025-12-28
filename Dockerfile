# ---------- Final ----------
FROM ghcr.io/astral-sh/uv:python3.13-bookworm AS final

WORKDIR /app

# Copy the necessary files into the final stage
COPY . /app

# Install Node.js and dependencies
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates \
&& curl -fsSL https://deb.nodesource.com/setup_24.x | bash - \
&& apt-get install -y --no-install-recommends nodejs \
&& rm -rf /var/lib/apt/lists/* \
&& npm install @modelcontextprotocol/inspector@0.17.2

# Install Python dependencies
RUN pip install -r requirements.txt

RUN pip install mcp[cli]

CMD ["python", "main.py"]

EXPOSE 8000
