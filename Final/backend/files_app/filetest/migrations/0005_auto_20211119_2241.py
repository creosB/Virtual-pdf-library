# Generated by Django 3.0.3 on 2021-11-19 19:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('filetest', '0004_auto_20211119_2234'),
    ]

    operations = [
        migrations.AlterField(
            model_name='files',
            name='data',
            field=models.TextField(),
        ),
    ]
