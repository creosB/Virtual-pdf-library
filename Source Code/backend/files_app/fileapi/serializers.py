from rest_framework import serializers
from filetest import models

class FileSerializer(serializers.ModelSerializer):
    class Meta:
        fields = ('id', 'name', 'size', 'data')
        model = models.Files