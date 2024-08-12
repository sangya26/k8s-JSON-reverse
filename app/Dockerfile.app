FROM python:3.12-slim

WORKDIR /usr/src/app

RUN pip install flask

COPY . /usr/src/app/

EXPOSE 5000

CMD ["python", "app.py"]
