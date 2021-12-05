from django.urls import path

from .views import FileList, FileDetail

urlpatterns = [
    path('',FileList.as_view()),
    path('<int:pk>/',FileDetail.as_view()), # individual items from django
]