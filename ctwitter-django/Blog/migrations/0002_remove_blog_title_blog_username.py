# Generated by Django 4.0.4 on 2022-07-31 17:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Blog', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='blog',
            name='title',
        ),
        migrations.AddField(
            model_name='blog',
            name='userName',
            field=models.CharField(default='ritwikjha', max_length=50),
            preserve_default=False,
        ),
    ]
