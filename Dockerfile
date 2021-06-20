FROM python:3.6-slim
MAINTAINER "Akash Patil"

RUN mkdir /app
COPY app.py /app
COPY requirements.txt /app
WORKDIR /app
RUN pip install -r requirements.txt
ENTRYPOINT ["python"] 
CMD ["app.py"]