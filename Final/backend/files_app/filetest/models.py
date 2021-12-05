from django.db import models
# Create your models here.


class Files(models.Model):
    name = models.CharField(max_length=200)
    size = models.CharField(max_length=200)
    data = models.TextField()

    def __str__(self):
        return self.name
