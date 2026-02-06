FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY cloudrun_requirements.txt ./
RUN pip install --no-cache-dir -r cloudrun_requirements.txt

COPY cloudrun_app.py demo_tasks.py ./

ENV PORT=8080

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "cloudrun_app:app"]
