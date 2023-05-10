<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/normalize.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <link rel="stylesheet" href="/static/css/preview.css">
    <title>Волентерский сервис</title>
</head>
<body>
<h1 class="hidden">Волентерский сервис</h1>
<header class="header">
    <nav>
        <ul class="header__navigation">
            <li class="header__navigation-logo"><a href="/"><img src="/static/img/Logo2.png" alt="Логотип компании"></a></li>
            <div class="header__navigation-buttons">
                <#if user.isAdmin()>
                <li class="header__navigation-button"><a href="/admin">Панель администратора</a></li>
            </#if>
                <li class="header__navigation-button"><a href="/"><b>Главная</b></a></li>
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
<main>
    <div class="preview">
        <h2>Стать частью движения</h2>
        <p>Чтобы стать частью волонтерского движения пройдите регистрацию</p>
        <div class="preview__buttons">
            <a href="/registration" class="preview__button">Присоединиться</a>
            <a href="/events" class="preview__button">Мероприятия</a>
        </div>
    </div>
</main>
<footer>

</footer>
</body>
</html>