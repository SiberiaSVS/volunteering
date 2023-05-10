<!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/normalize.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <link rel="stylesheet" href="/static/css/events.css">
    <title>Мероприятия</title>
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
            <li class="header__navigation-button"><a href="/events"><b>Мероприятия</b></a></li>
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
    <h1>Мероприятия</h1>
    <form action="/events" method="get" class="search">
        <b>Поиск по городу</b>
        <div class="search__border">
            <form action="/" method="get">
                <input type="text" name="city">
                <input type="image" src="/static/img/icon-search.png" value=""/>
            </form>
        </div>
    </form>
    <#list events as event>
    <section class="event">
        <img src="images/${event.previewImageId}" alt="Фото Мероприятия" class="event__image">
        <div class="event__information">
            <h1>${event.title}</h1>
            <div class="event__information-text">
                <img src="/static/img/icon-user.png" alt="Иконка">
                <p>${event.user.name}</p>
            </div>
            <div class="event__information-text">
                <img src="/static/img/icon-time-and-date.png" alt="Иконка">
                <p>${event.date}</p>
            </div>
            <div class="event__information-text">
                <img src="/static/img/icon-location-pin.png" alt="Иконка">
                <p>${event.city}</p>
            </div>
            <p>${event.description}</p>
            <p><a href="/event/${event.id}">Подробнее...</a></p>
        </div>
    </section>
    <#else>
    <h3>Мероприятий не найдено</h3>
</#list>
</main>
</body>

</html>