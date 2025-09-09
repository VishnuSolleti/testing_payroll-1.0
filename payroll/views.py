from django.shortcuts import render
from django.http import HttpResponse
#hello world view for payroll app
def hello(request):
    return HttpResponse("Hello World from Payroll!")