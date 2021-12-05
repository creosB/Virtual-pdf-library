from django.shortcuts import render
from rest_framework import generics
# my library
from filetest import models
from .serializers import FileSerializer

# Create your views here.

class FileList(generics.ListCreateAPIView):
    queryset = models.Files.objects.all()
    serializer_class = FileSerializer

class FileDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.Files.objects.all()
    serializer_class = FileSerializer