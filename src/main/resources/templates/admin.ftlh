<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/normalize.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <link rel="stylesheet" href="/static/css/admin.css">
    <title>Профиль</title>
</head>
<body>
<header class="header">
    <nav>
        <ul class="header__navigation">
            <li class="header__navigation-logo"><a href="/"><img src="/static/img/Logo2.png" alt="Логотип компании"></a></li>
            <div class="header__navigation-buttons">
                <#if user.isAdmin()>
                <li class="header__navigation-button"><a href="/admin"><b>Панель администратора</b></a></li>
            </#if>
            <li class="header__navigation-button"><a href="/">Главная</a></li>
            <li class="header__navigation-button"><a href="/events">Мероприятия</a></li>
            <#if user.email??>
            <li class="header__navigation-button"><a href="/profile">Профиль</a></li>
            <li class="header__navigation-button"><form action="/logout" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Выйти" class="exit-button">
            </form>
            </li>
            <#else>
            <li class="header__navigation-button"><a href="/login">Войти</a></li>
        </#if>

        </div>
        </ul>
    </nav>
</header>
<h1>Панель администратора</h1>
<button onclick="change()" id="change-button">Показать мероприятия</button>
<div id="table-users">
    <h2>Пользователи</h2>
    <table>
        <tr>
            <th>id</th>
            <th>Email</th>
            <th>Номер телефона</th>
            <th>Активность</th>
            <th>Роли</th>
            <th>Бан</th>
            <th>Редактирование</th>
            <th>Подробная информация</th>
            <th>Удалить</th>
        </tr>
        <#list users as user>
        <tr>
            <td>${user.id}</td>
            <td>${user.email}</td>
            <td>${user.phoneNumber}</td>
            <td><#if user.active>Да<#else>Нет</#if></td>
            <td><#list user.roles as role>${role}<#sep>, </#list></td>
            <td><form action="/admin/user/ban/${user.id}" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Ban">
            </form></td>
            <td><a href="/admin/user/edit/${user.id}">Редактирование</a></td>
            <td><a href="/user/${user.id}">Подробная информация</a></td>
            <td>
                <form action="/admin/user/delete/${user.id}" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <input type="image" src="img/icon-garbage.png" class="event__delete-icon">
                </form>
            </td>
        </tr>
        <#else>
        <p>Пользователей нет</p>
        </#list>

    </table>
</div>
<div id="table-events">
    <h2>Мероприятия</h2>
    <table>
        <tr>
            <th>id</th>
            <th>Название</th>
            <th>Автор</th>
            <th>Город</th>
            <th>Дата</th>
            <th>Подробнее</th>
            <th>Удалить</th>
        </tr>
        <#list events as event>
        <tr>
            <td>${event.id}</td>
            <td>${event.title}</td>
            <td>${event.user.name}</td>
            <td>${event.city}</td>
            <td>${event.date}</td>
            <td><a href="/event/${event.id}">Подробнее</a></td>
            <td>
                <form action="/admin/event/delete/${event.id}" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <input type="image" src="img/icon-garbage.png" class="event__delete-icon">
                </form>
            </td>
        </tr>
        <#else>
            <p>Мероприятий нет</p>
        </#list>
    </table>
</div>
<script>
        var bool = true;
        function change() {
            bool = !bool;
            var users = document.getElementById("table-users");
            var events = document.getElementById("table-events");
            var changeButton = document.getElementById("change-button");
            if (bool) {
                users.style.display = "block";
                events.style.display = "none";
                changeButton.innerHTML = "Показать мероприятия";
            } else {
                users.style.display = "none";
                events.style.display = "block";
                changeButton.innerHTML = "Показать пользователей";
            }
        }
    </script>
</body>
</html>