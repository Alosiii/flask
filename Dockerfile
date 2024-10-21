FROM python:3.12-slim

WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN pip install --upgrade pip

COPY requirements.txt /usr/src/app/requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

RUN useradd -ms /bin/bash celeryuser

COPY . /usr/src/app

ENV FLASK_APP=/usr/src/app/app.py

EXPOSE 5000

USER celeryuser

CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "--timeout",  "120", "app:app"]