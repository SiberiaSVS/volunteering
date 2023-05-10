<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/normalize.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <link rel="stylesheet" href="/static/css/create-event.css">
    <title>Новое мероприятие</title>
</head>
<body>
<header class="header">
    <nav>
        <ul class="header__navigation">
            <li class="header__navigation-logo"><a href="/"><img src="/static/img/Logo2.png" alt="Логотип компании"></a></li>
            <div class="header__navigation-buttons">
                <#if user.isAdmin()>
                <li class="header__navigation-button"><a href="/admin">Панель администратора</a></li>
            </#if>
            <li class="header__navigation-button"><a href="/">Главная</a></li>
            <li class="header__navigation-button"><a href="/events">Мероприятия</a></li>
            <#if user.email??>
            <li class="header__navigation-button"><a href="/profile"><b>Профиль</b></a></li>
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
<form action="/event/create" method="post" enctype="multipart/form-data">
    <div class="form">
        <h1>Добавление мероприятия</h1>
        <p>Пожалуйста, заполните эту форму, чтобы добавить новое мероприятие.</p>
        <br>
        <label for="title"><b>Название мероприятия</b></label>
        <input type="text" placeholder="Введите название мероприятия" name="title" required>
        <label for="city"><b>Город</b></label>
        <input type="text" placeholder="Введите город" name="city" required>
        <label for="date"><b>Дата проведения</b></label>
        <input type="text" placeholder="Введите дату" name="date" required>
        <p>Добавьте изображения (Размер не должен перевышать 1МБ)</p>
        <div class="file-wrapper">
            <input type="file" name="file1">
        </div>
        <div class="file-wrapper">
            <input type="file" name="file2">
        </div>
        <div class="file-wrapper">
            <input type="file" name="file3">
        </div>
        <div class="file-wrapper">
            <input type="file" name="file4">
        </div>
        <div class="file-wrapper">
            <input type="file" name="file5">
        </div>
        <label for="description"><b>Описание</b></label>
        <textarea name="description" required rows="10"></textarea>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <div class="flexwrapper--center">
            <button type="submit" class="registration__button">Добавить</button>
        </div>
    </div>
</form>
</body>
</html>