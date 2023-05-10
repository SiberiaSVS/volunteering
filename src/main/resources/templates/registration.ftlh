<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/normalize.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <link rel="stylesheet" href="/static/css/registration.css">
    <Title>Регистрация</Title>
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
            <li class="header__navigation-button"><a href="/login"><b>Войти</b></a></li>
        </#if>

        </div>
        </ul>
    </nav>
</header>
<main>
    <form action="/registration" method="post">
        <div class="registration">
            <h1>Регистрация</h1>
            <p>Пожалуйста, заполните эту форму, чтобы создать учетную запись.</p>
            <br>
            <label for="name"><b>ФИО или название организации</b></label>
            <input type="text" placeholder="Введите ФИО или название" name="name" required>

            <label for="phoneNumber"><b>Телефон</b></label>
            <input type="text" placeholder="Введите номер телефона" name="phoneNumber" required>

            <label for="email"><b>Email</b></label>
            <input type="email" placeholder="Введите Email" name="email" required>

            <label for="password"><b>Пароль</b></label>
            <input type="password" placeholder="Введите пароль" name="password" required>
            <br>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <div class="flexwrapper--center">
                <button type="submit" class="registration__button">Зарегистрироваться</button>
            </div>
            <div class="registration__signin">
                <p>Уже есть аккаунт? <a href="/login">Войти</a>.</p>
            </div>
        </div>
    </form>
    <#if errorMessage??>
        <h2 style="color: red">${errorMessage}</h2>
    </#if>
</main>
</body>
</html>
