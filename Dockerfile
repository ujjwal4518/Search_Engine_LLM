FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Create a writable .streamlit config path
ENV XDG_CONFIG_HOME=/app/.streamlit
RUN mkdir -p /app/.streamlit

# Optionally disable telemetry (avoids writing logs)
RUN echo "[general]\nemail = \"\"\n" > /app/.streamlit/config.toml

# Copy your app files
COPY . .

# Expose Streamlit port
EXPOSE 8501

# Run the Streamlit app
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
