# Generated by Django 4.1 on 2023-05-31 13:10

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("authapp", "0001_initial"),
    ]

    operations = [
        migrations.RemoveField(
            model_name="expense",
            name="date",
        ),
        migrations.AlterField(
            model_name="expense",
            name="amount",
            field=models.IntegerField(),
        ),
        migrations.AlterField(
            model_name="expense",
            name="id",
            field=models.BigAutoField(
                auto_created=True, primary_key=True, serialize=False, verbose_name="ID"
            ),
        ),
    ]
