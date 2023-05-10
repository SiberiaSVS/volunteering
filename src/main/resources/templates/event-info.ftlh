<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/normalize.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <link rel="stylesheet" href="/static/css/event-info.css">
    <title>Мероприятие</title>
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
    <a href="/events" class="backlink">&lt; к мероприятиям</a>
    <h1>${event.title}</h1>
    <div class="event-head">
        <div class="container">
            <div class="slider-wrapper">
                <div class="slider">
                    <#list images as img>
                        <img src="/images/${img.id}" id="slide-${img?counter}" alt="Картинка мероприятия"/>
                    </#list>
                </div>
                <div class="slider-nav">
                    <#list images as img>
                        <a href="#slide-${img?counter}"></a>
                    </#list>
                </div>
            </div>
        </div>
        <div class="information">
            <div class="information__information-text">
                <img src="/static/img/icon-user.png" alt="Иконка">
                <p><a href="/user/${event.user.id}" class="information__link">${event.user.name}</a></p>
            </div>
            <div class="information__information-text">
                <img src="/static/img/icon-time-and-date.png" alt="Иконка">
                <p>${event.date}</p>
            </div>
            <div class="information__information-text">
                <img src="/static/img/icon-location-pin.png" alt="Иконка">
                <p>${event.city}</p>
            </div>
        </div>
        <div class="contacts">
            <h3>Контакты</h3>
            <p><a href="tel:${event.user.phoneNumber}" class="information__link">${event.user.phoneNumber}</a></p>
            <p><a href="mailto:${event.user.email}" class="information__link">${event.user.email}</a></p>
        </div>
    </div>
    <div class="description">
        <p>${event.description}</p>
    </div>
</main>
</body>
</html>