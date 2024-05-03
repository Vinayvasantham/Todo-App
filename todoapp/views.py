from django.shortcuts import render,redirect
from django.contrib.auth.models import User
from django.contrib.auth import authenticate,login,logout
from django.contrib import messages
from .models import todo
from django.contrib.auth.decorators import login_required

# Create your views here.
@login_required
def home(request):
    if request.method == "POST":
        task = request.POST.get('task')
        new_todo = todo(user= request.user, todo_name=task)
        new_todo.save()

        return redirect('homepage')

    all_todos = todo.objects.filter(user = request.user)
    context = {
        'todos' : all_todos
    }
    return render(request, 'todo.html', context)

def register(request):
    if request.user.is_authenticated:
        return redirect('homepage')
    if request.method == 'POST':
        username = request.POST.get('username')
        email = request.POST.get('email')
        password = request.POST.get('password')

        if len(password) < 3:
            messages.error(request, 'The password should be more than 3 characters')
            return redirect('register')
        
        get_user_name_by_username = User.objects.filter(username=username)
        if get_user_name_by_username:
            messages.error(request, 'Username already Exists')
            return redirect('register')

        new_user = User.objects.create_user(username=username, email=email, password=password)
        new_user.save()
        messages.success(request, 'User Created Successfully!')
        return redirect('login')
        
    return render(request, 'register.html', {})

def loginpage(request):
    if request.user.is_authenticated:
        return redirect('homepage')
    if request.method == "POST":
        username = request.POST.get('uname')
        password = request.POST.get('pass')

        validata_user = authenticate(username= username, password=password)
        if validata_user is not None:
            login(request, validata_user)
            return redirect('homepage')
        else:
            messages.error(request, 'User Not Found')
            return redirect('login')

    return render(request, 'login.html', {})

def LogoutPage(request):
    logout(request)
    return redirect('login')

@login_required
def delete(request, name):
    get_task = todo.objects.get(user = request.user, todo_name = name)
    get_task.delete()
    return redirect('homepage')

@login_required
def update(request,name):
    get_task = todo.objects.get(user = request.user, todo_name = name)
    get_task.status = True
    get_task.save()
    return redirect('homepage')

