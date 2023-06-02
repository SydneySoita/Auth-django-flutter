from django.db import models

# Create your models here.

from django.db import models
from django.db import models



class Expense(models.Model):
    title = models.CharField(max_length=100)
    amount = models.IntegerField()
    description = models.CharField(max_length=100)
    category = models.CharField(max_length = 50)
    # date = models.DateField()
    # id = models.IntegerField(max_length=100,primary_key=True)


# 